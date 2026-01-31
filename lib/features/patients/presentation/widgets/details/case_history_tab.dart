import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';

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
      return _buildEmptyState();
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64.w,
            color: ColorManager.textTertiary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No case history',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Completed cases will appear here',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}