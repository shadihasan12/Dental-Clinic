import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String date;
  final String category;

  const ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
      category: json['category'] as String,
    );
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      date: entity.date.toIso8601String(),
      category: entity.category.name,
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      title: title,
      amount: amount,
      date: DateTime.parse(date),
      category: _parseCategory(category),
    );
  }

  static ExpenseCategory _parseCategory(String category) {
    switch (category) {
      case 'supplies':
        return ExpenseCategory.supplies;
      case 'lab':
        return ExpenseCategory.lab;
      case 'equipment':
        return ExpenseCategory.equipment;
      case 'rent':
        return ExpenseCategory.rent;
      case 'salary':
        return ExpenseCategory.salary;
      default:
        return ExpenseCategory.other;
    }
  }
}
