class ExpenseEndpoints {
  ExpenseEndpoints._();

  static const String expenses = '/clinics/expenses';
  static const String categories = '/clinics/expenses/categories';
  static String expenseById(String id) => '/clinics/expenses/$id';
}
