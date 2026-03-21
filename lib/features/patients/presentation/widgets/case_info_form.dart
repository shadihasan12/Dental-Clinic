import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

/// Step 2: Case information form (optional)
class CaseInfoForm extends StatelessWidget {
  const CaseInfoForm({
    super.key,
    required this.caseTitleController,
  });

  final TextEditingController caseTitleController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        SectionCard(
          title: l10n.caseInformationOptional,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.caseAutoCreateDescription,
                style: TextStyleManager.bodyMedium.copyWith(
                  color: ColorManager.of(context).textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              AppFormField(
                label: l10n.caseTitle,
                controller: caseTitleController,
                hintText: l10n.caseTitleExampleHint,
              ),
            ],
          ),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }
}
