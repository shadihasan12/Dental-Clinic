import 'dart:math' as math;
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/plan_treatment_page.dart';
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

  void _showEditCostSheet() {
    final totalCostController = TextEditingController(
        text: _plan.totalCost > 0 ? _plan.totalCost.toStringAsFixed(0) : '');
    final labFeesController = TextEditingController(
        text: _plan.labFees > 0 ? _plan.labFees.toStringAsFixed(0) : '');

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
                  _plan.labFees =
                      double.tryParse(labFeesController.text) ?? 0;
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
    final body = SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          PlanSummaryHeader(
            plan: _plan,
            onTap: _showEditCostSheet,
          ),
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
    final sorted = [
      ..._plan.planned,
      ..._plan.inProgress,
      ..._plan.completed,
    ];

    if (sorted.isEmpty) return _emptyState(AppLocalizations.of(context)!.noTreatmentsRecorded);

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
        // Expandable options
        if (_isFabOpen) ...[
          _buildFabOption(
            icon: Icons.medical_services_outlined,
            label: AppLocalizations.of(context)!.addTreatmentButton,
            onTap: () async {
              _toggleFab();
              final result = await Navigator.push<List<PlannedTreatment>>(
                context,
                MaterialPageRoute(
                  builder: (_) => PlanTreatmentPage(
                    existingTreatments: _plan.treatments,
                  ),
                ),
              );
              if (result != null && result.isNotEmpty) {
                _addTreatments(result);
              }
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
        // Main FAB
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

