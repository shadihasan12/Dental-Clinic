import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:intl/intl.dart';

class ExpenseData {
  final String id;
  final String title;
  final String? note;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  const ExpenseData({
    required this.id,
    required this.title,
    this.note,
    required this.amount,
    required this.date,
    required this.category,
  });
}

enum ExpenseCategory { supplies, lab, equipment, rent, salary, other }

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  final List<ExpenseData> _allExpenses = [
    ExpenseData(
      id: '1',
      title: 'Dental Supplies',
      note: 'Gloves, masks, sterilization materials',
      amount: 450,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: ExpenseCategory.supplies,
    ),
    ExpenseData(
      id: '2',
      title: 'Lab Fees - Crown',
      note: 'Patient: Sarah Johnson',
      amount: 320,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: ExpenseCategory.lab,
    ),
    ExpenseData(
      id: '3',
      title: 'Office Rent',
      amount: 2500,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: ExpenseCategory.rent,
    ),
    ExpenseData(
      id: '4',
      title: 'X-Ray Film',
      note: 'Monthly stock',
      amount: 180,
      date: DateTime.now().subtract(const Duration(days: 8)),
      category: ExpenseCategory.supplies,
    ),
    ExpenseData(
      id: '5',
      title: 'Assistant Salary',
      amount: 1800,
      date: DateTime.now().subtract(const Duration(days: 10)),
      category: ExpenseCategory.salary,
    ),
  ];

  List<ExpenseData> get _filteredExpenses =>
      _allExpenses
          .where(
            (e) =>
                e.date.year == _selectedMonth.year &&
                e.date.month == _selectedMonth.month,
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  double get _monthTotal =>
      _filteredExpenses.fold(0, (sum, e) => sum + e.amount);

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _nextMonth() {
    final now = DateTime.now();
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    if (next.isBefore(DateTime(now.year, now.month + 1))) {
      setState(() => _selectedMonth = next);
    }
  }

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }

  void _showAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => _AddExpenseSheet(
        onSave: (expense) {
          setState(() => _allExpenses.add(expense));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showExpenseDetails(ExpenseData expense) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => _ExpenseDetailSheet(
        expense: expense,
        onDelete: () {
          setState(() => _allExpenses.removeWhere((e) => e.id == expense.id));
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // — Header
          _buildHeader(context),
          Divider(height: 1, color: Colors.grey.shade200),

          // — Month selector + total
          _buildMonthSelector(context),

          Divider(height: 1, color: Colors.grey.shade100),

          // — Expenses list
          Expanded(
            child: _filteredExpenses.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _filteredExpenses.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: Colors.grey.shade100),
                    itemBuilder: (context, index) {
                      return _ExpenseRow(
                        expense: _filteredExpenses[index],
                        onTap: () =>
                            _showExpenseDetails(_filteredExpenses[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ─── Header ─────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.expenses,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${_filteredExpenses.length} ${l10n.transactions}',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _showAddExpense,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20.w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Month Selector ─────────────────────────────────────────────────────

  Widget _buildMonthSelector(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy').format(_selectedMonth);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        children: [
          // Month nav
          GestureDetector(
            onTap: _previousMonth,
            child: Icon(Icons.chevron_left, size: 22.w, color: Colors.black54),
          ),
          SizedBox(width: 8.w),
          Text(
            monthLabel,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _isCurrentMonth ? null : _nextMonth,
            child: Icon(
              Icons.chevron_right,
              size: 22.w,
              color: _isCurrentMonth ? Colors.grey.shade300 : Colors.black54,
            ),
          ),

          const Spacer(),

          // Total
          Text(
            '\$${_monthTotal.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ────────────────────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.w,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.noExpensesThisMonth,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: Colors.black38,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: _showAddExpense,
            child: Text(
              l10n.addOne,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Expense Row ──────────────────────────────────────────────────────────────

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({required this.expense, required this.onTap});

  final ExpenseData expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            // Category icon
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _categoryColor(expense.category).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _categoryIcon(expense.category),
                size: 18.w,
                color: _categoryColor(expense.category),
              ),
            ),
            SizedBox(width: 12.w),

            // Title + date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    DateFormat('MMM d').format(expense.date),
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              '\$${expense.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D2D2D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(ExpenseCategory category) {
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

  Color _categoryColor(ExpenseCategory category) {
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
}

// ─── Add Expense Bottom Sheet ─────────────────────────────────────────────────

class _AddExpenseSheet extends StatefulWidget {
  const _AddExpenseSheet({required this.onSave});

  final ValueChanged<ExpenseData> onSave;

  @override
  State<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<_AddExpenseSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _date = DateTime.now();
  ExpenseCategory _category = ExpenseCategory.supplies;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    widget.onSave(
      ExpenseData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        amount: double.tryParse(_amountController.text) ?? 0,
        date: _date,
        category: _category,
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime tempDate = _date;
    final l10n = AppLocalizations.of(context)!;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _date = tempDate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      l10n.done,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _date,
                minimumDate: DateTime(2020),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final formatted = DateFormat('MMM d, yyyy').format(_date);
    final isToday = DateUtils.isSameDay(_date, DateTime.now());

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            l10n.addExpense,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 20.h),

          // Amount
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade300,
              ),
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D2D2D),
              ),
              border: InputBorder.none,
            ),
          ),

          SizedBox(height: 16.h),

          // Title field
          TextField(
            controller: _titleController,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: l10n.whatWasThisFor,
              hintStyle: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Note field
          TextField(
            controller: _noteController,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: l10n.addNoteOptional,
              hintStyle: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // Category + Date row
          Row(
            children: [
              // Category dropdown
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ExpenseCategory>(
                      value: _category,
                      isExpanded: true,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                      icon: Icon(
                        Icons.expand_more,
                        size: 18.w,
                        color: Colors.grey.shade400,
                      ),
                      items: ExpenseCategory.values.map((c) {
                        return DropdownMenuItem(
                          value: c,
                          child: Text(
                            _categoryLabel(context, c),
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(context),
                              fontSize: 13.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _category = v);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              // Date
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.w,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        isToday ? l10n.today : formatted,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                l10n.save,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  String _categoryLabel(BuildContext context, ExpenseCategory category) {
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
}

// ─── Expense Detail Bottom Sheet ──────────────────────────────────────────────

class _ExpenseDetailSheet extends StatelessWidget {
  const _ExpenseDetailSheet({required this.expense, required this.onDelete});

  final ExpenseData expense;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formatted = DateFormat('EEEE, MMM d, yyyy').format(expense.date);

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Amount
          Text(
            '\$${expense.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            expense.title,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 20.h),

          // Details
          _detailRow(context, Icons.calendar_today_outlined, formatted),
          SizedBox(height: 12.h),
          _detailRow(
            context,
            Icons.category_outlined,
            _categoryLabel(context, expense.category),
          ),
          if (expense.note != null) ...[
            SizedBox(height: 12.h),
            _detailRow(context, Icons.notes_outlined, expense.note!),
          ],

          SizedBox(height: 24.h),

          // Delete button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text(
                        l10n.deleteExpenseTitle,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(ctx),
                        ),
                      ),
                      content: Text(
                        l10n.deleteExpenseConfirmation,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(ctx),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(
                            l10n.cancel,
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(ctx),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            onDelete();
                          },
                          child: Text(
                            l10n.delete,
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(ctx),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                l10n.deleteExpenseButton,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: Colors.grey.shade500),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  String _categoryLabel(BuildContext context, ExpenseCategory category) {
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
}
