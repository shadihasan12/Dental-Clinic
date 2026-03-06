import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';
import '../widgets/treatment_plan_card.dart';

/// Visit session page — the dentist uses this during an appointment
/// to mark planned treatments as completed.
class VisitSessionPage extends StatefulWidget {
  final TreatmentPlan plan;

  const VisitSessionPage({super.key, required this.plan});

  @override
  State<VisitSessionPage> createState() => _VisitSessionPageState();
}

class _VisitSessionPageState extends State<VisitSessionPage> {
  final Set<String> _completedThisVisit = {};
  final TextEditingController _notesController = TextEditingController();

  List<PlannedTreatment> get _pendingTreatments =>
      widget.plan.treatments.where((t) =>
          t.status != TreatmentPlanStatus.completed &&
          !_completedThisVisit.contains(t.id)).toList();

  List<PlannedTreatment> get _markedDone =>
      widget.plan.treatments.where((t) =>
          _completedThisVisit.contains(t.id)).toList();

  List<PlannedTreatment> get _previouslyCompleted =>
      widget.plan.treatments.where((t) =>
          t.status == TreatmentPlanStatus.completed &&
          !_completedThisVisit.contains(t.id)).toList();

  void _toggleTreatment(PlannedTreatment treatment) {
    setState(() {
      if (_completedThisVisit.contains(treatment.id)) {
        _completedThisVisit.remove(treatment.id);
      } else {
        _completedThisVisit.add(treatment.id);
      }
    });
  }

  void _saveVisit() {
    // Mark selected treatments as completed
    for (final t in widget.plan.treatments) {
      if (_completedThisVisit.contains(t.id)) {
        t.status = TreatmentPlanStatus.completed;
        t.completedDate = DateTime.now();
      }
    }

    AppSnackbar.showSuccess(
      context,
      title: 'Visit Saved',
      message: '${_completedThisVisit.length} treatments marked as completed',
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      bottomNavigationBar: _buildBottomBar(context),
      body: Column(
        children: [
          PageHeader(
            title: 'Visit Session',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Visit info header
                  _buildVisitHeader(context),
                  SizedBox(height: 16.h),

                  // Pending treatments — check off what gets done
                  if (_pendingTreatments.isNotEmpty) ...[
                    _sectionTitle(context, 'Pending Treatments',
                        '${_pendingTreatments.length} remaining'),
                    SizedBox(height: 8.h),
                    ..._pendingTreatments.map(
                      (t) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: TreatmentPlanCard(
                          treatment: t,
                          showCheckbox: true,
                          onStatusChanged: (_) => _toggleTreatment(t),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Treatments completed this visit
                  if (_markedDone.isNotEmpty) ...[
                    _sectionTitle(
                      context,
                      'Completed This Visit',
                      '${_markedDone.length} done',
                      color: ColorManager.success,
                    ),
                    SizedBox(height: 8.h),
                    ..._markedDone.map(
                      (t) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: TreatmentPlanCard(
                          treatment: PlannedTreatment(
                            id: t.id,
                            type: t.type,
                            toothNumber: t.toothNumber,
                            status: TreatmentPlanStatus.completed,
                            cost: t.cost,
                          ),
                          showCheckbox: true,
                          onStatusChanged: (_) => _toggleTreatment(t),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Visit notes
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visit Notes',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _notesController,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Add notes about this visit...',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: ColorManager.textTertiary,
                            ),
                            contentPadding: EdgeInsets.all(12.w),
                            filled: true,
                            fillColor: ColorManager.gray50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: ColorManager.borderLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: ColorManager.borderLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Previously completed (collapsed)
                  if (_previouslyCompleted.isNotEmpty) ...[
                    _sectionTitle(
                      context,
                      'Previously Completed',
                      '${_previouslyCompleted.length}',
                      color: ColorManager.textTertiary,
                    ),
                    SizedBox(height: 8.h),
                    ..._previouslyCompleted.map(
                      (t) => Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: TreatmentPlanCard(treatment: t),
                      ),
                    ),
                  ],
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHeader(BuildContext context) {
    final now = DateTime.now();
    final dateStr =
        '${now.day}/${now.month}/${now.year}';
    final total = widget.plan.treatments.length;
    final completed = widget.plan.completed.length + _completedThisVisit.length;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.success,
            ColorManager.success.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.medical_services,
              size: 22.w,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Visit',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$completed/$total',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'completed',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String title,
    String badge, {
    Color? color,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: color ?? ColorManager.textPrimary,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: (color ?? ColorManager.primary).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            badge,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: color ?? ColorManager.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        MediaQuery.of(context).padding.bottom + 12.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: _completedThisVisit.isEmpty ? null : _saveVisit,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: _completedThisVisit.isEmpty
                ? ColorManager.gray200
                : ColorManager.success,
            borderRadius: BorderRadiusManager.lg,
          ),
          child: Text(
            _completedThisVisit.isEmpty
                ? 'Select treatments to complete'
                : 'Save Visit (${_completedThisVisit.length} completed)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: _completedThisVisit.isEmpty
                  ? ColorManager.textTertiary
                  : ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
