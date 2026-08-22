import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/presentation/manager/expense_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../widgets/add_expense_sheet.dart';
import '../widgets/expense_detail_sheet.dart';
import '../widgets/expense_row.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  /// Bump this notifier to open the "add expense" sheet on the active
  /// expenses page (e.g. from the home screen's quick action).
  static final ValueNotifier<int> openAddExpenseRequest =
      ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExpenseBloc>(),
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
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _loadMonth();
    ExpensesPage.openAddExpenseRequest.addListener(_onExternalAddRequest);
  }

  @override
  void dispose() {
    ExpensesPage.openAddExpenseRequest.removeListener(_onExternalAddRequest);
    super.dispose();
  }

  void _onExternalAddRequest() {
    if (!mounted) return;
    _showAddExpense(context);
  }

  Map<String, dynamic> _buildDateFilter() {
    final start =
        '${_currentMonth.year}-${_currentMonth.month.toString().padLeft(2, '0')}-01';
    final lastDay = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    final end =
        '${_currentMonth.year}-${_currentMonth.month.toString().padLeft(2, '0')}-${lastDay.toString().padLeft(2, '0')}';
    return {'filters[entry_date][between]': '$start,$end'};
  }

  void _loadMonth() {
    context.read<ExpenseBloc>().add(
      ExpenseEvent.loadExpenses(queryParameters: _buildDateFilter()),
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    _loadMonth();
  }

  void _goToNextMonth() {
    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month);
    if (!_currentMonth.isBefore(currentMonthStart)) return;
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    _loadMonth();
  }

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _currentMonth.year == now.year && _currentMonth.month == now.month;
  }

  String _monthLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMM(locale).format(_currentMonth);
  }

  Future<void> _showAddExpense(BuildContext context) async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => AddExpenseSheet(
        onSave: (body) {
          context.read<ExpenseBloc>().add(ExpenseEvent.addExpense(body));
        },
      ),
    );
  }

  void _showExpenseDetails(BuildContext context, ExpenseEntity expense) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => ExpenseDetailSheet(
        expense: expense,
        onDelete: () {
          context.read<ExpenseBloc>().add(
            ExpenseEvent.deleteExpense(expense.id),
          );
        },
        onEdit: () {
          Navigator.pop(context);
          _showEditExpense(context, expense);
        },
      ),
    );
  }

  void _showEditExpense(BuildContext context, ExpenseEntity expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => AddExpenseSheet(
        expense: expense,
        onSave: (body) {
          context.read<ExpenseBloc>().add(
            ExpenseEvent.updateExpense(expense.id, body),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocListener<ExpenseBloc, ExpenseState>(
        listenWhen: (prev, curr) {
          String? prevError;
          String? currError;
          prev.whenOrNull(loaded: (_, _, e) => prevError = e);
          curr.whenOrNull(loaded: (_, _, e) => currError = e);
          return currError != null && currError != prevError;
        },
        listener: (context, state) {
          state.whenOrNull(
            loaded: (_, _, actionError) {
              if (actionError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      actionError,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                    backgroundColor: Colors.red.shade400,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          );
        },
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => Column(
                children: [
                  _buildHeader(context, [], 0),
                  _buildMonthSelector(context),
                  Divider(height: 1, color: ColorManager.of(context).divider),
                  Expanded(child: _buildSkeletonList(context)),
                ],
              ),
              loaded: (expenses, totals, _) {
                return Column(
                  children: [
                    _buildHeader(context, totals, expenses.length),
                    _buildMonthSelector(context),
                    Divider(height: 1, color: ColorManager.of(context).divider),
                    Expanded(
                      child: expenses.isEmpty
                          ? _buildEmptyState(context)
                          : ListView.separated(
                              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                              itemCount: expenses.length,
                              separatorBuilder: (_, _) => Divider(
                                height: 1,
                                color: ColorManager.of(context).divider,
                              ),
                              itemBuilder: (_, index) => ExpenseRow(
                                expense: expenses[index],
                                onTap: () => _showExpenseDetails(
                                  context,
                                  expenses[index],
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
              error: (message) => Column(
                children: [
                  _buildHeader(context, [], 0),
                  _buildMonthSelector(context),
                  Divider(height: 1, color: ColorManager.of(context).divider),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.w,
                            color: ColorManager.of(context).textTertiary,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(context),
                              fontSize: 14.sp,
                              color: ColorManager.of(context).textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMonthSelector(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _goToPreviousMonth,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 20.w,
                color: ColorManager.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _monthLabel(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          GestureDetector(
            onTap: _isCurrentMonth ? null : _goToNextMonth,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: _isCurrentMonth
                    ? ColorManager.of(context).divider
                    : ColorManager.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.chevron_right,
                size: 20.w,
                color: _isCurrentMonth
                    ? ColorManager.of(context).textSubtle
                    : ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    List<ExpenseTotalEntity> totals,
    int count,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.expenses,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '$count ${l10n.transactions}',
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 13.sp,
                          color: ColorManager.of(context).textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showAddExpense(context),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: ColorManager.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20.w),
                  ),
                ),
              ],
            ),

            // Multi-currency totals
            if (totals.isNotEmpty) ...[
              SizedBox(height: 14.h),
              Row(
                children: totals.asMap().entries.map((entry) {
                  final t = entry.value;
                  final isLast = entry.key == totals.length - 1;
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 12.w,
                      ),
                      margin: EdgeInsetsDirectional.only(end: isLast ? 0 : 8.w),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.currencyCode,
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(context),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            t.total,
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(context),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.of(context).textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: ColorManager.of(context).divider),
      itemBuilder: (_, _) => const _ExpenseRowSkeleton(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.w,
            color: ColorManager.of(context).border,
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.noExpensesThisMonth,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: ColorManager.of(context).textTertiary,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => _showAddExpense(context),
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

class _ExpenseRowSkeleton extends StatelessWidget {
  const _ExpenseRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          ShimmerBox(
            width: 36.w,
            height: 36.w,
            radius: BorderRadius.circular(10.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(
                  width: 120.w,
                  height: 12.h,
                  radius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 8.h),
                ShimmerBox(
                  width: 80.w,
                  height: 10.h,
                  radius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerBox(
                width: 70.w,
                height: 12.h,
                radius: BorderRadius.circular(4.r),
              ),
              SizedBox(height: 8.h),
              ShimmerBox(
                width: 50.w,
                height: 10.h,
                radius: BorderRadius.circular(4.r),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
