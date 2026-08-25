import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'dart:io';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_payment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_payments_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/patient_details/patient_details_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/add_treatment_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_files_section.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/edit_costs_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_money_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/clinical_alerts_strip.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_case_actions.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_detail_states.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_info_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_scroll_header.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatments_section.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/payment_history_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'completed_case_page.dart';
import 'treatment_plan_view_page.dart';

/// Patient details, rebuilt as one scroll.
///
/// The three tabs are gone: money, plan, files and info are positions on a
/// single surface with a pinned vitals bar and an anchor rail. Nothing was
/// removed - the groupings survive, they just no longer cost a tap to compare.
class PatientDetailsPage extends StatelessWidget {
  final String patientId;
  final String patientName;
  final int? tabIndex;
  final TreatmentPlan? prototypePlan;

  const PatientDetailsPage({
    super.key,
    required this.patientId,
    required this.patientName,
    this.tabIndex,
    this.prototypePlan,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PatientDetailsBloc>()
            ..add(PatientDetailsEvent.loadPatientDetails(patientId)),
      child: _PatientDetailsContent(
        patientId: patientId,
        patientName: patientName,
        prototypePlan: prototypePlan,
      ),
    );
  }
}

class _PatientDetailsContent extends StatefulWidget {
  final String patientId;
  final String patientName;
  final TreatmentPlan? prototypePlan;

  const _PatientDetailsContent({
    required this.patientId,
    required this.patientName,
    this.prototypePlan,
  });

  @override
  State<_PatientDetailsContent> createState() => _PatientDetailsContentState();
}

class _PatientDetailsContentState extends State<_PatientDetailsContent> {
  final _scroll = ScrollController();

  final _caseKey = GlobalKey();
  final _treatmentsKey = GlobalKey();
  final _filesKey = GlobalKey();
  final _infoKey = GlobalKey();

  PatientAnchor _active = PatientAnchor.caseSection;

  List<Tooth> _teeth = [];
  List<CoreTreatment> _coreTreatments = [];

  /// Local mirror of the case attachments so an in-flight upload can show a
  /// thumbnail with a spinner before the server knows about it.
  List<CaseAttachment> _attachments = [];
  String? _attachmentsCaseId;

  /// Done-state applied locally by [_toggleDone], keyed by plan item id.
  /// Lets the check flip immediately instead of waiting on a page reload;
  /// cleared whenever the bloc hands us a genuinely new case.
  final Map<String, bool> _doneOverrides = {};

  @override
  void initState() {
    super.initState();
    _loadTeeth();
    _loadCoreTreatments();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _loadTeeth() async {
    final result = await getIt<GetAllTeethUseCase>()(NoParams());
    result.fold((_) {}, (teeth) {
      if (mounted) setState(() => _teeth = teeth);
    });
  }

  Future<void> _loadCoreTreatments() async {
    final result = await getIt<GetAllCoreTreatmentsUseCase>()(NoParams());
    result.fold((_) {}, (treatments) {
      if (mounted) setState(() => _coreTreatments = treatments);
    });
  }

  void _reload() => context.read<PatientDetailsBloc>().add(
    PatientDetailsEvent.loadPatientDetails(widget.patientId),
  );

  /// Pull-to-refresh: the case, its attachments and the treatment catalogue
  /// all come from separate calls, so all three are re-run together.
  Future<void> _refresh() async {
    final bloc = context.read<PatientDetailsBloc>();
    _reload();
    await Future.wait([
      _loadCoreTreatments(),
      bloc.stream.settled(
        (state) => state.maybeWhen(loading: () => false, orElse: () => true),
      ),
    ]);
  }

  void _error(Object e) {
    if (!mounted) return;
    AppSnackbar.showError(
      context,
      title: AppLocalizations.of(context)!.error,
      message: e is NetworkExceptions
          ? NetworkExceptions.getErrorMessage(e)
          : e.toString(),
    );
  }

  void _ok(String message) {
    if (!mounted) return;
    AppSnackbar.showSuccess(
      context,
      title: AppLocalizations.of(context)!.success,
      message: message,
    );
  }

  // ── anchors ─────────────────────────────────────────────────────────────

  void _jumpTo(PatientAnchor anchor) {
    final key = switch (anchor) {
      PatientAnchor.caseSection => _caseKey,
      PatientAnchor.treatments => _treatmentsKey,
      PatientAnchor.files => _filesKey,
      PatientAnchor.info => _infoKey,
    };
    final ctx = key.currentContext;
    if (ctx == null) return;
    setState(() => _active = anchor);
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      // Clear the pinned vitals bar.
      alignment: 0.0,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  // ── treatments ──────────────────────────────────────────────────────────

  List<PlannedTreatment> _mapPlanned(DentalCase c) {
    final result = <PlannedTreatment>[];
    for (final item in c.treatmentItems) {
      final toothCodes = item.selectedTeeth
          .map((id) {
            final match = _teeth.where((t) => t.id == id);
            return match.isNotEmpty ? match.first.universalCode : null;
          })
          .whereType<String>()
          .toList();

      for (final typeId in item.treatmentTypes) {
        final ct = _coreTreatments.where((t) => t.id == typeId);
        final typeInfo = ct.isNotEmpty
            ? TreatmentTypeInfo(
                id: ct.first.id,
                name: ct.first.name,
                icon: Icons.medical_services_outlined,
                categoryId: ct.first.category.id,
                categoryName: ct.first.category.name,
              )
            : TreatmentTypeInfo(
                id: typeId,
                name: typeId,
                icon: Icons.medical_services_outlined,
                categoryId: '',
                categoryName: '',
              );

        final visitNotes = item.notes.map((n) {
          final dateStr = n['date'] ?? '';
          final date = dateStr.isNotEmpty
              ? DateTime.tryParse(dateStr) ?? DateTime.now()
              : DateTime.now();
          return VisitNote(date: date, text: n['note'] ?? '');
        }).toList();

        // A pending or already-confirmed toggle wins over the bloc's copy,
        // which is only refreshed when the whole page reloads.
        final done = _doneOverrides[item.id] ?? item.isDone;

        result.add(
          PlannedTreatment(
            id: '${item.id}_$typeId',
            type: typeInfo,
            toothNumber: toothCodes.isNotEmpty ? toothCodes.join(', ') : null,
            status: done
                ? TreatmentPlanStatus.completed
                : TreatmentPlanStatus.planned,
            notes: item.description,
            visitNotes: visitNotes,
          ),
        );
      }
    }
    return result;
  }

  /// Treatment ids are `itemId_typeId`; the API only wants the item id.
  String _itemId(PlannedTreatment t) => t.id.split('_').first;

  /// Marking work done is the most frequent action on this screen, so it
  /// updates in place and syncs behind the scenes. A full reload here threw
  /// the skeleton up and lost the scroll position on every tick.
  Future<void> _toggleDone(DentalCase c, PlannedTreatment t) async {
    final itemId = _itemId(t);
    final wasDone = t.status == TreatmentPlanStatus.completed;

    setState(() => _doneOverrides[itemId] = !wasDone);

    final result = await getIt<PatientRepository>()
        .toggleTreatmentPlanItemStatus(
          patientId: widget.patientId,
          caseId: c.id,
          itemId: itemId,
        );
    if (!mounted) return;
    result.fold((e) {
      // Put the check back where it was rather than leaving a lie on screen.
      setState(() => _doneOverrides[itemId] = wasDone);
      _error(e);
    }, (_) {});
  }

  Future<void> _addNote(DentalCase c, PlannedTreatment t, String note) async {
    final now = DateTime.now();
    final notes = [
      ...t.visitNotes.map(
        (n) => {
          'note': n.text,
          'date':
              '${n.date.year}-${n.date.month.toString().padLeft(2, '0')}'
              '-${n.date.day.toString().padLeft(2, '0')}',
        },
      ),
      {
        'note': note,
        'date':
            '${now.year}-${now.month.toString().padLeft(2, '0')}'
            '-${now.day.toString().padLeft(2, '0')}',
      },
    ];

    final result = await getIt<PatientRepository>().updateTreatmentPlanItem(
      patientId: widget.patientId,
      caseId: c.id,
      itemId: _itemId(t),
      notes: notes,
    );
    result.fold(_error, (_) {
      _ok(AppLocalizations.of(context)!.notesUpdated);
      _reload();
    });
  }

  Future<void> _removeTreatment(DentalCase c, PlannedTreatment t) async {
    final result = await getIt<PatientRepository>().deleteTreatmentPlanItem(
      patientId: widget.patientId,
      caseId: c.id,
      itemId: _itemId(t),
    );
    result.fold(
      (e) {
        _error(e);
        _reload();
      },
      (_) {
        _ok(AppLocalizations.of(context)!.treatmentRemoved);
        _reload();
      },
    );
  }

  Future<void> _addTreatment(DentalCase activeCase) async {
    final categories = mapCoreTreatments(_coreTreatments)
      ..sort((a, b) {
        final aGeneral = a.name.contains('عامة');
        final bGeneral = b.name.contains('عامة');
        if (aGeneral && !bGeneral) return 1;
        if (!aGeneral && bGeneral) return -1;
        return 0;
      });

    final picked = await AddTreatmentSheet.show(
      context,
      categories: categories,
      teeth: _teeth,
    );
    if (picked == null || picked.isEmpty || !mounted) return;

    final typeIds = picked.map((t) => t.type.id).toList();
    final toothIds = picked
        .where((t) => t.toothNumber != null)
        .map((t) {
          final match = _teeth.where((x) => x.universalCode == t.toothNumber);
          return match.isNotEmpty ? match.first.id : null;
        })
        .whereType<String>()
        .toSet()
        .toList();

    final l10n = AppLocalizations.of(context)!;
    AppLoadingDialog.show(context: context, message: l10n.saving);

    final result = await getIt<AddTreatmentUseCase>()(
      AddTreatmentParams(
        patientId: widget.patientId,
        isInitial: false,
        caseId: activeCase.id,
        visitDate: DateTime.now(),
        treatmentTypes: typeIds,
        selectedTeeth: toothIds,
        summary: null,
        totalCost: 0,
        labFees: 0,
        attachments: const [],
      ),
    );

    if (!mounted) return;
    AppLoadingDialog.dismiss(context);
    result.fold(_error, (_) {
      _ok(l10n.treatmentAddedSuccessfully);
      _reload();
    });
  }

  // ── money ───────────────────────────────────────────────────────────────

  Future<List<Payment>> _loadPayments(String caseId) async {
    final result = await getIt<GetPaymentsUseCase>()(
      GetPaymentsParams(patientId: widget.patientId, caseId: caseId),
    );
    return result.fold((_) => <Payment>[], (p) => p);
  }

  void _recordPayment(DentalCase c) {
    RecordPaymentPopup.show(
      context,
      patientName: c.patientName,
      caseTitle: c.title,
      totalCost: c.totalCost,
      paidAmount: c.paidAmount,
      caseCurrencyId: c.totalCostCurrencyId,
      caseCurrencyCode: c.totalCostCurrencyCode,
      onSave:
          (
            amount,
            currencyId,
            caseCurrencyId,
            amountInCaseCurrency,
            exchangeRate,
            notes,
          ) async {
            final result = await getIt<AddPaymentUseCase>()(
              AddPaymentParams(
                patientId: widget.patientId,
                caseId: c.id,
                amount: amount,
                currencyId: currencyId,
                caseCurrencyId: caseCurrencyId,
                amountInCaseCurrency: amountInCaseCurrency,
                exchangeRate: exchangeRate,
                notes: notes,
              ),
            );
            final err = result.fold<NetworkExceptions?>((l) => l, (_) => null);
            if (err != null) {
              throw Exception(NetworkExceptions.getErrorMessage(err));
            }
            if (mounted) _reload();
          },
    );
  }

  void _paymentHistory(DentalCase c) {
    PaymentHistoryPopup.show(
      context,
      caseTitle: c.title,
      onLoadPayments: () => _loadPayments(c.id),
      totalCost: c.totalCost,
      paidAmount: c.paidAmount,
    );
  }

  void _editCosts(DentalCase c) {
    EditCostsSheet.show(
      context,
      initialTotalCost: c.totalCost,
      initialLabFees: c.labFees,
      initialTotalCostCurrencyId: c.totalCostCurrencyId,
      initialLabFeesCurrencyId: c.labFeesCurrencyId,
      onSave: (totalCost, totalCurrencyId, labFees, labCurrencyId) async {
        final result = await getIt<PatientRepository>().updateCaseCosts(
          patientId: widget.patientId,
          caseId: c.id,
          totalCost: totalCost,
          totalCostCurrencyId: totalCurrencyId,
          labFees: labFees,
          labFeesCurrencyId: labCurrencyId,
        );
        result.fold(_error, (_) {
          _ok(AppLocalizations.of(context)!.costsUpdated);
          _reload();
        });
      },
    );
  }

  Future<void> _finishCase(DentalCase c, int unfinished) async {
    final confirmed = await FinishCaseDialog.show(
      context,
      outstanding: c.pendingAmount,
      unfinishedTreatments: unfinished,
      currencyCode: c.totalCostCurrencyCode ?? '',
    );
    if (!confirmed || !mounted) return;
    context.read<PatientDetailsBloc>().add(
      PatientDetailsEvent.markCaseAsFinished(
        patientId: widget.patientId,
        caseId: c.id,
        title: null,
      ),
    );
  }

  // ── attachments ─────────────────────────────────────────────────────────

  void _syncAttachments(DentalCase c) {
    // Rebuild the local mirror only when the case changes, so an in-flight
    // upload is not wiped by an unrelated bloc emission.
    if (_attachmentsCaseId == c.id) return;
    _attachmentsCaseId = c.id;
    // Different case, so the optimistic done-flags belong to nothing.
    _doneOverrides.clear();
    // Seed from whatever the case payload carried so the strip is not empty
    // while the authoritative read is in flight.
    // No `remoteId`: the case payload lists media ids, not rows on the
    // attachments sub-resource, and the DELETE route only accepts the
    // latter. Delete stays hidden on a seeded item until the authoritative
    // read below replaces it with a row that carries a real id.
    _attachments = c.attachments
        .map(
          (id) =>
              CaseAttachment(id: id, url: id.startsWith('http') ? id : null),
        )
        .toList();
    // Called from build(), so the network read has to wait for the frame.
    Future.microtask(() => _fetchAttachments(c.id));
  }

  Future<void> _fetchAttachments(String caseId) async {
    final result = await getIt<PatientRepository>().getCaseAttachments(
      patientId: widget.patientId,
      caseId: caseId,
    );
    if (!mounted || _attachmentsCaseId != caseId) return;
    // Deliberately silent on failure: the seeded list still renders, and a
    // toast on every page open would be noise rather than information.
    result.fold((_) {}, (rows) {
      setState(() {
        final pending = _attachments
            .where((a) => a.uploading || a.failed)
            .toList();
        _attachments = [
          ...rows.map(
            (r) => CaseAttachment(
              id: r.mediaId ?? r.id,
              remoteId: r.attachmentId,
              url: r.url,
              name: r.name,
            ),
          ),
          ...pending,
        ];
      });
    });
  }

  void _markFailed(String placeholderId) {
    setState(() {
      _attachments = _attachments
          .map(
            (a) => a.id != placeholderId
                ? a
                : a.copyWith(uploading: false, failed: true),
          )
          .toList();
    });
  }

  Future<void> _uploadTo(DentalCase c, File file) async {
    final placeholder = CaseAttachment(
      id: 'local_${DateTime.now().microsecondsSinceEpoch}',
      name: file.path.split(Platform.pathSeparator).last,
      localFile: file,
      uploading: true,
    );
    setState(() => _attachments = [..._attachments, placeholder]);

    final mediaId = await uploadCaseFile(file);
    if (!mounted) return;
    if (mediaId == null) {
      _markFailed(placeholder.id);
      return;
    }

    final result = await getIt<PatientRepository>().addCaseAttachments(
      patientId: widget.patientId,
      caseId: c.id,
      mediaIds: [mediaId],
    );
    if (!mounted) return;

    await result.fold(
      (e) async {
        _markFailed(placeholder.id);
        _error(e);
      },
      (_) async {
        // Drop the uploading flag first: _fetchAttachments keeps only
        // in-flight items, so this lets the server row take its place.
        setState(() {
          _attachments = _attachments
              .map(
                (a) =>
                    a.id != placeholder.id ? a : a.copyWith(uploading: false),
              )
              .toList();
        });
        await _fetchAttachments(c.id);
      },
    );
  }

  Future<void> _addFile(DentalCase c) async {
    final files = await AddFileSheet.show(context);
    if (files == null || files.isEmpty || !mounted) return;
    // One at a time - a gallery multi-select can be a dozen photos and the
    // media endpoint should not take them all at once.
    for (final file in files) {
      await _uploadTo(c, file);
      if (!mounted) return;
    }
  }

  Future<void> _retryUpload(DentalCase c, CaseAttachment a) async {
    if (a.localFile == null) return;
    setState(() => _attachments.remove(a));
    await _uploadTo(c, a.localFile!);
  }

  Future<void> _deleteAttachment(DentalCase c, CaseAttachment a) async {
    final remoteId = a.remoteId;
    if (remoteId == null) return;

    final snapshot = _attachments;
    setState(
      () => _attachments = _attachments.where((x) => x.id != a.id).toList(),
    );

    final result = await getIt<PatientRepository>().deleteCaseAttachment(
      patientId: widget.patientId,
      caseId: c.id,
      attachmentId: remoteId,
    );
    if (!mounted) return;
    result.fold((e) {
      setState(() => _attachments = snapshot);
      _error(e);
    }, (_) => _ok(AppLocalizations.of(context)!.fileRemoved));
  }

  // ── navigation ──────────────────────────────────────────────────────────

  void _openPastCase(DentalCase selected) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompletedCasePage(
          dentalCase: selected,
          teeth: _teeth,
          coreTreatments: _coreTreatments,
          onTitleChanged: (newTitle) async {
            final result = await getIt<PatientRepository>().updateCaseTitle(
              patientId: widget.patientId,
              caseId: selected.id,
              title: newTitle,
            );
            result.fold(_error, (_) {
              _ok(AppLocalizations.of(context)!.titleUpdated);
              _reload();
            });
          },
          onReopenCase: () async {
            final result = await getIt<PatientRepository>().reactivateCase(
              patientId: widget.patientId,
              caseId: selected.id,
            );
            result.fold(_error, (_) {
              if (!mounted) return;
              Navigator.pop(context);
              _ok(AppLocalizations.of(context)!.caseReopened);
              _reload();
            });
          },
        ),
      ),
    );
  }

  void _createNewCase() {
    context.pushNamed(
      AppRoutesNames.addTreatment,
      extra: {
        'patientId': widget.patientId,
        'patientName': widget.patientName,
        'isInitial': true,
      },
    );
  }

  Future<void> _editPatient(PatientEntity patient) async {
    await context.pushNamed(
      AppRoutesNames.editPatient,
      extra: <String, dynamic>{'patient': patient},
    );
    if (mounted) _reload();
  }

  // ── build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
      builder: (context, state) {
        return state.when(
          initial: () => Scaffold(
            backgroundColor: c.scaffoldBg,
            body: const SizedBox.shrink(),
          ),
          loading: () => Scaffold(
            backgroundColor: c.scaffoldBg,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  PatientIdentityBar(
                    name: widget.patientName,
                    subtitle: '',
                    onBack: _back,
                  ),
                  const Expanded(child: PatientDetailSkeleton()),
                ],
              ),
            ),
          ),
          error: (message) => Scaffold(
            backgroundColor: c.scaffoldBg,
            body: SafeArea(
              child: PatientDetailErrorState(
                message: message,
                onRetry: _reload,
              ),
            ),
          ),
          loaded: (patient, activeCase, completedCases) => _buildLoaded(
            patient: patient,
            activeCase: activeCase,
            completedCases: completedCases,
          ),
        );
      },
    );
  }

  void _back() => context.canPop() ? context.pop() : context.go('/');

  Widget _buildLoaded({
    required PatientEntity patient,
    required DentalCase? activeCase,
    required List<DentalCase> completedCases,
  }) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Unsaved plan preview - the screen is reached straight from the planner.
    if (activeCase == null && widget.prototypePlan != null) {
      return Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              PatientIdentityBar(
                name: patient.name,
                subtitle: _subtitle(patient),
                onBack: _back,
                onEdit: () => _editPatient(patient),
              ),
              Expanded(
                child: TreatmentPlanViewPage(
                  plan: widget.prototypePlan!,
                  embedded: true,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (activeCase != null) _syncAttachments(activeCase);

    final planned = activeCase == null
        ? <PlannedTreatment>[]
        : _mapPlanned(activeCase);
    final unfinished = planned
        .where((t) => t.status != TreatmentPlanStatus.completed)
        .length;
    final currency = activeCase?.totalCostCurrencyCode ?? '';
    final outstanding = activeCase == null
        ? '-'
        : '${_money(activeCase.pendingAmount)}${currency.isEmpty ? '' : ' $currency'}';

    // A chip that scrolls to a section which is not on screen reads as
    // broken, so only the sections that exist get one. Case and Info are
    // always present - Case carries its own empty state, Info is never empty.
    final anchors = <({PatientAnchor anchor, String label})>[
      (anchor: PatientAnchor.caseSection, label: l10n.currentCaseAnchor),
      if (planned.isNotEmpty)
        (anchor: PatientAnchor.treatments, label: l10n.treatments),
      if (_attachments.isNotEmpty)
        (anchor: PatientAnchor.files, label: l10n.filesTitle),
      (anchor: PatientAnchor.info, label: l10n.patientInfo),
    ];

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      bottomNavigationBar: activeCase == null
          ? null
          : DockedCaseActions(
              onAddTreatment: () => _addTreatment(activeCase),
              onRecordPayment: () => _recordPayment(activeCase),
            ),
      body: SafeArea(
        bottom: false,
        // The identity bar and the vitals/anchor rail both sit outside the
        // scroll view, so the pull opens its band *under* the rail instead of
        // shoving the patient's name and the chips down the screen. It also
        // lines this state up with the loading and error ones, which already
        // put the identity bar above an Expanded.
        child: Column(
          children: [
            PatientIdentityBar(
              name: patient.name,
              subtitle: _subtitle(patient),
              onBack: _back,
              onEdit: () => _editPatient(patient),
            ),
            PatientVitalsBar(
              outstandingLabel: l10n.outstanding,
              outstandingValue: outstanding,
              remainingLabel: l10n.remainingWork,
              remainingValue: '$unfinished',
              // Both figures describe the open case, so with none there is
              // nothing for them to report.
              showVitals: activeCase != null,
              // Deleting the last file or treatment can strip the chip the
              // user is standing on; fall back so the rail always has a
              // selection.
              activeAnchor: anchors.any((a) => a.anchor == _active)
                  ? _active
                  : PatientAnchor.caseSection,
              onAnchorTap: _jumpTo,
              anchors: anchors,
            ),
            Expanded(
              child: DentaRefresh(
                onRefresh: _refresh,
                // Longer than the app default on this screen alone: the rail
                // sits directly above the content, and a short flick meant to
                // nudge the list was firing a full reload of the case.
                triggerExtent: 150.h,
                child: CustomScrollView(
                  controller: _scroll,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 28.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          ClinicalAlertsStrip(
                            allergies: patient.allergies,
                            medicalHistory: patient.medicalHistory,
                            onEditAllergies: () => _editPatient(patient),
                            onReviewHistory: () => _editPatient(patient),
                          ),

                          Container(key: _caseKey),
                          if (activeCase == null)
                            PatientDetailPlaceholder(
                              icon: Icons.medical_services_outlined,
                              title: l10n.noOngoingCase,
                              message: l10n.patientNoActiveTreatment,
                              primaryLabel: l10n.createNew,
                              onPrimary: _createNewCase,
                            )
                          else
                            CaseMoneyCard(
                              totalCost: activeCase.totalCost,
                              paidAmount: activeCase.paidAmount,
                              pendingAmount: activeCase.pendingAmount,
                              labFees: activeCase.labFees,
                              paymentCount: 0,
                              onPayments: () => _paymentHistory(activeCase),
                              onEditCosts: () => _editCosts(activeCase),
                              onFinishCase: () =>
                                  _finishCase(activeCase, unfinished),
                            ),

                          if (activeCase != null) ...[
                            SizedBox(height: 20.h),
                            Container(key: _treatmentsKey),
                            TreatmentsSection(
                              treatments: planned,
                              outstandingLabel: activeCase.pendingAmount > 0
                                  ? '$outstanding ${l10n.pendingLabel}'
                                  : null,
                              onToggleDone: (t) => _toggleDone(activeCase, t),
                              onAddNote: (t, note) =>
                                  _addNote(activeCase, t, note),
                              onRemove: (t) => _removeTreatment(activeCase, t),
                              onAddTreatment: () => _addTreatment(activeCase),
                              onFinishCase: () =>
                                  _finishCase(activeCase, unfinished),
                            ),
                            SizedBox(height: 20.h),
                            Container(key: _filesKey),
                            CaseFilesSection(
                              attachments: _attachments,
                              onAdd: () => _addFile(activeCase),
                              onOpen: (i) => CaseFileViewer.open(
                                context,
                                attachments: _attachments,
                                initialIndex: i,
                                onDelete: (a) =>
                                    _deleteAttachment(activeCase, a),
                              ),
                              onRetry: (a) => _retryUpload(activeCase, a),
                            ),
                          ],

                          SizedBox(height: 20.h),
                          Container(key: _infoKey),
                          PatientInfoCard(
                            patient: patient,
                            onEdit: () => _editPatient(patient),
                          ),

                          if (completedCases.isNotEmpty) ...[
                            SizedBox(height: 20.h),
                            PastCasesSection(
                              cases: completedCases,
                              onOpenCase: _openPastCase,
                            ),
                          ],
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _subtitle(PatientEntity p) {
    final bits = <String>[];
    if (p.age > 0) bits.add('${p.age}');
    if (p.gender.isNotEmpty) bits.add(p.gender);
    return bits.join(' - ');
  }

  /// Matches the grouping used inside [CaseMoneyCard] so the pinned figure and
  /// the card below it read as the same number.
  String _money(double v) {
    final s = v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 2);
    final dot = s.indexOf('.');
    final whole = dot == -1 ? s : s.substring(0, dot);
    final rest = dot == -1 ? '' : s.substring(dot);
    final buf = StringBuffer();
    for (var i = 0; i < whole.length; i++) {
      if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
      buf.write(whole[i]);
    }
    return '$buf$rest';
  }
}
