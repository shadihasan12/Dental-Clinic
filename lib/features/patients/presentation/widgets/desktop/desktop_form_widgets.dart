import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

/// Desktop-native form components for the patients feature.
/// Uses raw pixel values (no ScreenUtil) — safe to use inside desktop layouts
/// where `.sp/.w/.h` can reset to desktop-pixel scale.

class DesktopSectionCard extends StatelessWidget {
  const DesktopSectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 12.5,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Divider(height: 1, color: c.borderLight),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

class DesktopTextField extends StatelessWidget {
  const DesktopTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.isRequired = false,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12.5,
                color: c.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              children: isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: ColorManager.error),
                      ),
                    ]
                  : null,
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            onChanged: onChanged,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13.5,
              color: c.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13.5,
                color: c.textSubtle,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: maxLines > 1 ? 12 : 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopDateField extends StatelessWidget {
  const DesktopDateField({
    super.key,
    required this.label,
    this.value,
    required this.onTap,
    this.placeholder,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12.5,
            color: c.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: c.inputBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: c.borderLight),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value != null
                          ? _fmt(value!)
                          : (placeholder ?? 'dd/mm/yyyy'),
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13.5,
                        color: value != null ? c.textPrimary : c.textSubtle,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: c.textTertiary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class DesktopDropdownField extends StatelessWidget {
  const DesktopDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12.5,
            color: c.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hint ?? 'Select',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  color: c.textSubtle,
                ),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: c.textTertiary),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13.5,
                color: c.textPrimary,
              ),
              dropdownColor: c.cardBg,
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
