import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Header widget for the add-patient wizard. Standard [PageHeader] on top,
/// then a step subtitle + horizontal progress bar.
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
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Column(
      children: [
        PageHeader(
          title: l10n.addNewPatient,
          onBack: onBackPressed,
        ),
        Container(
          width: double.infinity,
          color: c.cardBg,
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.stepOfTotal(currentStep, totalSteps, _stepTitle(l10n)),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: c.textTertiary,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: List.generate(totalSteps, (index) {
                  final isCompleted = index < currentStep;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? ColorManager.primary
                            : ColorManager.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
