import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/plan_treatment_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/treatment_plan_view_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_plan_editor.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/plan_summary_header.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_plan_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NewTreatmentPlanPage extends StatefulWidget {
  final String? patientId;
  final String? patientName;

  const NewTreatmentPlanPage({
    super.key,
    this.patientId,
    this.patientName,
  });

  @override
  State<NewTreatmentPlanPage> createState() => _NewTreatmentPlanPageState();
}

class _NewTreatmentPlanPageState extends State<NewTreatmentPlanPage> {
  late TreatmentPlan _plan;
  List<TreatmentCategoryGroup> _categories = [];
  List<Tooth> _teeth = [];
  bool _isLoading = true;
  bool _isSaving = false;
  CurrencyEntity? _totalCostCurrency;
  CurrencyEntity? _labFeesCurrency;

  bool get _canSave => _plan.treatments.isNotEmpty && _plan.totalCost > 0;

  @override
  void initState() {
    super.initState();
    _plan = TreatmentPlan(
      id: 'plan_${DateTime.now().millisecondsSinceEpoch}',
      patientName: widget.patientName ?? '',
      treatments: [],
      createdAt: DateTime.now(),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([_loadCoreTreatments(), _loadTeeth()]);
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _loadCoreTreatments() async {
    final result = await getIt<GetAllCoreTreatmentsUseCase>()(NoParams());
    result.fold(
      (_) {
        _categories = MockTreatmentTypes.categories;
      },
      (treatments) {
        _categories = mapCoreTreatments(treatments);
      },
    );
    if (_categories.isEmpty) {
      _categories = MockTreatmentTypes.categories;
    }
    _categories.sort((a, b) {
      if (a.isGeneralCategory && !b.isGeneralCategory) return 1;
      if (!a.isGeneralCategory && b.isGeneralCategory) return -1;
      return 0;
    });
  }

  Future<void> _loadTeeth() async {
    final result = await getIt<GetAllTeethUseCase>()(NoParams());
    result.fold(
      (_) {},
      (teeth) => _teeth = teeth,
    );
  }

  void _addTreatments(List<PlannedTreatment> treatments) {
    setState(() {
      _plan.treatments.addAll(treatments);
    });
  }

  void _removeTreatment(PlannedTreatment treatment) {
    setState(() {
      _plan.treatments.remove(treatment);
    });
  }

  /// Writes what the cost form reports into the plan.
  ///
  /// The plan carries currency *codes* because that is what the summary
  /// shows; the entities are kept beside it because that is what the API
  /// takes. The two have to move together.
  void _applyCosts(
    double totalCost,
    double labFees,
    CurrencyEntity? totalCostCurrency,
    CurrencyEntity? labFeesCurrency,
  ) {
    setState(() {
      _plan.totalCost = totalCost;
      _plan.labFees = labFees;
      _totalCostCurrency = totalCostCurrency;
      _labFeesCurrency = labFeesCurrency;
      _plan.currencyCode = totalCostCurrency?.currencyCode;
      _plan.labFeesCurrencyCode = labFeesCurrency?.currencyCode;
    });
  }

  String? _toothCodeToId(String universalCode) {
    final match = _teeth.where((t) => t.universalCode == universalCode);
    return match.isNotEmpty ? match.first.id : null;
  }

  Future<void> _savePlan() async {
    if (!_canSave || _isSaving) return;

    if (widget.patientId == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TreatmentPlanViewPage(plan: _plan),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context)!;
    AppLoadingDialog.show(context: context, message: l10n.savingTreatmentPlan);

    final items = _plan.treatments.map((t) {
      final toothIds = <String>[];
      if (t.toothNumber != null) {
        final id = _toothCodeToId(t.toothNumber!);
        if (id != null) toothIds.add(id);
      }

      final notes = t.visitNotes
          .map((n) => {
                'note': n.text,
                'date':
                    '${n.date.year}-${n.date.month.toString().padLeft(2, '0')}-${n.date.day.toString().padLeft(2, '0')}',
              })
          .toList();

      return TreatmentPlanItemParam(
        description: t.notes.isNotEmpty ? t.notes : null,
        coreTreatmentIds: [t.type.id],
        toothIds: toothIds,
        notes: notes,
      );
    }).toList();

    final params = AddTreatmentParams(
      patientId: widget.patientId!,
      isInitial: true,
      visitDate: DateTime.now(),
      totalCost: _plan.totalCost,
      totalCostCurrencyId: _totalCostCurrency?.id,
      labFees: _plan.labFees,
      labFeesCurrencyId: _labFeesCurrency?.id,
      attachments: [],
      treatmentPlanItems: items,
    );

    final result = await getIt<AddTreatmentUseCase>()(params);

    if (!mounted) return;
    AppLoadingDialog.dismiss(context);
    setState(() => _isSaving = false);

    final l10nAfter = AppLocalizations.of(context)!;
    result.fold(
      (error) {
        AppSnackbar.showError(
          context,
          title: l10nAfter.error,
          message: NetworkExceptions.getErrorMessage(error),
        );
      },
      (_) {
        AppSnackbar.showSuccess(
          context,
          title: l10nAfter.success,
          message: l10nAfter.treatmentPlanSavedSuccessfully,
        );
        // pushReplacement, not go: goNamed on a top-level route clears the
        // whole stack, leaving patient details with nothing to pop. Matches
        // what AddTreatmentPage does on the same transition.
        context.pushReplacementNamed(
          AppRoutesNames.patientDetails,
          extra: {
            'patientId': widget.patientId,
            'patientName': _plan.patientName,
            'tabIndex': 1,
          },
        );
      },
    );
  }

  Future<void> _openPlanTreatment() async {
    final result = await Navigator.push<List<PlannedTreatment>>(
      context,
      MaterialPageRoute(
        builder: (_) => PlanTreatmentPage(
          existingTreatments: _plan.treatments,
          categories: _categories,
          teeth: _teeth,
        ),
      ),
    );
    if (result != null && result.isNotEmpty) {
      _addTreatments(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopLayout();
    }
    return _buildMobileLayout();
  }

  // ═══════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════

  /// One page, no hand-offs: the costs are typed into the blue card, and the
  /// chart, the treatments for the tapped tooth and the plan so far sit side
  /// by side below it. The phone splits this across a sheet and a second
  /// page only because it has no room.
  Widget _buildDesktopLayout() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    // The top bar already names the page, so the body carries no header of
    // its own: the patient rides above the title there, and Save sits in the
    // bar's actions so it stays in reach however far the plan scrolls.
    return DesktopShell(
      title: l10n.newTreatmentPlan,
      breadcrumb: widget.patientName,
      actions: [
        DesktopPrimaryButton(
          label: l10n.save,
          icon: Icons.check,
          onPressed: _canSave ? _savePlan : null,
          isLoading: _isSaving,
        ),
      ],
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DesktopPlanCostCard(
                          plan: _plan,
                          totalCostCurrency: _totalCostCurrency,
                          labFeesCurrency: _labFeesCurrency,
                          onCostChanged: _applyCosts,
                        ),
                        const SizedBox(height: 16),
                        DesktopPlanBuilder(
                          categories: _categories,
                          teeth: _teeth,
                          treatments: _plan.treatments,
                          onAdd: (t) => _addTreatments([t]),
                          onRemove: _removeTreatment,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════

  Widget _buildMobileLayout() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Scaffold(
      backgroundColor: c.scaffoldBg,
      bottomNavigationBar: _buildAddBar(context, l10n),
      body: Column(
        children: [
          PageHeader(
            title: l10n.newTreatmentPlan,
            onBack: () => context.pop(),
            actions: [
              GestureDetector(
                onTap: _canSave ? _savePlan : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorManager.of(context).cardBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Opacity(
                    opacity: _canSave ? 1.0 : 0.35,
                    child: Text(
                      l10n.save,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? const _NewTreatmentPlanSkeleton()
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        // Edits in place: the card opens the two cost
                        // fields under itself rather than handing off to a
                        // sheet. Desktop shows the same fields open inside
                        // its blue plan card.
                        PlanSummaryHeader(
                          plan: _plan,
                          isInitial: true,
                          totalCostCurrency: _totalCostCurrency,
                          labFeesCurrency: _labFeesCurrency,
                          onCostChanged: _applyCosts,
                        ),
                        SizedBox(height: 16.h),
                        _buildTreatmentsList(context),
                        // The action is docked now, so the list only needs
                        // breathing room under its last row.
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentsList(BuildContext context) {
    final sorted = [
      ..._plan.planned,
      ..._plan.inProgress,
      ..._plan.completed,
    ];

    if (sorted.isEmpty) {
      return _EmptyTreatmentsState(
        message: AppLocalizations.of(context)!.noTreatmentsYetAddOne,
      );
    }

    return Column(
      children: sorted.map((t) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Dismissible(
            key: Key(t.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _removeTreatment(t),
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                color: ColorManager.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.delete_outline,
                color: ColorManager.error,
                size: 22.w,
              ),
            ),
            // No tap target: visit notes belong to a treatment that has
            // been carried out, and nothing here has been saved yet - let
            // alone done. The row is a queued line, removable by swipe.
            child: TreatmentPlanCard(treatment: t),
          ),
        );
      }).toList(),
    );
  }

  /// Docked rather than floating, and labelled rather than a bare plus.
  ///
  /// A circle with a `+` on a screen that also has a Save in the header
  /// never said which of the two it was, and it sat over the last row of the
  /// list. This is the same bar every other form in the app docks its action
  /// in - hairline on top, full-width button in the thumb arc.
  Widget? _buildAddBar(BuildContext context, AppLocalizations l10n) {
    if (_isLoading) return null;
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: scaffoldBottomInset(context)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          child: DentaButton(
            label: l10n.addTreatment,
            icon: Icons.add_rounded,
            expand: true,
            onTap: _openPlanTreatment,
          ),
        ),
      ),
    );
  }
}

class _EmptyTreatmentsState extends StatelessWidget {
  final String message;

  const _EmptyTreatmentsState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48.w,
              color: ColorManager.of(context).border,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewTreatmentPlanSkeleton extends StatelessWidget {
  const _NewTreatmentPlanSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      physics: const NeverScrollableScrollPhysics(),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan summary header skeleton
            ShimmerBox(
              width: double.infinity,
              height: 110.h,
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 16.h),
            // Treatment cards skeleton
            for (var i = 0; i < 4; i++) ...[
              ShimmerBox(
                width: double.infinity,
                height: 72.h,
                radius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 8.h),
            ],
          ],
        ),
      ),
    );
  }
}
