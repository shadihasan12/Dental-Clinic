class ExpenseEndpoints {
  ExpenseEndpoints._();

  static const String expenses = '/expenses';
  static String deleteExpense(String id) => '/expenses/$id';
}
