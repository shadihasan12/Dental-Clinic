import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';

export 'package:dental_clinic_app/core/models/audit_entry.dart';
export 'package:dental_clinic_app/services/currency/currency_entity.dart';

part 'expense_entity.freezed.dart';

@freezed
class ExpenseCategoryEntity with _$ExpenseCategoryEntity {
  const factory ExpenseCategoryEntity({
    required String id,
    required String name,
  }) = _ExpenseCategoryEntity;
}

@freezed
class AttachmentEntity with _$AttachmentEntity {
  const factory AttachmentEntity({
    required String viewUrl,
    required String downloadUrl,
  }) = _AttachmentEntity;
}

@freezed
class ExpenseEntity with _$ExpenseEntity {
  const factory ExpenseEntity({
    required String id,
    required String amount,
    required CurrencyEntity currency,
    required String entryDate,
    @Default('') String notes,
    required ExpenseCategoryEntity category,
    @Default([]) List<AttachmentEntity> attachments,
    @Default('') String createdAt,
    @Default([]) List<AuditEntry> audits,
  }) = _ExpenseEntity;
}

@freezed
class ExpenseTotalEntity with _$ExpenseTotalEntity {
  const factory ExpenseTotalEntity({
    required String currencyId,
    required String currencyCode,
    required String currencyName,
    required String total,
  }) = _ExpenseTotalEntity;
}

@freezed
class ExpenseListResponse with _$ExpenseListResponse {
  const factory ExpenseListResponse({
    required List<ExpenseEntity> expenses,
    required List<ExpenseTotalEntity> totals,
  }) = _ExpenseListResponse;
}
