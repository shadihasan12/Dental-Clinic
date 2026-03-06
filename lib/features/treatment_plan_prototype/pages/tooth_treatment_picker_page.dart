import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';
import '../widgets/tooth_treatment_sheet.dart';
import '../widgets/treatment_plan_card.dart';
import '../widgets/treatment_type_grid.dart';

/// Full-screen interactive tooth chart page.
/// Tap a tooth → bottom sheet appears with tooth-specific treatments.
/// Also has a tab/section for general treatments.
class ToothTreatmentPickerPage extends StatefulWidget {
  final List<PlannedTreatment> existingTreatments;

  const ToothTreatmentPickerPage({
    super.key,
    this.existingTreatments = const [],
  });

  @override
  State<ToothTreatmentPickerPage> createState() =>
      _ToothTreatmentPickerPageState();
}

class _ToothTreatmentPickerPageState extends State<ToothTreatmentPickerPage> {
  final List<PlannedTreatment> _newTreatments = [];
  int _idCounter = 0;
  int _viewMode = 0; // 0 = chart, 1 = general treatments

  // Track which teeth have treatments (existing + new)
  Set<String> get _teethWithTreatments {
    final teeth = <String>{};
    for (final t in widget.existingTreatments) {
      if (t.toothNumber != null) teeth.add(t.toothNumber!);
    }
    for (final t in _newTreatments) {
      if (t.toothNumber != null) teeth.add(t.toothNumber!);
    }
    return teeth;
  }

  void _handleToothTap(String toothNumber) async {
    // Find existing treatment IDs for this tooth
    final existingIds = [
      ...widget.existingTreatments
          .where((t) => t.toothNumber == toothNumber)
          .map((t) => t.type.id),
      ..._newTreatments
          .where((t) => t.toothNumber == toothNumber)
          .map((t) => t.type.id),
    ];

    final selected = await showToothTreatmentSheet(
      context,
      toothNumber: toothNumber,
      existingTreatmentIds: existingIds,
    );

    if (selected != null && selected.isNotEmpty) {
      setState(() {
        for (final type in selected) {
          _newTreatments.add(PlannedTreatment(
            id: 'new_${_idCounter++}',
            type: type,
            toothNumber: toothNumber,
            cost: type.defaultCost,
          ));
        }
      });
    }
  }

  void _addGeneralTreatment(TreatmentTypeInfo type) {
    setState(() {
      _newTreatments.add(PlannedTreatment(
        id: 'new_${_idCounter++}',
        type: type,
        cost: type.defaultCost,
      ));
    });
  }

  void _removeTreatment(int index) {
    setState(() {
      _newTreatments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      bottomNavigationBar: _newTreatments.isNotEmpty
          ? _buildBottomBar(context)
          : null,
      body: Column(
        children: [
          PageHeader(
            title: 'Plan Treatments',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Mode toggle
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: _buildModeToggle(context),
                  ),
                  SizedBox(height: 12.h),

                  if (_viewMode == 0) ...[
                    // Instruction
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.touch_app,
                              size: 20.w,
                              color: ColorManager.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Tap a tooth to add treatments',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Tooth chart
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomCard(
                        child: _InteractiveToothChart(
                          teethWithTreatments: _teethWithTreatments,
                          onToothTap: _handleToothTap,
                        ),
                      ),
                    ),
                  ] else ...[
                    // General treatments grid
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'General Treatments',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'These treatments are not specific to a single tooth',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.textTertiary,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TreatmentTypeGrid(
                              types: MockTreatmentTypes.general,
                              onSelect: _addGeneralTreatment,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),

                  // New treatments list
                  if (_newTreatments.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Text(
                            'Added Treatments',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${_newTreatments.length}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: _newTreatments
                            .asMap()
                            .entries
                            .map((e) => Padding(
                                  padding: EdgeInsets.only(bottom: 6.h),
                                  child: Dismissible(
                                    key: Key(e.value.id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (_) =>
                                        _removeTreatment(e.key),
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding:
                                          EdgeInsets.only(right: 16.w),
                                      decoration: BoxDecoration(
                                        color: ColorManager.error
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: ColorManager.error,
                                        size: 22.w,
                                      ),
                                    ),
                                    child: TreatmentPlanCard(
                                      treatment: e.value,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.gray100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _modeTab(context, 0, Icons.grid_view_rounded, 'Tooth Chart'),
          SizedBox(width: 4.w),
          _modeTab(context, 1, Icons.medical_services_outlined, 'General'),
        ],
      ),
    );
  }

  Widget _modeTab(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = _viewMode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _viewMode = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.w,
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.textTertiary,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final totalCost =
        _newTreatments.fold<double>(0, (sum, t) => sum + t.cost);

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
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_newTreatments.length} treatments',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary,
                ),
              ),
              Text(
                '\$${totalCost.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context, _newTreatments),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Text(
                  'Add to Plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
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
    );
  }
}

/// Wraps the existing ToothChart to make individual teeth tappable
/// and shows visual indicators for teeth with treatments.
class _InteractiveToothChart extends StatelessWidget {
  final Set<String> teethWithTreatments;
  final ValueChanged<String> onToothTap;

  const _InteractiveToothChart({
    required this.teethWithTreatments,
    required this.onToothTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The tooth chart
        ToothChart(
          teeth: _allTeeth(),
          selectedTeeth: teethWithTreatments.toList(),
          onSelectionChanged: (toothIds) {
            // Find the last selected tooth (the one just tapped)
            if (toothIds.isNotEmpty) {
              onToothTap(toothIds.last);
            }
          },
          aspectRatio: 0.75,
        ),

        // Legend
        if (teethWithTreatments.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primary,
                    width: 1.5,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Has planned treatment',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Generate all 32 teeth for the chart
  List<Tooth> _allTeeth() {
    final teeth = <Tooth>[];
    for (int q = 1; q <= 4; q++) {
      for (int t = 1; t <= 8; t++) {
        final code = '$q$t';
        teeth.add(Tooth(
          id: code,
          name: 'Tooth $code',
          universalCode: code,
          quadrant: '$q',
        ));
      }
    }
    return teeth;
  }
}
