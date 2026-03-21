import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class CaseHistoryTab extends StatelessWidget {
  final List<DentalCase> completedCases;
  final ValueChanged<DentalCase> onCaseTap;

  const CaseHistoryTab({
    super.key,
    required this.completedCases,
    required this.onCaseTap,
  });

  @override
  Widget build(BuildContext context) {
    if (completedCases.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: completedCases.length,
      itemBuilder: (context, index) {
        final dentalCase = completedCases[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CaseHistoryCard(
            dentalCase: dentalCase,
            onTap: () => onCaseTap(dentalCase),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64.w,
            color: ColorManager.of(context).textTertiary,
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.noCaseHistory,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.completedCasesWillAppear,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}