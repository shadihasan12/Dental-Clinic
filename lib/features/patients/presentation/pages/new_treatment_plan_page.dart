import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/plan_treatment_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/treatment_plan_view_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/manage_notes_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/plan_summary_header.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/set_cost_sheet.dart';
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

  void _showManageNotesSheet(PlannedTreatment treatment) {
    ManageNotesSheet.show(
      context,
      treatmentName: treatment.type.name,
      initialNotes: treatment.visitNotes,
      onSave: (updatedNotes) {
        setState(() {
          treatment.visitNotes
            ..clear()
            ..addAll(updatedNotes);
        });
      },
    );
  }

  void _showEditCostSheet() {
    SetCostSheet.show(
      context,
      totalCost: _plan.totalCost,
      labFees: _plan.labFees,
      totalCostCurrency: _totalCostCurrency,
      labFeesCurrency: _labFeesCurrency,
      onSave: (totalCost, labFees, totalCostCurrency, labFeesCurrency) {
        setState(() {
          _plan.totalCost = totalCost;
          _plan.labFees = labFees;
          _totalCostCurrency = totalCostCurrency;
          _labFeesCurrency = labFeesCurrency;
        });
      },
    );
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
        context.goNamed(
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

  Widget _buildDesktopLayout() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    final sorted = [
      ..._plan.planned,
      ..._plan.inProgress,
      ..._plan.completed,
    ];

    return DesktopShell(
      title: l10n.newTreatmentPlan,
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: _isLoading
            ? Center(
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
                        DesktopPageHeader(
                          title: l10n.newTreatmentPlan,
                          subtitle: l10n.treatmentPlan,
                          trailing: DesktopPrimaryButton(
                            label: l10n.save,
                            icon: Icons.check,
                            onPressed: _canSave ? _savePlan : null,
                            isLoading: _isSaving,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _desktopCostCard(l10n, c),
                        const SizedBox(height: 16),
                        _desktopTreatmentsCard(l10n, c, sorted),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _desktopCostCard(AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    final paid = _plan.paid;
    final total = _plan.totalCost;
    final pending = (total - paid).clamp(0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorManager.primary, ColorManager.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.treatmentPlan,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${total.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 6),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _showEditCostSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_outlined,
                            color: Colors.white.withValues(alpha: 0.9),
                            size: 14),
                        const SizedBox(width: 6),
                        Text(
                          l10n.editCosts,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _desktopCostPill(l10n.paidLabel, paid, fontFamily),
          const SizedBox(width: 12),
          _desktopCostPill(l10n.pendingLabel, pending.toDouble(), fontFamily),
        ],
      ),
    );
  }

  Widget _desktopCostPill(String label, double value, String fontFamily) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${value.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopTreatmentsCard(
      AppLocalizations l10n, AppColors c, List<PlannedTreatment> sorted) {
    return DesktopSectionCard(
      title: l10n.treatments,
      subtitle: '${sorted.length} total',
      trailing: DesktopPrimaryButton(
        label: l10n.addTreatmentButton,
        icon: Icons.add,
        compact: true,
        onPressed: _openPlanTreatment,
      ),
      child: sorted.isEmpty
          ? _desktopEmpty(l10n)
          : Column(
              children: sorted
                  .map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _desktopTreatmentRow(t, l10n, c),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Widget _desktopTreatmentRow(
      PlannedTreatment t, AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showManageNotesSheet(t),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.type.name,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    if (t.toothNumber != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Tooth #${t.toothNumber}',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _removeTreatment(t),
                icon: Icon(Icons.delete_outline,
                    size: 18, color: c.textTertiary),
                tooltip: l10n.delete,
                hoverColor: ColorManager.error.withValues(alpha: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopEmpty(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment_outlined,
                size: 28, color: ColorManager.primary),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.noTreatmentsYetAddOne,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13.5,
              color: c.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          DesktopPrimaryButton(
            label: l10n.addTreatmentButton,
            icon: Icons.add,
            onPressed: _openPlanTreatment,
          ),
        ],
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
      floatingActionButton: _buildFab(context),
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
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        PlanSummaryHeader(
                          plan: _plan,
                          isInitial: true,
                          onTap: _showEditCostSheet,
                        ),
                        SizedBox(height: 16.h),
                        _buildTreatmentsList(context),
                        SizedBox(height: 80.h),
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
            child: TreatmentPlanCard(
              treatment: t,
              onTap: () => _showManageNotesSheet(t),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFab(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();
    return FloatingActionButton(
      onPressed: _openPlanTreatment,
      backgroundColor: ColorManager.primary,
      child: const Icon(Icons.add, color: Colors.white),
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
