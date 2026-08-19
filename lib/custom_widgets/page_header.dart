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

  // Why kToolbarHeight + 9: IconButton's minimum interactive size is 48dp,
  // the row sits inside 8.h vertical padding (~16dp on a 1.0 scale), and
  // the bottom Divider adds another 1dp. 56 + 1 wasn't tall enough and
  // caused an ~8px RenderFlex overflow on standard Android devices.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 9);

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: c.surfaceBg,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: c.textPrimary,
                      size: 20.w,
                    ),
                    // Callers that need a guarded back (e.g. pages reachable
                    // with an empty stack) pass their own onBack. Falling back
                    // to a bare pop kept the parameter dead and threw
                    // "there is nothing to pop" on those pages.
                    onPressed: onBack ?? () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  if (actions != null) ...actions!,
                  if (actions != null) SizedBox(width: 12.w),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, color: c.borderLight),
      ],
    );
  }
}
