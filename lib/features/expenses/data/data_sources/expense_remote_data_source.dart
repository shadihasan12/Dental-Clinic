import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/expenses/data/endpoints/expense_endpoints.dart';
import 'package:dental_clinic_app/features/expenses/data/models/expense_model.dart';
import 'package:injectable/injectable.dart';

abstract class ExpenseRemoteDataSource {
  Future<Map<String, dynamic>> getAllExpenses();
  Future<List<ExpenseCategoryModel>> getCategories();
  Future<ExpenseModel> addExpense(Map<String, dynamic> body);
  Future<ExpenseModel> updateExpense(String id, Map<String, dynamic> body);
  Future<void> deleteExpense(String id);
}

@LazySingleton(as: ExpenseRemoteDataSource)
class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ExpenseRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<Map<String, dynamic>> getAllExpenses() async {
    final response = await _apiConsumer.get(ExpenseEndpoints.expenses);

    final dataList = response['data'] as List;
    final expenses = dataList
        .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final meta = response['meta'] as Map<String, dynamic>?;
    final totalsList = (meta?['totals'] as List?) ?? [];
    final totals = totalsList
        .map((e) => ExpenseTotalModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return {
      'expenses': expenses,
      'totals': totals,
    };
  }

  @override
  Future<List<ExpenseCategoryModel>> getCategories() async {
    final response = await _apiConsumer.get(ExpenseEndpoints.categories);

    final dataList = response['data'] as List;
    return dataList
        .map((e) => ExpenseCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ExpenseModel> addExpense(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      ExpenseEndpoints.expenses,
      body: body,
    );
    return ExpenseModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<ExpenseModel> updateExpense(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiConsumer.put(
      ExpenseEndpoints.expenseById(id),
      body: body,
    );
    return ExpenseModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _apiConsumer.delete(ExpenseEndpoints.expenseById(id));
  }
}
