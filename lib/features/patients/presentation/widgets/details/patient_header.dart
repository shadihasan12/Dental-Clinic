import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final VoidCallback onBackPressed;
  final VoidCallback? onEditPressed;
  final TabController tabController;

  const PatientHeader({
    super.key,
    required this.name,
    required this.onBackPressed,
    required this.tabController,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        PageHeader(
          title: name,
          onBack: onBackPressed,
          actions: [
            if (onEditPressed != null)
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: ColorManager.of(context).textSecondary,
                  size: 20.w,
                ),
                onPressed: onEditPressed,
              ),
          ],
        ),
        Container(
          color: ColorManager.of(context).cardBg,
          child: TabBar(
            controller: tabController,
            labelColor: ColorManager.primary,
            unselectedLabelColor: ColorManager.of(context).textTertiary,
            indicatorColor: ColorManager.primary,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: ColorManager.of(context).borderLight,
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w400,
            ),
            tabs: [
              Tab(text: l10n.info),
              Tab(text: l10n.case_),
              Tab(text: l10n.history),
            ],
          ),
        ),
      ],
    );
  }
}
