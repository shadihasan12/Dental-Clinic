import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// Colour, icon and label for a report's status, in one place so the
/// leading strip, the icon tile and the pill can never drift apart.
///
/// The label is the server's — it arrives already translated with the
/// statuses list — and the local strings are only the fallback for a list
/// that has not loaded yet. Colour and icon stay client-side; the API has no
/// opinion on those.
class IssueStatusStyle {
  const IssueStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  /// [serverLabel] is what `GET /tickets/statuses` called this value. For a
  /// status this build has never heard of it is the raw wire value, which is
  /// still better than an empty pill.
  factory IssueStatusStyle.of(
    BuildContext context,
    IssueStatus status, {
    String? serverLabel,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final label = (serverLabel != null && serverLabel.isNotEmpty)
        ? serverLabel
        : null;

    switch (status) {
      case IssueStatus.open:
        return IssueStatusStyle(
          color: ColorManager.primary,
          icon: Icons.schedule_rounded,
          label: label ?? l10n.issueStatusOpen,
        );
      case IssueStatus.inProgress:
        return IssueStatusStyle(
          color: ColorManager.warning,
          icon: Icons.sync_rounded,
          label: label ?? l10n.issueStatusInProgress,
        );
      case IssueStatus.resolved:
        return IssueStatusStyle(
          color: ColorManager.success,
          icon: Icons.check_rounded,
          label: label ?? l10n.issueStatusResolved,
        );
      case IssueStatus.closed:
        return IssueStatusStyle(
          color: ColorManager.textTertiary,
          icon: Icons.inbox_rounded,
          label: label ?? l10n.issueStatusClosed,
        );
      case IssueStatus.unknown:
        // A status added server-side after this build shipped: shown, not
        // hidden, in neutral grey with whatever the server calls it.
        return IssueStatusStyle(
          color: ColorManager.textTertiary,
          icon: Icons.flag_outlined,
          label: label ?? '',
        );
    }
  }

  /// The 50-level tint of the same hue. Derived rather than hardcoded so it
  /// still reads on the dark theme, where the literal light-mode tints
  /// would glow.
  Color tint(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return color.withValues(alpha: isDark ? 0.18 : 0.10);
  }
}
