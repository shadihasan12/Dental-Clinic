import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class PatientInfoTab extends StatefulWidget {
  final String phone;
  final String email;
  final String address;
  final String medicalHistory;
  final String allergies;
  final String dateOfBirth;
  final int age;
  final String gender;
  final bool initiallyExpanded;

  const PatientInfoTab({
    super.key,
    required this.phone,
    required this.email,
    required this.address,
    required this.medicalHistory,
    required this.allergies,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    this.initiallyExpanded = false,
  });

  @override
  State<PatientInfoTab> createState() => _PatientInfoTabState();
}

class _PatientInfoTabState extends State<PatientInfoTab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Build contact rows dynamically
    final contactRows = <_ContactRowData>[
      _ContactRowData(
        icon: Icons.phone_outlined,
        label: l10n.phone,
        value: widget.phone,
      ),
      _ContactRowData(
        icon: Icons.cake_outlined,
        label: l10n.dateOfBirth,
        value: widget.dateOfBirth,
      ),
      _ContactRowData(
        icon: Icons.man_outlined,
        label: l10n.gender,
        value: widget.gender,
      ),
      if (widget.email.isNotEmpty)
        _ContactRowData(
          icon: Icons.email_outlined,
          label: l10n.email,
          value: widget.email,
        ),
      if (widget.address.isNotEmpty)
        _ContactRowData(
          icon: Icons.location_on_outlined,
          label: l10n.address,
          value: widget.address,
        ),
      _ContactRowData(
        icon: Icons.calendar_month_outlined,
        label: l10n.dateOfBirth,
        value: widget.dateOfBirth,
      ),
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            l10n.personalInformation,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),

          SizedBox(height: 16.h),

          // Contact rows with labels
          ...contactRows.asMap().entries.map((entry) {
            final isLast = entry.key == contactRows.length - 1;
            final row = entry.value;
            return _ContactRow(
              icon: row.icon,
              label: row.label,
              value: row.value,
              showDivider: !isLast,
            );
          }),

          SizedBox(height: 12.h),
          Divider(color: ColorManager.borderLight),
          SizedBox(height: 12.h),

          // Medical History
          _buildSection(
            title: l10n.medicalHistory,
            content: widget.medicalHistory,
          ),

          SizedBox(height: 12.h),
          Divider(color: ColorManager.borderLight),
          SizedBox(height: 12.h),

          // Allergies
          _buildSection(
            title: l10n.allergies,
            content: widget.allergies,
          ),
        ],
      ),
    );
  }


  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w400,
            color: ColorManager.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Internal data class for building contact rows
class _ContactRowData {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRowData({
    required this.icon,
    required this.label,
    required this.value,
  });
}

/// Contact row with icon, label, and value
class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.borderLight, width: 1),
              ),
            )
          : null,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: ColorManager.gray100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16.w, color: ColorManager.darkGrey),
          ),
          SizedBox(width: 12.w),
          // Label + value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w400,
                    color: ColorManager.textTertiary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w400,
                    color: ColorManager.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}