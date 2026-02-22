import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PageHeader extends StatelessWidget implements PreferredSizeWidget {
  const PageHeader({super.key, required this.title, this.onBack, this.actions});

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: ColorManager.white,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.textPrimary,
                      size: 20.w,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, color: ColorManager.borderLight),
      ],
    );
  }
}
