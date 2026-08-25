import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';

class ExpenseModel {
  final String id;
  final String amount;
  final Map<String, dynamic> currency;
  final String entryDate;
  final String notes;
  final Map<String, dynamic> category;
  final List<Map<String, dynamic>> attachments;
  final String createdAt;
  final List<AuditEntry> audits;

  const ExpenseModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.entryDate,
    this.notes = '',
    required this.category,
    this.attachments = const [],
    this.createdAt = '',
    this.audits = const [],
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      amount: json['amount'] as String? ?? '0',
      currency: json['currency'] as Map<String, dynamic>? ?? {},
      entryDate: json['entry_date'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      category: json['category'] as Map<String, dynamic>? ?? {},
      attachments: (json['attachments'] as List?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      createdAt: json['created_at'] as String? ?? '',
      audits: AuditEntry.listFromJson(json['audits']),
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      amount: amount,
      currency: CurrencyEntity(
        id: currency['id'] as String? ?? '',
        currencyName: currency['currency_name'] as String? ?? '',
        currencyCode: currency['currency_code'] as String? ?? '',
      ),
      entryDate: entryDate,
      notes: notes,
      category: ExpenseCategoryEntity(
        id: category['id'] as String? ?? '',
        name: category['name'] as String? ?? '',
      ),
      attachments: attachments
          .map((a) => AttachmentEntity(
                viewUrl: a['view'] as String? ?? '',
                downloadUrl: a['download'] as String? ?? '',
              ))
          .toList(),
      createdAt: createdAt,
      audits: audits,
    );
  }
}

class ExpenseCategoryModel {
  final String id;
  final String name;

  const ExpenseCategoryModel({required this.id, required this.name});

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  ExpenseCategoryEntity toEntity() {
    return ExpenseCategoryEntity(id: id, name: name);
  }
}

class ExpenseTotalModel {
  final String currencyId;
  final String currencyCode;
  final String currencyName;
  final String total;

  const ExpenseTotalModel({
    required this.currencyId,
    required this.currencyCode,
    required this.currencyName,
    required this.total,
  });

  factory ExpenseTotalModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTotalModel(
      currencyId: json['currency_id'] as String? ?? '',
      currencyCode: json['currency_code'] as String? ?? '',
      currencyName: json['currency_name'] as String? ?? '',
      total: json['total'] as String? ?? '0',
    );
  }

  ExpenseTotalEntity toEntity() {
    return ExpenseTotalEntity(
      currencyId: currencyId,
      currencyCode: currencyCode,
      currencyName: currencyName,
      total: total,
    );
  }
}
