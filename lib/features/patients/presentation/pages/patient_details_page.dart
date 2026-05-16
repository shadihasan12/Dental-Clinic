import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_payment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_payments_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/patient_details/patient_details_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_tab.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_overview_tab.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'completed_case_page.dart';
import 'plan_treatment_page.dart';
import 'treatment_plan_view_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/details/widgets.dart';

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
        tabIndex: tabIndex,
        patientName: patientName,
        prototypePlan: prototypePlan,
      ),
    );
  }
}

class _PatientDetailsContent extends StatefulWidget {
  final String patientId;
  final int? tabIndex;
  final String patientName;
  final TreatmentPlan? prototypePlan;

  const _PatientDetailsContent({
    required this.patientId,
    this.tabIndex,
    required this.patientName,
    this.prototypePlan,
  });

  @override
  State<_PatientDetailsContent> createState() => _PatientDetailsContentState();
}

class _PatientDetailsContentState extends State<_PatientDetailsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Tooth> _teeth = [];
  List<CoreTreatment> _coreTreatments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabIndex ?? 1,
    );
    _loadTeeth();
    _loadCoreTreatments();
  }

  Future<void> _loadTeeth() async {
    final result = await getIt<GetAllTeethUseCase>()(NoParams());
    result.fold(
      (_) {},
      (teeth) => setState(() => _teeth = teeth),
    );
  }

  Future<void> _loadCoreTreatments() async {
    final result = await getIt<GetAllCoreTreatmentsUseCase>()(NoParams());
    result.fold(
      (_) {},
      (treatments) => setState(() => _coreTreatments = treatments),
    );
  }

  void _onHistoryCaseTap(DentalCase selectedCase) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompletedCasePage(
          dentalCase: selectedCase,
          teeth: _teeth,
          coreTreatments: _coreTreatments,
          onTitleChanged: (newTitle) async {
            final result = await getIt<PatientRepository>().updateCaseTitle(
              patientId: widget.patientId,
              caseId: selectedCase.id,
              title: newTitle,
            );
            result.fold(
              (error) {
                if (mounted) {
                  AppSnackbar.showError(
                    context,
                    title: 'Error',
                    message: NetworkExceptions.getErrorMessage(error),
                  );
                }
              },
              (_) {
                if (mounted) {
                  final l10n = AppLocalizations.of(context)!;
                  AppSnackbar.showSuccess(
                    context,
                    title: l10n.success,
                    message: l10n.titleUpdated,
                  );
                  context.read<PatientDetailsBloc>().add(
                        PatientDetailsEvent.loadPatientDetails(widget.patientId),
                      );
                }
              },
            );
          },
          onReopenCase: () async {
            final result = await getIt<PatientRepository>().reactivateCase(
              patientId: widget.patientId,
              caseId: selectedCase.id,
            );
            result.fold(
              (error) {
                if (mounted) {
                  AppSnackbar.showError(
                    context,
                    title: 'Error',
                    message: NetworkExceptions.getErrorMessage(error),
                  );
                }
              },
              (_) {
                if (mounted) {
                  Navigator.pop(context);
                  _tabController.animateTo(1);
                  context.read<PatientDetailsBloc>().add(
                        PatientDetailsEvent.loadPatientDetails(widget.patientId),
                      );
                  final l10n = AppLocalizations.of(context)!;
                  AppSnackbar.showSuccess(
                    context,
                    title: l10n.success,
                    message: l10n.caseReopened,
                  );
                }
              },
            );
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientDetailsBloc, PatientDetailsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return state.when(
          initial: () => const Scaffold(body: SizedBox.shrink()),
          loading: () => Scaffold(
                backgroundColor: ColorManager.of(context).scaffoldBg,
                body: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      PatientHeader(
                        name: widget.patientName,
                        onBackPressed: () =>
                          context.canPop() ? context.pop() : context.go('/'),
                        tabController: _tabController,
                      ),
                      const Expanded(child: _PatientDetailsSkeleton()),
                    ],
                  ),
                ),
              ),
          error: (message) => Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.of(context).textSecondary,
                  ),
                ),
              ),
            ),
          ),
          loaded: (patient, activeCase, completedCases) {
            return Scaffold(
              backgroundColor: ColorManager.of(context).scaffoldBg,
              body: SafeArea(
                top: false,
                child: Column(
                children: [
                  PatientHeader(
                    name: patient.name,
                    onBackPressed: () =>
                        context.canPop() ? context.pop() : context.go('/'),
                    onEditPressed: () async {
                      await context.pushNamed(
                        AppRoutesNames.editPatient,
                        extra: <String, dynamic>{'patient': patient},
                      );
                      if (mounted) {
                        context.read<PatientDetailsBloc>().add(
                              PatientDetailsEvent.loadPatientDetails(
                                widget.patientId,
                              ),
                            );
                      }
                    },
                    tabController: _tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        // Tab 1: Patient Info
                        SingleChildScrollView(
                          padding: PaddingManager.all16,
                          child: PatientInfoTab(
                            phone: patient.phone,
                            email: patient.email,
                            address: patient.address,
                            medicalHistory: patient.medicalHistory ?? '',
                            dateOfBirth: patient.dateOfBirth
                                .toIso8601String()
                                .substring(0, 10),
                            allergies: 'None',
                            age: patient.age,
                            gender: patient.gender,
                            initiallyExpanded: true,
                          ),
                        ),

                        // Tab 2: Case
                        _buildCaseTab(activeCase),

                        // Tab 3: History
                        CaseHistoryTab(
                          completedCases: completedCases,
                          onCaseTap: _onHistoryCaseTap,
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Payment>> _loadPayments(String caseId) async {
    final result = await getIt<GetPaymentsUseCase>()(
      GetPaymentsParams(patientId: widget.patientId, caseId: caseId),
    );
    return result.fold((_) => [], (payments) => payments);
  }

  Widget _buildCaseTab(DentalCase? activeCase) {
    if (activeCase == null && widget.prototypePlan != null) {
      return TreatmentPlanViewPage(
        plan: widget.prototypePlan!,
        embedded: true,
      );
    }

    if (activeCase == null) {
      return _buildNoCaseState();
    }

    return CaseOverviewWidget(
      dentalCase: activeCase,
      teeth: _teeth,
      coreTreatments: _coreTreatments,
      isReadOnly: false,
      onPaymentRecorded: (amount, currencyId, caseCurrencyId, amountInCaseCurrency, exchangeRate, notes) async {
        final result = await getIt<AddPaymentUseCase>()(
          AddPaymentParams(
            patientId: widget.patientId,
            caseId: activeCase.id,
            amount: amount,
            currencyId: currencyId,
            caseCurrencyId: caseCurrencyId,
            amountInCaseCurrency: amountInCaseCurrency,
            exchangeRate: exchangeRate,
            notes: notes,
          ),
        );
        final error = result.fold<NetworkExceptions?>(
          (l) => l,
          (_) => null,
        );
        if (error != null) {
          throw Exception(NetworkExceptions.getErrorMessage(error));
        }
        if (mounted) {
          context.read<PatientDetailsBloc>().add(
            PatientDetailsEvent.loadPatientDetails(widget.patientId),
          );
        }
      },
      onLoadPayments: () => _loadPayments(activeCase.id),
      onMarkAsFinished: () => _showMarkAsFinishedDialog(),
      onAddTreatment: () => _navigateToAddTreatment(activeCase),
      onMarkTreatmentFinished: (treatment) async {
        final itemId = treatment.id.split('_').first;
        final result =
            await getIt<PatientRepository>().toggleTreatmentPlanItemStatus(
          patientId: widget.patientId,
          caseId: activeCase.id,
          itemId: itemId,
        );

        result.fold(
          (error) {
            if (mounted) {
              AppSnackbar.showError(
                context,
                title: 'Error',
                message: NetworkExceptions.getErrorMessage(error),
              );
              // Reload to revert the local toggle
              context.read<PatientDetailsBloc>().add(
                    PatientDetailsEvent.loadPatientDetails(widget.patientId),
                  );
            }
          },
          (_) {},
        );
      },
      onNotesUpdated: (treatment, updatedNotes) async {
        // treatment.id is formatted as "${itemId}_${typeId}"
        final itemId = treatment.id.split('_').first;
        final noteMaps = updatedNotes
            .map((n) => {
                  'note': n.text,
                  'date':
                      '${n.date.year}-${n.date.month.toString().padLeft(2, '0')}-${n.date.day.toString().padLeft(2, '0')}',
                })
            .toList();

        final result =
            await getIt<PatientRepository>().updateTreatmentPlanItem(
          patientId: widget.patientId,
          caseId: activeCase.id,
          itemId: itemId,
          notes: noteMaps,
        );

        result.fold(
          (error) {
            if (mounted) {
              AppSnackbar.showError(
                context,
                title: 'Error',
                message: NetworkExceptions.getErrorMessage(error),
              );
            }
          },
          (_) {
            if (mounted) {
              final l10n = AppLocalizations.of(context)!;
              AppSnackbar.showSuccess(
                context,
                title: l10n.success,
                message: l10n.notesUpdated,
              );
            }
          },
        );
      },
      onRemoveTreatment: (treatment) async {
        final itemId = treatment.id.split('_').first;
        final result =
            await getIt<PatientRepository>().deleteTreatmentPlanItem(
          patientId: widget.patientId,
          caseId: activeCase.id,
          itemId: itemId,
        );

        result.fold(
          (error) {
            if (mounted) {
              AppSnackbar.showError(
                context,
                title: 'Error',
                message: NetworkExceptions.getErrorMessage(error),
              );
              // Reload to restore the item in the list
              context.read<PatientDetailsBloc>().add(
                    PatientDetailsEvent.loadPatientDetails(widget.patientId),
                  );
            }
          },
          (_) {
            if (mounted) {
              final l10n = AppLocalizations.of(context)!;
              AppSnackbar.showSuccess(
                context,
                title: l10n.success,
                message: l10n.treatmentRemoved,
              );
            }
          },
        );
      },
      onEditCosts: (totalCost, totalCostCurrencyId, labFees, labFeesCurrencyId) async {
        final result = await getIt<PatientRepository>().updateCaseCosts(
          patientId: widget.patientId,
          caseId: activeCase.id,
          totalCost: totalCost,
          totalCostCurrencyId: totalCostCurrencyId,
          labFees: labFees,
          labFeesCurrencyId: labFeesCurrencyId,
        );

        result.fold(
          (error) {
            if (mounted) {
              AppSnackbar.showError(
                context,
                title: 'Error',
                message: NetworkExceptions.getErrorMessage(error),
              );
            }
          },
          (_) {
            if (mounted) {
              final l10n = AppLocalizations.of(context)!;
              AppSnackbar.showSuccess(
                context,
                title: l10n.success,
                message: l10n.costsUpdated,
              );
              context.read<PatientDetailsBloc>().add(
                    PatientDetailsEvent.loadPatientDetails(widget.patientId),
                  );
            }
          },
        );
      },
    );
  }

  Future<void> _navigateToAddTreatment(DentalCase activeCase) async {
    final categories = mapCoreTreatments(_coreTreatments);
    // Sort: tooth-specific first, general last
    categories.sort((a, b) {
      final aIsGeneral = a.name.contains('عامة');
      final bIsGeneral = b.name.contains('عامة');
      if (aIsGeneral && !bIsGeneral) return 1;
      if (!aIsGeneral && bIsGeneral) return -1;
      return 0;
    });

    final result = await Navigator.push<List<PlannedTreatment>>(
      context,
      MaterialPageRoute(
        builder: (_) => PlanTreatmentPage(
          categories: categories,
          teeth: _teeth,
        ),
      ),
    );

    if (result == null || result.isEmpty || !mounted) return;

    // Save via AddTreatmentUseCase with isInitial: false
    final treatmentTypeIds = result.map((t) => t.type.id).toList();
    final toothIds = result
        .where((t) => t.toothNumber != null)
        .map((t) {
          final match = _teeth.where(
            (tooth) => tooth.universalCode == t.toothNumber,
          );
          return match.isNotEmpty ? match.first.id : null;
        })
        .whereType<String>()
        .toSet()
        .toList();

    final l10n = AppLocalizations.of(context)!;
    AppLoadingDialog.show(context: context, message: l10n.saving);

    final addResult = await getIt<AddTreatmentUseCase>()(
      AddTreatmentParams(
        patientId: widget.patientId,
        isInitial: false,
        caseId: activeCase.id,
        visitDate: DateTime.now(),
        treatmentTypes: treatmentTypeIds,
        selectedTeeth: toothIds,
        summary: null,
        totalCost: 0,
        labFees: 0,
        attachments: [],
      ),
    );

    if (!mounted) return;
    AppLoadingDialog.dismiss(context);

    addResult.fold(
      (error) {
        AppSnackbar.showError(
          context,
          title: 'Error',
          message: NetworkExceptions.getErrorMessage(error),
        );
      },
      (_) {
        AppSnackbar.showSuccess(
          context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.treatmentAddedSuccessfully,
        );
        context.read<PatientDetailsBloc>().add(
          PatientDetailsEvent.loadPatientDetails(widget.patientId),
        );
      },
    );
  }

  Widget _buildNoCaseState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medical_services_outlined,
                size: 40.w,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              l10n.noOngoingCase,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.patientNoActiveTreatment,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: _createNewCase,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.createNew,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  void _showMarkAsFinishedDialog() {
    final l10n = AppLocalizations.of(context)!;
    final activeCase = context.read<PatientDetailsBloc>().state.mapOrNull(
      loaded: (s) => s.activeCase,
    );
    if (activeCase == null) return;

    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.markAsFinished,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.of(context).textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.markCaseFinishedQuestion,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
                color: ColorManager.of(context).textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: l10n.caseTitleOptional,
                hintText: l10n.caseTitleHint,
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textSecondary,
                ),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.of(context).borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.of(context).borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              Navigator.pop(dialogContext);
              context.read<PatientDetailsBloc>().add(
                PatientDetailsEvent.markCaseAsFinished(
                  patientId: widget.patientId,
                  caseId: activeCase.id,
                  title: title.isEmpty ? null : title,
                ),
              );
            },
            child: Text(
              l10n.confirm,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmer skeleton for the details body ────────────────────────────────

class _PatientDetailsSkeleton extends StatelessWidget {
  const _PatientDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: PaddingManager.all16,
      physics: const NeverScrollableScrollPhysics(),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            ShimmerBox(width: 160.w, height: 16.h),
            SizedBox(height: 16.h),
            // 4 info rows (icon + 2 lines)
            for (var i = 0; i < 4; i++) ...[
              _SkeletonInfoRow(),
              SizedBox(height: 12.h),
            ],
            SizedBox(height: 12.h),
            // Secondary section header
            ShimmerBox(width: 120.w, height: 16.h),
            SizedBox(height: 16.h),
            // Block card
            ShimmerBox(
              width: double.infinity,
              height: 96.h,
              radius: BorderRadius.circular(12.r),
            ),
            SizedBox(height: 12.h),
            ShimmerBox(
              width: double.infinity,
              height: 96.h,
              radius: BorderRadius.circular(12.r),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerBox(
          width: 36.w,
          height: 36.w,
          radius: BorderRadius.circular(36.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: 80.w, height: 10.h),
              SizedBox(height: 6.h),
              ShimmerBox(width: 200.w, height: 12.h),
            ],
          ),
        ),
      ],
    );
  }
}
