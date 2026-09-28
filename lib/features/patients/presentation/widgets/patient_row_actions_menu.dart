import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// The "..." menu on a desktop patient row or card: edit and delete.
///
/// Drawn on the card surface with the same hairline border as the rest of
/// the page, rather than Material 3's tinted default, so it reads as part of
/// the table it opens from.
class PatientRowActionsMenu extends StatelessWidget {
  const PatientRowActionsMenu({super.key, this.onEdit, this.onDelete});

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<int>(
      tooltip: '',
      padding: EdgeInsets.zero,
      iconSize: 18,
      icon: Icon(Icons.more_horiz, color: c.textTertiary),
      position: PopupMenuPosition.under,
      offset: const Offset(0, 4),
      color: c.cardBg,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: isDark ? 0.5 : 0.18),
      menuPadding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(minWidth: 168),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: c.borderLight),
      ),
      onSelected: (value) {
        if (value == 0) onEdit?.call();
        if (value == 1) onDelete?.call();
      },
      itemBuilder: (context) => [
        if (onEdit != null)
          _item(
            context,
            value: 0,
            icon: Icons.edit_outlined,
            label: l10n.edit,
            color: c.textPrimary,
            iconColor: isDark ? ColorManager.primary : ColorManager.primaryDark,
            iconBg: ColorManager.primary.withValues(alpha: 0.12),
          ),
        if (onEdit != null && onDelete != null)
          PopupMenuItem<int>(
            enabled: false,
            height: 9,
            padding: EdgeInsets.zero,
            child: Divider(height: 9, color: c.borderLight),
          ),
        if (onDelete != null)
          _item(
            context,
            value: 1,
            icon: Icons.delete_outline_rounded,
            label: l10n.delete,
            color: ColorManager.error,
            iconColor: ColorManager.error,
            iconBg: ColorManager.error.withValues(alpha: 0.10),
          ),
      ],
    );
  }

  PopupMenuItem<int> _item(
    BuildContext context, {
    required int value,
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required Color iconBg,
  }) {
    return PopupMenuItem<int>(
      value: value,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      mouseCursor: SystemMouseCursors.click,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: FontHelper.fontFamily(context),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
