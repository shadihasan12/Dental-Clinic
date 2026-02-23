import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/presentation/manager/expense_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../widgets/add_expense_sheet.dart';
import '../widgets/expense_detail_sheet.dart';
import '../widgets/expense_row.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExpenseBloc>()..add(const ExpenseEvent.loadExpenses()),
      child: const _ExpensesContent(),
    );
  }
}

class _ExpensesContent extends StatefulWidget {
  const _ExpensesContent();

  @override
  State<_ExpensesContent> createState() => _ExpensesContentState();
}

class _ExpensesContentState extends State<_ExpensesContent> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }

  void _previousMonth() => setState(() {
        _selectedMonth =
            DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      });

  void _nextMonth() {
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    final now = DateTime.now();
    if (next.isBefore(DateTime(now.year, now.month + 1))) {
      setState(() => _selectedMonth = next);
    }
  }

  List<ExpenseEntity> _filterByMonth(List<ExpenseEntity> expenses) {
    return expenses
        .where((e) =>
            e.date.year == _selectedMonth.year &&
            e.date.month == _selectedMonth.month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  void _showAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => AddExpenseSheet(
        onSave: (expense) {
          context.read<ExpenseBloc>().add(ExpenseEvent.addExpense(expense));
        },
      ),
    );
  }

  void _showExpenseDetails(ExpenseEntity expense) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => ExpenseDetailSheet(
        expense: expense,
        onDelete: () {
          context.read<ExpenseBloc>().add(ExpenseEvent.deleteExpense(expense.id));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => Column(
              children: [
                _buildHeader(context, 0),
                Divider(height: 1, color: Colors.grey.shade200),
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
            loaded: (expenses) {
              final filtered = _filterByMonth(expenses);
              return Column(
                children: [
                  _buildHeader(context, filtered.length),
                  Divider(height: 1, color: Colors.grey.shade200),
                  _buildMonthSelector(context, filtered),
                  Divider(height: 1, color: Colors.grey.shade100),
                  Expanded(
                    child: filtered.isEmpty
                        ? _buildEmptyState(context)
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: filtered.length,
                            separatorBuilder: (context, i) =>
                                Divider(height: 1, color: Colors.grey.shade100),
                            itemBuilder: (_, index) => ExpenseRow(
                              expense: filtered[index],
                              onTap: () => _showExpenseDetails(filtered[index]),
                            ),
                          ),
                  ),
                ],
              );
            },
            error: (message) => Column(
              children: [
                _buildHeader(context, 0),
                Divider(height: 1, color: Colors.grey.shade200),
                Expanded(
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 14.sp,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
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
                    '$count ${l10n.transactions}',
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

  Widget _buildMonthSelector(BuildContext context, List<ExpenseEntity> filtered) {
    final monthLabel = DateFormat('MMMM yyyy').format(_selectedMonth);
    final monthTotal = filtered.fold<double>(0, (sum, e) => sum + e.amount);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        children: [
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
              color:
                  _isCurrentMonth ? Colors.grey.shade300 : Colors.black54,
            ),
          ),
          const Spacer(),
          Text(
            '\$${monthTotal.toStringAsFixed(0)}',
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

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 48.w, color: Colors.grey.shade300),
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
