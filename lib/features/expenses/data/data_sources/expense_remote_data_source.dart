import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/expenses/data/models/expense_model.dart';
import 'package:injectable/injectable.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseModel>> getAllExpenses();
  Future<ExpenseModel> addExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
}

@Injectable(as: ExpenseRemoteDataSource)
class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  ExpenseRemoteDataSourceImpl(this._apiConsumer);

  // In-memory mock store
  List<ExpenseModel>? _cachedExpenses;

  List<ExpenseModel> _getMockExpenses() {
    if (_cachedExpenses != null) return _cachedExpenses!;

    final now = DateTime.now();
    _cachedExpenses = [
      ExpenseModel(
        id: '1',
        title: 'صيانة كرسي العيادة',
        amount: 450,
        date: now.subtract(const Duration(days: 1)).toIso8601String(),
        category: 'supplies',
      ),
      ExpenseModel(
        id: '2',
        title: 'رسوم مختبر',
        amount: 320,
        date: now.subtract(const Duration(days: 3)).toIso8601String(),
        category: 'lab',
      ),
      ExpenseModel(
        id: '3',
        title: 'إيجار مكتب',
        amount: 2500,
        date: now.subtract(const Duration(days: 5)).toIso8601String(),
        category: 'rent',
      ),
      ExpenseModel(
        id: '4',
        title: 'رواتب المساعد',
        amount: 1800,
        date: now.subtract(const Duration(days: 10)).toIso8601String(),
        category: 'salary',
      ),
    ];
    return _cachedExpenses!;
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(ExpenseEndpoints.expenses);
    // return (response as List)
    //     .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockExpenses();
  }

  @override
  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.post(
    //   ExpenseEndpoints.expenses,
    //   body: expense.toJson(),
    // );
    // return ExpenseModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 500));
    final newExpense = ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
      category: expense.category,
    );
    _getMockExpenses().insert(0, newExpense);
    return newExpense;
  }

  @override
  Future<void> deleteExpense(String id) async {
    // TODO: Replace with real API call when backend is ready
    // await _apiConsumer.delete(ExpenseEndpoints.deleteExpense(id));

    await Future.delayed(const Duration(milliseconds: 300));
    _getMockExpenses().removeWhere((e) => e.id == id);
  }
}
