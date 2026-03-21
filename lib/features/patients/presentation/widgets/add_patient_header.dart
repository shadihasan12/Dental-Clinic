import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Header widget for add patient page with progress indicator
class AddPatientHeader extends StatelessWidget {
  const AddPatientHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onBackPressed,
  });

  final int currentStep;
  final int totalSteps;
  final VoidCallback onBackPressed;

  String _stepTitle(AppLocalizations l10n) {
    switch (currentStep) {
      case 1:
        return l10n.patientInfo;
      case 2:
        return l10n.caseInfo;
      case 3:
        return l10n.initialVisit;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF70B2B2), Color(0xFF5A9999), Color(0xFF4A8888)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative circles
          Positioned(
            top: -32.h,
            right: -32.w,
            child: Container(
              width: 160.w,
              height: 160.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            left: -24.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    _buildTitleBar(context),
                    _buildProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: ColorManager.white, size: 24.w),
            onPressed: onBackPressed,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.addNewPatient,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 16.sp,
                            fontFamily: FontFamily.geist,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          l10n.stepOfTotal(currentStep, totalSteps, _stepTitle(l10n)),
                          style: TextStyle(
                            color: ColorManager.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                            fontFamily: FontFamily.geist,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isCompleted = index < currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 6.h,
              decoration: BoxDecoration(
                color: isCompleted
                    ? ColorManager.white
                    : ColorManager.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3.r),
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: ColorManager.white.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }
}
