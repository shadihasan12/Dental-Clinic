import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/presentation/manager/expense_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/add_expense_sheet.dart';
import '../widgets/expense_detail_sheet.dart';
import '../widgets/expense_row.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  /// Bump this notifier to open the "add expense" sheet on the active
  /// expenses page (e.g. from the home screen's quick action).
  static final ValueNotifier<int> openAddExpenseRequest = ValueNotifier<int>(0);

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

  /// Pull-to-refresh: the same query [_loadMonth] runs, held open until the
  /// bloc leaves its loading state so the band tracks the request itself.
  Future<void> _refresh() async {
    final bloc = context.read<ExpenseBloc>();
    _loadMonth();
    await bloc.stream.settled(
      (state) => state.maybeWhen(loading: () => false, orElse: () => true),
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

  String _monthLabel(BuildContext context) =>
      AppDate.monthYear(context, _currentMonth);

  Future<void> _showAddExpense(BuildContext context) async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
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
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
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
      backgroundColor: Colors.transparent,
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
                AppSnackbar.showError(context, title: actionError);
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
                      child: DentaRefresh(
                        onRefresh: _refresh,
                        child: expenses.isEmpty
                            ? _buildEmptyState(context)
                            : ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  14.w,
                                  8.h,
                                  14.w,
                                  24.h,
                                ),
                                itemCount: expenses.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: 8.h),
                                itemBuilder: (_, index) => ExpenseRow(
                                  expense: expenses[index],
                                  onTap: () => _showExpenseDetails(
                                    context,
                                    expenses[index],
                                  ),
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
                    child: DentaRefresh(
                      onRefresh: _refresh,
                      child: _buildErrorState(context, message),
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
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
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.expenses,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      color: ColorManager.primaryDarker,
                    ),
                  ),
                ),
                const Spacer(),
                _NewExpenseButton(
                  label: l10n.newButton,
                  onTap: () => _showAddExpense(context),
                ),
              ],
            ),

            // Multi-currency totals. Micro-label over the figure, the same
            // number tile the patient screen uses - the old 18sp bold pair
            // took a third of the header for a value that is context, not
            // the reason the screen was opened.
            if (totals.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Row(
                children: totals.asMap().entries.map((entry) {
                  final t = entry.value;
                  final isLast = entry.key == totals.length - 1;
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                        horizontal: 10.w,
                      ),
                      margin: EdgeInsetsDirectional.only(end: isLast ? 0 : 8.w),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.currencyCode.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 9.5.sp,
                              height: 1.3,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primaryDarker,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            t.total,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 15.sp,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                              color: c.textPrimary,
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
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: ColorManager.of(context).divider),
      itemBuilder: (_, _) => const _ExpenseRowSkeleton(),
    );
  }

  /// Same shell as the patients and appointments screens: quiet grey disc,
  /// one sentence, and the action that fills the list.
  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      child: StateCard(
        icon: Icons.receipt_long_outlined,
        title: l10n.noExpensesThisMonth,
        message: l10n.noExpensesThisMonthHint,
        actionLabel: '+ ${l10n.addExpense}',
        onAction: () => _showAddExpense(context),
      ),
    );
  }

  /// Says what failed, that the records themselves are untouched, and offers
  /// the reload - the month it retries is the one still on screen.
  Widget _buildErrorState(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      child: StateCard(
        icon: Icons.cloud_off_rounded,
        tone: ColorManager.error,
        title: l10n.expensesLoadFailed,
        message: message,
        detail: l10n.expensesUnchangedHint,
        actionLabel: l10n.retry,
        onAction: _loadMonth,
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

/// Rectangular primary button, the same one the patients and appointments
/// headers use. A round `+` gave the action no name; the word carries it.
class _NewExpenseButton extends StatelessWidget {
  const _NewExpenseButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(11.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 16.w, color: ColorManager.white),
              SizedBox(width: 5.w),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
