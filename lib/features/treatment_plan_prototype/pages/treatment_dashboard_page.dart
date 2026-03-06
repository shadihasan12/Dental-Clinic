import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';
import '../widgets/plan_summary_header.dart';
import '../widgets/treatment_plan_card.dart';
import 'tooth_treatment_picker_page.dart';
import 'visit_session_page.dart';
import 'quick_add_treatment_page.dart';

/// Main dashboard showing the treatment plan overview.
/// This is the primary page a dentist sees when viewing a patient's plan.
class TreatmentDashboardPage extends StatefulWidget {
  const TreatmentDashboardPage({super.key});

  @override
  State<TreatmentDashboardPage> createState() =>
      _TreatmentDashboardPageState();
}

class _TreatmentDashboardPageState extends State<TreatmentDashboardPage> {
  late TreatmentPlan _plan;
  int _selectedTab = 0; // 0=All, 1=By Tooth, 2=General

  @override
  void initState() {
    super.initState();
    _plan = MockData.samplePlan();
  }

  void _addTreatments(List<PlannedTreatment> treatments) {
    setState(() {
      _plan.treatments.addAll(treatments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      floatingActionButton: _buildFab(context),
      body: Column(
        children: [
          PageHeader(
            title: 'Treatment Plan',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Summary header
                  PlanSummaryHeader(plan: _plan),
                  SizedBox(height: 16.h),

                  // Quick actions
                  _buildQuickActions(context),
                  SizedBox(height: 16.h),

                  // View tabs
                  _buildViewTabs(context),
                  SizedBox(height: 12.h),

                  // Treatment list based on tab
                  if (_selectedTab == 0) _buildAllTreatments(context),
                  if (_selectedTab == 1) _buildByToothView(context),
                  if (_selectedTab == 2) _buildGeneralView(context),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.play_arrow_rounded,
            label: 'Start Visit',
            color: ColorManager.success,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VisitSessionPage(plan: _plan),
              ),
            ).then((_) => setState(() {})),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _ActionButton(
            icon: Icons.add_circle_outline,
            label: 'Plan from Chart',
            color: ColorManager.primary,
            onTap: () async {
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
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _ActionButton(
            icon: Icons.bolt,
            label: 'Quick Add',
            color: ColorManager.warning,
            onTap: () async {
              final result = await Navigator.push<PlannedTreatment>(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuickAddTreatmentPage(),
                ),
              );
              if (result != null) {
                _addTreatments([result]);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildViewTabs(BuildContext context) {
    final tabs = ['All', 'By Tooth', 'General'];
    return Row(
      children: List.generate(tabs.length, (i) {
        final isSelected = _selectedTab == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color:
                    isSelected ? ColorManager.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.borderLight,
                ),
              ),
              child: Text(
                tabs[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).expand((w) sync* {
        yield w;
        yield SizedBox(width: 8.w);
      }).toList()
        ..removeLast(),
    );
  }

  Widget _buildAllTreatments(BuildContext context) {
    // Show planned first, then completed
    final sorted = [
      ..._plan.planned,
      ..._plan.inProgress,
      ..._plan.completed,
    ];

    return Column(
      children: sorted
          .map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: TreatmentPlanCard(treatment: t),
              ))
          .toList(),
    );
  }

  Widget _buildByToothView(BuildContext context) {
    final byTooth = _plan.byTooth;

    if (byTooth.isEmpty) {
      return _emptyState('No tooth-specific treatments yet');
    }

    return Column(
      children: byTooth.entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tooth header
                Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w700,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Tooth ${entry.key}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${entry.value.where((t) => t.status == TreatmentPlanStatus.completed).length}/${entry.value.length}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.textTertiary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ...entry.value.map(
                  (t) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: TreatmentPlanCard(treatment: t),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGeneralView(BuildContext context) {
    final generalTreatments = _plan.generalTreatments;

    if (generalTreatments.isEmpty) {
      return _emptyState('No general treatments yet');
    }

    return Column(
      children: generalTreatments
          .map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: TreatmentPlanCard(treatment: t),
              ))
          .toList(),
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
    return FloatingActionButton.extended(
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
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Treatment',
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadiusManager.lg,
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22.w, color: color),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
