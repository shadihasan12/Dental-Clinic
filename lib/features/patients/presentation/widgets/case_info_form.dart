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
    return Column(
      children: [
        SectionCard(
          title: 'Case Information (Optional)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A case will be automatically created for this patient. '
                'You can add a title or skip this step.',
                style: TextStyleManager.bodyMedium.copyWith(
                  color: ColorManager.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              AppFormField(
                label: 'Case Title',
                controller: caseTitleController,
                hintText: 'e.g., Full Mouth Restoration, Orthodontic Treatment',
              ),
            ],
          ),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }
}
