import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

// Re-export entity so existing imports keep working
export 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';

// ─── Category helpers ─────────────────────────────────────────────────────────

IconData categoryIcon(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.supplies:
      return Icons.inventory_2_outlined;
    case ExpenseCategory.lab:
      return Icons.science_outlined;
    case ExpenseCategory.equipment:
      return Icons.build_outlined;
    case ExpenseCategory.rent:
      return Icons.home_outlined;
    case ExpenseCategory.salary:
      return Icons.person_outlined;
    case ExpenseCategory.other:
      return Icons.receipt_outlined;
  }
}

Color categoryColor(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.supplies:
      return const Color(0xFF70B2B2);
    case ExpenseCategory.lab:
      return const Color(0xFF8B5CF6);
    case ExpenseCategory.equipment:
      return const Color(0xFFF59E0B);
    case ExpenseCategory.rent:
      return const Color(0xFF3B82F6);
    case ExpenseCategory.salary:
      return const Color(0xFF10B981);
    case ExpenseCategory.other:
      return const Color(0xFF6B7280);
  }
}

String categoryLabel(BuildContext context, ExpenseCategory category) {
  final l10n = AppLocalizations.of(context)!;
  switch (category) {
    case ExpenseCategory.supplies:
      return l10n.expenseCategorySupplies;
    case ExpenseCategory.lab:
      return l10n.expenseCategoryLab;
    case ExpenseCategory.equipment:
      return l10n.expenseCategoryEquipment;
    case ExpenseCategory.rent:
      return l10n.expenseCategoryRent;
    case ExpenseCategory.salary:
      return l10n.expenseCategorySalary;
    case ExpenseCategory.other:
      return l10n.expenseCategoryOther;
  }
}
