import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double borderRadius;
  final IconData? icon;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.borderRadius = 20,
    this.icon,
  });

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isDesktop = Responsive.isDesktop(context);

    // Desktop uses plain pixel values; mobile uses ScreenUtil-scaled values.
    final double hPad = isDesktop ? 14 : 14.w;
    final double vPad = isDesktop ? 9 : 8.h;
    final double fontSize = isDesktop ? 13 : 13.sp;
    final double iconSize = isDesktop ? 15 : 14.w;
    final double radius = isDesktop ? widget.borderRadius : widget.borderRadius.r;

    final Color bg;
    if (widget.isSelected) {
      bg = ColorManager.primary;
    } else if (_hovered && isDesktop) {
      bg = ColorManager.primary.withValues(alpha: 0.08);
    } else {
      bg = c.cardBgSecondary;
    }

    final Color borderColor;
    if (widget.isSelected) {
      borderColor = ColorManager.primary;
    } else if (_hovered && isDesktop) {
      borderColor = ColorManager.primary.withValues(alpha: 0.35);
    } else {
      borderColor = c.border;
    }

    final Color fgColor =
        widget.isSelected ? Colors.white : c.textPrimary;

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
        boxShadow: widget.isSelected && isDesktop
            ? [
                BoxShadow(
                  color: ColorManager.primary.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, size: iconSize, color: fgColor),
            SizedBox(width: isDesktop ? 6 : 6.w),
          ],
          Text(
            widget.label,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: fgColor,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );

    if (!isDesktop) {
      return GestureDetector(onTap: widget.onTap, child: child);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(onTap: widget.onTap, child: child),
    );
  }
}
