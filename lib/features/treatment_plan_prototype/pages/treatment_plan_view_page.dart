import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';
import '../widgets/plan_summary_header.dart';
import '../widgets/treatment_plan_card.dart';
import 'tooth_treatment_picker_page.dart';

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

  void _markFinished(PlannedTreatment treatment) {
    setState(() {
      treatment.status = TreatmentPlanStatus.completed;
      treatment.completedDate = DateTime.now();
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
              'Edit Cost',
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
              'Record Payment',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Pending: ${_plan.pending.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                color: ColorManager.textTertiary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(ctx),
                fontWeight: FontWeight.w500,
                color: ColorManager.textSecondary,
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
                color: ColorManager.textPrimary,
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
                  'Record Payment',
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

  void _showTreatmentDetailsSheet(PlannedTreatment treatment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _TreatmentDetailsSheet(
        treatment: treatment,
        allTreatments: _plan.treatments,
        onNoteSaved: (text) {
          setState(() {
            treatment.visitNotes.add(VisitNote(
              date: DateTime.now(),
              text: text,
            ));
          });
        },
      ),
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
            bottom: 16.h,
            child: _buildFab(context),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      floatingActionButton: _buildFab(context),
      body: Column(
        children: [
          PageHeader(
            title: 'Treatment Plan',
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

    if (sorted.isEmpty) return _emptyState('No treatments yet — add one!');

    return Column(
      children: sorted.map((t) {
        final isCompleted = t.status == TreatmentPlanStatus.completed;
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? ColorManager.success.withValues(alpha: 0.04)
                  : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isCompleted
                    ? ColorManager.success.withValues(alpha: 0.2)
                    : ColorManager.borderLight,
              ),
            ),
            child: Column(
              children: [
                TreatmentPlanCard(
                  treatment: t,
                  removeBorder: true,
                  onTap: () => _showTreatmentDetailsSheet(t),
                ),
                if (!isCompleted) ...[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: ColorManager.borderLight,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showTreatmentDetailsSheet(t),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.note_add_outlined,
                                  size: 15.w,
                                  color: ColorManager.textSecondary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Add Note',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily:
                                        FontHelper.fontFamily(context),
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 28.h,
                        color: ColorManager.borderLight,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _markFinished(t),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 15.w,
                                  color: ColorManager.textSecondary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Mark Finished',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily:
                                        FontHelper.fontFamily(context),
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Expandable options
        if (_isFabOpen) ...[
          _buildFabOption(
            icon: Icons.medical_services_outlined,
            label: 'Add Treatment',
            onTap: () async {
              _toggleFab();
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
          ),
          SizedBox(height: 10.h),
          _buildFabOption(
            icon: Icons.payments_outlined,
            label: 'Record Payment',
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
              color: ColorManager.white,
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
                color: ColorManager.textPrimary,
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

// ─── Treatment Details Bottom Sheet ─────────────────────────────────
class _TreatmentDetailsSheet extends StatefulWidget {
  final PlannedTreatment treatment;
  final List<PlannedTreatment> allTreatments;
  final ValueChanged<String> onNoteSaved;

  const _TreatmentDetailsSheet({
    required this.treatment,
    required this.allTreatments,
    required this.onNoteSaved,
  });

  @override
  State<_TreatmentDetailsSheet> createState() => _TreatmentDetailsSheetState();
}

class _TreatmentDetailsSheetState extends State<_TreatmentDetailsSheet> {
  final _controller = TextEditingController();
  bool _showNoteInput = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.treatment;
    final isCompleted = t.status == TreatmentPlanStatus.completed;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 16.h,
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

          // Header
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: _statusColor(t).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  t.type.icon,
                  size: 22.w,
                  color: _statusColor(t),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.type.nameEn,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      t.type.nameAr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _statusColor(t).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _statusLabel(t),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: _statusColor(t),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Info rows
          if (t.toothNumber != null)
            _infoRow(context,
                icon: Icons.location_on_outlined,
                label: 'Tooth',
                value: t.toothNumber!),
          if (!t.isToothSpecific)
            _infoRow(context,
                icon: Icons.category_outlined,
                label: 'Type',
                value: 'General Treatment'),
          if (isCompleted && t.completedDate != null)
            _infoRow(context,
                icon: Icons.check_circle_outline,
                label: 'Completed',
                value:
                    '${t.completedDate!.day}/${t.completedDate!.month}/${t.completedDate!.year}'),

          // Tooth chart
          if (t.isToothSpecific) ...[
            SizedBox(height: 8.h),
            ToothChart(
              teeth: _allTeeth(),
              selectedTeeth: widget.allTreatments
                  .where((tr) => tr.toothNumber != null)
                  .map((tr) => tr.toothNumber!)
                  .toSet()
                  .toList(),
              enabled: false,
              aspectRatio: 0.75,
            ),
          ],
          SizedBox(height: 8.h),

          // Visit notes
          if (t.visitNotes.isNotEmpty) ...[
            Row(
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
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${t.visitNotes.length}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 180.h),
              child: SingleChildScrollView(
                child: Column(
                  children: t.visitNotes.map((note) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: ColorManager.gray50,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: ColorManager.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.event_note,
                                    size: 14.w,
                                    color: ColorManager.primary),
                                SizedBox(width: 6.w),
                                Text(
                                  '${note.date.day}/${note.date.month}/${note.date.year}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily:
                                        FontHelper.fontFamily(context),
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              note.text,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],

          // Add note
          if (_showNoteInput) ...[
            TextField(
              controller: _controller,
              maxLines: 3,
              autofocus: true,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. Changed upper wire to 0.016 NiTi...',
                hintStyle: TextStyle(
                    fontSize: 13.sp, color: ColorManager.textTertiary),
                contentPadding: EdgeInsets.all(12.w),
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
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showNoteInput = false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.borderLight),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.text.trim().isNotEmpty) {
                        widget.onNoteSaved(_controller.text.trim());
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Save Note',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            GestureDetector(
              onTap: () => setState(() => _showNoteInput = true),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.borderLight),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_add_outlined,
                        size: 16.w, color: ColorManager.textSecondary),
                    SizedBox(width: 6.w),
                    Text(
                      'Add Visit Note',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w500,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 16.w, color: ColorManager.textTertiary),
          SizedBox(width: 8.w),
          Text('$label: ',
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary)),
          Text(value,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary)),
        ],
      ),
    );
  }

  List<Tooth> _allTeeth() {
    final teeth = <Tooth>[];
    for (int q = 1; q <= 4; q++) {
      for (int t = 1; t <= 8; t++) {
        final code = '$q$t';
        teeth.add(Tooth(
            id: code,
            name: 'Tooth $code',
            universalCode: code,
            quadrant: '$q'));
      }
    }
    return teeth;
  }

  Color _statusColor(PlannedTreatment t) {
    return switch (t.status) {
      TreatmentPlanStatus.completed => ColorManager.success,
      TreatmentPlanStatus.inProgress => ColorManager.warning,
      TreatmentPlanStatus.planned => ColorManager.primary,
    };
  }

  String _statusLabel(PlannedTreatment t) {
    return switch (t.status) {
      TreatmentPlanStatus.completed => 'Done',
      TreatmentPlanStatus.inProgress => 'In Progress',
      TreatmentPlanStatus.planned => 'Planned',
    };
  }
}
