import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';
import '../widgets/plan_summary_header.dart';
import '../widgets/treatment_plan_card.dart';
import 'tooth_treatment_picker_page.dart';
import 'treatment_plan_view_page.dart';

class TreatmentDashboardPage extends StatefulWidget {
  final String? patientId;
  final String? patientName;

  const TreatmentDashboardPage({
    super.key,
    this.patientId,
    this.patientName,
  });

  @override
  State<TreatmentDashboardPage> createState() =>
      _TreatmentDashboardPageState();
}

class _TreatmentDashboardPageState extends State<TreatmentDashboardPage> {
  late TreatmentPlan _plan;

  @override
  void initState() {
    super.initState();
    _plan = TreatmentPlan(
      id: 'plan_${DateTime.now().millisecondsSinceEpoch}',
      patientName: widget.patientName ?? 'Ahmed Mohammed',
      treatments: [],
      createdAt: DateTime.now(),
    );
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
          MediaQuery.of(ctx).viewInsets.bottom + 16.h,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
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
                  color: ColorManager.gray300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Set Cost',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Total Cost',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.textSecondary,
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
                color: ColorManager.textPrimary,
              ),
              decoration: _costInputDecoration('0.00'),
            ),
            SizedBox(height: 14.h),
            Text(
              'Lab Fees',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.textSecondary,
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
                color: ColorManager.textPrimary,
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
                  'Save',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(ctx),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
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
        color: ColorManager.textTertiary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      filled: true,
      fillColor: ColorManager.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }

  void _savePlan() {
    if (widget.patientId != null) {
      // Coming from add patient / patient details flow
      context.pushReplacementNamed(
        AppRoutesNames.patientDetails,
        extra: {
          'patientId': widget.patientId,
          'patientName': _plan.patientName,
          'tabIndex': 1,
          'prototypePlan': _plan,
        },
      );
    } else {
      // Standalone prototype
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TreatmentPlanViewPage(plan: _plan),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      floatingActionButton: _buildFab(context),
      body: Column(
        children: [
          PageHeader(
            title: 'New Treatment Plan',
            onBack: () => context.pop(),
            actions: [
              GestureDetector(
                onTap: _savePlan,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
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

    if (sorted.isEmpty) return _emptyState('No treatments yet — add one!');

    return Column(
      children: sorted.map((t) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: TreatmentPlanCard(treatment: t),
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
              color: ColorManager.gray300,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push<List<PlannedTreatment>>(
          context,
          MaterialPageRoute(
            builder: (_) => ToothTreatmentPickerPage(
              existingTreatments: _plan.treatments,
            ),
          ),
        );
        if (result != null && result.isNotEmpty) {
          _addTreatments(result);
        }
      },
      backgroundColor: ColorManager.primary,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
