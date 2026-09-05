import 'dart:math' as math;
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/plan_treatment_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/manage_notes_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/plan_summary_header.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_plan_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TreatmentPlanViewPage extends StatefulWidget {
  final TreatmentPlan plan;
  final bool embedded;

  const TreatmentPlanViewPage({
    super.key,
    required this.plan,
    this.embedded = false,
  });

  @override
  State<TreatmentPlanViewPage> createState() => _TreatmentPlanViewPageState();
}

class _TreatmentPlanViewPageState extends State<TreatmentPlanViewPage>
    with SingleTickerProviderStateMixin {
  late TreatmentPlan _plan;
  late AnimationController _fabAnimController;
  bool _isFabOpen = false;

  @override
  void initState() {
    super.initState();
    _plan = widget.plan;
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _fabAnimController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
      if (_isFabOpen) {
        _fabAnimController.forward();
      } else {
        _fabAnimController.reverse();
      }
    });
  }

  void _addTreatments(List<PlannedTreatment> treatments) {
    setState(() {
      _plan.treatments.addAll(treatments);
    });
  }

  Future<void> _openAddTreatment() async {
    final result = await Navigator.push<List<PlannedTreatment>>(
      context,
      MaterialPageRoute(
        builder: (_) => PlanTreatmentPage(existingTreatments: _plan.treatments),
      ),
    );
    if (result != null && result.isNotEmpty) {
      _addTreatments(result);
    }
  }

  void _showEditCostSheet() {
    final totalCostController = TextEditingController(
      text: _plan.totalCost > 0 ? _plan.totalCost.toStringAsFixed(0) : '',
    );
    final labFeesController = TextEditingController(
      text: _plan.labFees > 0 ? _plan.labFees.toStringAsFixed(0) : '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          // viewInsets alone only clears the keyboard; with it closed the
          // sheet still has to clear the navigation bar. max, not a sum: an
          // open keyboard already covers that bar.
          math.max(
                MediaQuery.of(ctx).viewInsets.bottom,
                systemBottomInset(ctx),
              ) +
              16.h,
        ),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.of(context).border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(ctx)!.editCosts,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(ctx)!.totalCost,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            TextField(
              controller: totalCostController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
              decoration: _costInputDecoration('0.00'),
            ),
            SizedBox(height: 14.h),
            Text(
              AppLocalizations.of(ctx)!.labFees,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            TextField(
              controller: labFeesController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
              decoration: _costInputDecoration('0.00'),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _plan.totalCost =
                      double.tryParse(totalCostController.text) ?? 0;
                  _plan.labFees = double.tryParse(labFeesController.text) ?? 0;
                });
                Navigator.pop(ctx);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  AppLocalizations.of(ctx)!.save,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(ctx),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Desktop version: uses a regular dialog instead of a bottom sheet.
  void _showEditCostDesktop() {
    final totalCostController = TextEditingController(
      text: _plan.totalCost > 0 ? _plan.totalCost.toStringAsFixed(0) : '',
    );
    final labFeesController = TextEditingController(
      text: _plan.labFees > 0 ? _plan.labFees.toStringAsFixed(0) : '',
    );
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.editCosts,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: 18),
                DesktopTextField(
                  label: l10n.totalCost,
                  controller: totalCostController,
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),
                DesktopTextField(
                  label: l10n.labFees,
                  controller: labFeesController,
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DesktopSecondaryButton(
                      label: l10n.cancel,
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    const SizedBox(width: 10),
                    DesktopPrimaryButton(
                      label: l10n.save,
                      onPressed: () {
                        setState(() {
                          _plan.totalCost =
                              double.tryParse(totalCostController.text) ?? 0;
                          _plan.labFees =
                              double.tryParse(labFeesController.text) ?? 0;
                        });
                        Navigator.pop(ctx);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _costInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 15.sp,
        color: ColorManager.of(context).textTertiary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      filled: true,
      fillColor: ColorManager.of(context).inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.of(context).borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.of(context).borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }

  void _showRecordPaymentSheet() {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          // viewInsets alone only clears the keyboard; with it closed the
          // sheet still has to clear the navigation bar. max, not a sum: an
          // open keyboard already covers that bar.
          math.max(
                MediaQuery.of(ctx).viewInsets.bottom,
                systemBottomInset(ctx),
              ) +
              16.h,
        ),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.of(context).border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(ctx)!.recordPaymentTitle,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '${AppLocalizations.of(ctx)!.pendingLabel}: ${_plan.pending.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(ctx)!.amount,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
              decoration: _costInputDecoration('0.00'),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                final amount = double.tryParse(controller.text) ?? 0;
                if (amount > 0) {
                  setState(() {
                    _plan.paid += amount;
                  });
                }
                Navigator.pop(ctx);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.success,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  AppLocalizations.of(ctx)!.recordPaymentTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(ctx),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordPaymentDesktop() {
    final controller = TextEditingController();
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.recordPaymentTitle,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${l10n.pendingLabel}: ${_plan.pending.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.5,
                    color: c.textTertiary,
                  ),
                ),
                const SizedBox(height: 18),
                DesktopTextField(
                  label: l10n.amount,
                  controller: controller,
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DesktopSecondaryButton(
                      label: l10n.cancel,
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    const SizedBox(width: 10),
                    DesktopPrimaryButton(
                      label: l10n.recordPaymentTitle,
                      color: ColorManager.success,
                      onPressed: () {
                        final amount = double.tryParse(controller.text) ?? 0;
                        if (amount > 0) {
                          setState(() => _plan.paid += amount);
                        }
                        Navigator.pop(ctx);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTreatmentDetailsSheet(PlannedTreatment treatment) {
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

    final sorted = [..._plan.planned, ..._plan.inProgress, ..._plan.completed];

    final content = SingleChildScrollView(
      padding: widget.embedded
          ? const EdgeInsets.all(24)
          : const EdgeInsets.fromLTRB(28, 24, 28, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.embedded) ...[
                DesktopPageHeader(
                  title: l10n.treatmentPlan,
                  subtitle: '${sorted.length} ${l10n.treatments.toLowerCase()}',
                  trailing: Row(
                    children: [
                      DesktopSecondaryButton(
                        label: l10n.recordPaymentTitle,
                        icon: Icons.payments_outlined,
                        onPressed: _showRecordPaymentDesktop,
                      ),
                      const SizedBox(width: 10),
                      DesktopPrimaryButton(
                        label: l10n.addTreatmentButton,
                        icon: Icons.add,
                        onPressed: _openAddTreatment,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
              _desktopCostHero(l10n, c),
              const SizedBox(height: 16),
              _desktopTreatmentsCard(l10n, c, sorted),
            ],
          ),
        ),
      ),
    );

    if (widget.embedded) return content;

    return DesktopShell(
      title: l10n.treatmentPlan,
      body: Scaffold(backgroundColor: c.scaffoldBg, body: content),
    );
  }

  Widget _desktopCostHero(AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    final total = _plan.totalCost;
    final paid = _plan.paid;
    final pending = (total - paid).clamp(0, double.infinity);
    final progress = total > 0 ? (paid / total).clamp(0.0, 1.0) : 0.0;

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
                  l10n.totalCost,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 6),
                // The plan carries its own currency: a hardcoded $ mislabelled
                // every SYP-priced plan by whatever the rate happened to be.
                Text.rich(
                  TextSpan(
                    text: total.toStringAsFixed(0),
                    children: [
                      if (_plan.currencyCode?.isNotEmpty ?? false)
                        TextSpan(
                          text: ' ${_plan.currencyCode}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.75),
                            letterSpacing: 0,
                          ),
                        ),
                    ],
                  ),
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).toInt()}% ${l10n.paidLabel.toLowerCase()}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 14),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _showEditCostDesktop,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.editCosts,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          _desktopStat(l10n.paidLabel, paid, fontFamily),
          const SizedBox(width: 12),
          _desktopStat(l10n.pendingLabel, pending.toDouble(), fontFamily),
        ],
      ),
    );
  }

  Widget _desktopStat(String label, double value, String fontFamily) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          Text.rich(
            TextSpan(
              text: value.toStringAsFixed(0),
              children: [
                if (_plan.currencyCode?.isNotEmpty ?? false)
                  TextSpan(
                    text: ' ${_plan.currencyCode}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopTreatmentsCard(
    AppLocalizations l10n,
    AppColors c,
    List<PlannedTreatment> sorted,
  ) {
    final fontFamily = FontHelper.fontFamily(context);
    return DesktopSectionCard(
      title: l10n.treatments,
      subtitle: '${sorted.length} total',
      child: sorted.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 36,
                    color: c.textSubtle,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noTreatmentsRecorded,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13.5,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: sorted.map((t) {
                final statusColor = _statusColor(t.status);
                final statusLabel = _statusLabel(t.status, l10n);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _showTreatmentDetailsSheet(t),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
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
                                color: ColorManager.primary.withValues(
                                  alpha: 0.12,
                                ),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                statusLabel,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Color _statusColor(TreatmentPlanStatus s) {
    switch (s) {
      case TreatmentPlanStatus.completed:
        return ColorManager.success;
      case TreatmentPlanStatus.inProgress:
        return ColorManager.inProgress;
      case TreatmentPlanStatus.planned:
        return ColorManager.warning;
    }
  }

  String _statusLabel(TreatmentPlanStatus s, AppLocalizations l10n) {
    switch (s) {
      case TreatmentPlanStatus.completed:
        return l10n.completed;
      case TreatmentPlanStatus.inProgress:
        return l10n.inProgress;
      case TreatmentPlanStatus.planned:
        return l10n.planned;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════

  Widget _buildMobileLayout() {
    final body = SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          PlanSummaryHeader(plan: _plan, onTap: _showEditCostSheet),
          SizedBox(height: 16.h),
          _buildTreatmentsList(context),
          SizedBox(height: 80.h),
        ],
      ),
    );

    if (widget.embedded) {
      return Stack(
        children: [
          body,
          Positioned(
            right: 16.w,
            // Embedded here, so there is no Scaffold keeping the FAB above
            // the navigation bar the way the standalone route gets free.
            bottom: dockedBottomPadding(context, 16.h),
            child: _buildFab(context),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      floatingActionButton: _buildFab(context),
      body: Column(
        children: [
          PageHeader(
            title: AppLocalizations.of(context)!.treatmentPlan,
            onBack: () => context.pop(),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _buildTreatmentsList(BuildContext context) {
    final sorted = [..._plan.planned, ..._plan.inProgress, ..._plan.completed];

    if (sorted.isEmpty) {
      return _emptyState(AppLocalizations.of(context)!.noTreatmentsRecorded);
    }

    return Column(
      children: sorted.map((t) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: TreatmentPlanCard(
            treatment: t,
            onTap: () => _showTreatmentDetailsSheet(t),
          ),
        );
      }).toList(),
    );
  }

  Widget _emptyState(String message) {
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

  Widget _buildFab(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isFabOpen) ...[
          _buildFabOption(
            icon: Icons.medical_services_outlined,
            label: AppLocalizations.of(context)!.addTreatmentButton,
            onTap: () async {
              _toggleFab();
              await _openAddTreatment();
            },
          ),
          SizedBox(height: 10.h),
          _buildFabOption(
            icon: Icons.payments_outlined,
            label: AppLocalizations.of(context)!.recordPaymentTitle,
            onTap: () {
              _toggleFab();
              _showRecordPaymentSheet();
            },
          ),
          SizedBox(height: 12.h),
        ],
        FloatingActionButton(
          onPressed: _toggleFab,
          backgroundColor: ColorManager.primary,
          child: AnimatedBuilder(
            animation: _fabAnimController,
            builder: (_, child) => Transform.rotate(
              angle: _fabAnimController.value * 0.75,
              child: child,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFabOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.of(context).cardBg,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 20.w, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
