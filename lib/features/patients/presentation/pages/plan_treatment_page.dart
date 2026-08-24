import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/tooth_treatment_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_plan_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_type_grid.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Full-screen interactive tooth chart page.
/// Tap a tooth → bottom sheet appears with tooth-specific treatments.
/// Also has a tab/section for general treatments.
class PlanTreatmentPage extends StatefulWidget {
  final List<PlannedTreatment> existingTreatments;
  final List<TreatmentCategoryGroup> categories;
  final List<Tooth> teeth;

  const PlanTreatmentPage({
    super.key,
    this.existingTreatments = const [],
    this.categories = const [],
    this.teeth = const [],
  });

  @override
  State<PlanTreatmentPage> createState() =>
      _PlanTreatmentPageState();
}

class _PlanTreatmentPageState extends State<PlanTreatmentPage> {
  final List<PlannedTreatment> _newTreatments = [];
  int _idCounter = 0;
  int _viewMode = 0;

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
      toothSpecificTypes:
          widget.categories.isNotEmpty ? widget.categories[0].treatments : [],
    );

    if (selected != null && selected.isNotEmpty) {
      setState(() {
        for (final type in selected) {
          _newTreatments.add(PlannedTreatment(
            id: 'new_${_idCounter++}',
            type: type,
            toothNumber: toothNumber,
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
      backgroundColor: ColorManager.of(context).scaffoldBg,
      bottomNavigationBar: _newTreatments.isNotEmpty
          ? _buildBottomBar(context)
          : null,
      body: Column(
        children: [
          PageHeader(
            title: AppLocalizations.of(context)!.planTreatments,
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
                                AppLocalizations.of(context)!.tapToothToAddTreatments,
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
                          teeth: widget.teeth,
                        ),
                      ),
                    ),
                  ] else if (_viewMode > 0 &&
                      _viewMode < widget.categories.length) ...[
                    // Category treatments grid
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categories[_viewMode].name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.of(context).textPrimary,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TreatmentTypeGrid(
                              types: widget.categories[_viewMode].treatments,
                              selectedIds: _newTreatments
                                  .where((t) => t.toothNumber == null)
                                  .map((t) => t.type.id)
                                  .toSet(),
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
                            AppLocalizations.of(context)!.addedTreatments,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.of(context).textPrimary,
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
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          for (int i = 0; i < widget.categories.length; i++) ...[
            if (i > 0) SizedBox(width: 4.w),
            _modeTab(
              context,
              i,
              i == 0
                  ? Icons.grid_view_rounded
                  : Icons.medical_services_outlined,
              widget.categories[i].name,
            ),
          ],
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
            color: isSelected ? ColorManager.of(context).cardBg : Colors.transparent,
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
                    : ColorManager.of(context).textTertiary,
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
                      : ColorManager.of(context).textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        scaffoldBottomPadding(context, 12.h),
      ),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
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
          Text(
            AppLocalizations.of(context)!.nTreatments(_newTreatments.length),
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textSecondary,
            ),
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
                  AppLocalizations.of(context)!.addToPlan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
  final List<Tooth> teeth;

  const _InteractiveToothChart({
    required this.teethWithTreatments,
    required this.onToothTap,
    required this.teeth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The tooth chart
        ToothChart(
          teeth: teeth.isNotEmpty ? teeth : _fallbackTeeth(),
          selectedTeeth: _toSelectedIds(teethWithTreatments),
          onSelectionChanged: (toothIds) {
            // Find the last selected tooth (the one just tapped)
            if (toothIds.isNotEmpty) {
              final tappedId = toothIds.last;
              // Convert tooth ID back to universal code
              final code = _idToCode(tappedId);
              onToothTap(code);
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
                AppLocalizations.of(context)!.hasPlannedTreatment,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Convert universal codes (used in treatments) to tooth IDs (used by chart)
  List<String> _toSelectedIds(Set<String> universalCodes) {
    if (teeth.isEmpty) return universalCodes.toList();
    return teeth
        .where((t) => universalCodes.contains(t.universalCode))
        .map((t) => t.id)
        .toList();
  }

  /// Convert a tooth ID back to its universal code
  String _idToCode(String toothId) {
    if (teeth.isEmpty) return toothId;
    final tooth = teeth.where((t) => t.id == toothId);
    if (tooth.isNotEmpty) return tooth.first.universalCode;
    return toothId;
  }

  /// Fallback: generate all 32 teeth for the chart
  List<Tooth> _fallbackTeeth() {
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
