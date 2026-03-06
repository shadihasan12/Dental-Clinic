import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'pages/treatment_dashboard_page.dart';

/// Hub page for exploring the treatment plan prototype.
class TreatmentPrototypeHub extends StatelessWidget {
  const TreatmentPrototypeHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          PageHeader(
            title: 'Treatment Prototype',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: ColorManager.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.science_outlined,
                          size: 20.w,
                          color: ColorManager.primary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'This is a design-only prototype with mock data. '
                            'Explore the UX flow for treatment planning.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.primary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Pages
                  _PageCard(
                    icon: Icons.dashboard_outlined,
                    title: 'Treatment Dashboard',
                    subtitle:
                        'Main overview — summary, quick actions, treatment list with tabs',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TreatmentDashboardPage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // UX Notes
                  SizedBox(height: 20.h),
                  Text(
                    'UX Notes',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _NoteItem(
                    text:
                        'Dentist can plan treatments per tooth (from chart) or as general treatments',
                  ),
                  _NoteItem(
                    text:
                        'Quick Add mode for simple entry without the tooth chart',
                  ),
                  _NoteItem(
                    text:
                        'Visit sessions let you check off treatments as you go',
                  ),
                  _NoteItem(
                    text:
                        'Dashboard shows progress with summary stats and grouped views',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PageCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 22.w, color: ColorManager.primary),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textTertiary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.w,
            color: ColorManager.gray300,
          ),
        ],
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  final String text;

  const _NoteItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(
              Icons.check_circle,
              size: 16.w,
              color: ColorManager.success,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
