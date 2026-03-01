import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_entity.freezed.dart';

enum ExpenseCategory { supplies, lab, equipment, rent, salary, other }

@freezed
class ExpenseEntity with _$ExpenseEntity {
  const factory ExpenseEntity({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    required ExpenseCategory category,
  }) = _ExpenseEntity;
}
