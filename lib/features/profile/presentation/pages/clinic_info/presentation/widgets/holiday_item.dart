import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/clinic_info_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class HolidayItem extends StatelessWidget {
  const HolidayItem({
    super.key,
    required this.holiday,
    required this.isLast,
    required this.onEdit,
    required this.onDelete,
  });

  final HolidayEntry holiday;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Date badge
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${holiday.date.day}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                      height: 1,
                    ),
                  ),
                  Text(
                    AppDate.monthAbbr(context, holiday.date),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Name + recurring tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: c.textPrimary,
                    ),
                  ),
                  if (holiday.recurring) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          size: 11.w,
                          color: c.textTertiary,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          l10n.recurring,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 10.w),
            // Actions
            _HolidayAction(
              icon: Icons.edit_outlined,
              tooltip: l10n.edit,
              background: c.cardBgSecondary,
              hoverBackground: ColorManager.primary.withValues(alpha: 0.10),
              border: c.borderLight,
              foreground: c.textSecondary,
              hoverForeground: ColorManager.primaryDarker,
              onTap: onEdit,
            ),
            SizedBox(width: 8.w),
            _HolidayAction(
              icon: Icons.delete_outline_rounded,
              tooltip: l10n.delete,
              background: ColorManager.error.withValues(alpha: 0.08),
              hoverBackground: ColorManager.error.withValues(alpha: 0.16),
              foreground: ColorManager.error,
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// A small square icon button for the row's actions. A tinted tile gives the
/// icon a clear hit area and tells edit from delete at a glance, where bare
/// icons at the row's end read as decoration.
class _HolidayAction extends StatefulWidget {
  const _HolidayAction({
    required this.icon,
    required this.tooltip,
    required this.background,
    required this.hoverBackground,
    required this.foreground,
    required this.onTap,
    this.hoverForeground,
    this.border,
  });

  final IconData icon;
  final String tooltip;
  final Color background;
  final Color hoverBackground;
  final Color foreground;
  final Color? hoverForeground;
  final Color? border;
  final VoidCallback onTap;

  @override
  State<_HolidayAction> createState() => _HolidayActionState();
}

class _HolidayActionState extends State<_HolidayAction> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final fg = _hovering
        ? (widget.hoverForeground ?? widget.foreground)
        : widget.foreground;
    return Tooltip(
      // Font comes from the app theme, which already follows the locale.
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            // 36 stays a comfortable thumb target on a phone and still sits
            // inside the 44px date badge's row height.
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: _hovering ? widget.hoverBackground : widget.background,
              borderRadius: BorderRadius.circular(10.r),
              border: widget.border == null
                  ? null
                  : Border.all(color: widget.border!),
            ),
            child: Icon(widget.icon, size: 18.w, color: fg),
          ),
        ),
      ),
    );
  }
}
