import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// Colour, icon and label for a report's status, in one place so the
/// leading strip, the icon tile and the pill can never drift apart.
///
/// Hues follow the house rule — planned is the brand blue, in progress is
/// orange, done is green.
class IssueStatusStyle {
  const IssueStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  factory IssueStatusStyle.of(BuildContext context, IssueStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case IssueStatus.pending:
        return IssueStatusStyle(
          color: ColorManager.primary,
          icon: Icons.schedule_rounded,
          label: l10n.issueStatusPending,
        );
      case IssueStatus.inProgress:
        return IssueStatusStyle(
          color: ColorManager.warning,
          icon: Icons.sync_rounded,
          label: l10n.issueStatusInProgress,
        );
      case IssueStatus.done:
        return IssueStatusStyle(
          color: ColorManager.success,
          icon: Icons.check_rounded,
          label: l10n.issueStatusDone,
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
