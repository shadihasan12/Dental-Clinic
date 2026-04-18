import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
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

  // ═══════════════════════════════════════════════════════════════════
  // MODALS — Dialog on desktop, bottom sheet on mobile
  // ═══════════════════════════════════════════════════════════════════

  void _showAddExpense(BuildContext context) {
    final blocCtx = context;
    final sheet = AddExpenseSheet(
      onSave: (body) {
        blocCtx.read<ExpenseBloc>().add(ExpenseEvent.addExpense(body));
      },
    );
    _presentSheet(context, sheet);
  }

  void _showExpenseDetails(BuildContext context, ExpenseEntity expense) {
    final blocCtx = context;
    final sheet = ExpenseDetailSheet(
      expense: expense,
      onDelete: () {
        blocCtx.read<ExpenseBloc>().add(
          ExpenseEvent.deleteExpense(expense.id),
        );
      },
      onEdit: () {
        Navigator.pop(context);
        _showEditExpense(blocCtx, expense);
      },
    );
    _presentSheet(context, sheet, maxWidth: 480, maxHeight: 640);
  }

  void _showEditExpense(BuildContext context, ExpenseEntity expense) {
    final blocCtx = context;
    final sheet = AddExpenseSheet(
      expense: expense,
      onSave: (body) {
        blocCtx.read<ExpenseBloc>().add(
          ExpenseEvent.updateExpense(expense.id, body),
        );
      },
    );
    _presentSheet(context, sheet);
  }

  void _presentSheet(
    BuildContext context,
    Widget sheet, {
    double maxWidth = 560,
    double maxHeight = 720,
  }) {
    final c = ColorManager.of(context);
    if (Responsive.isDesktop(context)) {
      showDialog(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        builder: (_) => Dialog(
          backgroundColor: c.cardBg,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            child: sheet,
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        builder: (_) => sheet,
      );
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

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
            if (isDesktop) return _buildDesktop(context, state);
            return _buildMobile(context, state);
          },
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildMobile(BuildContext context, ExpenseState state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => Column(
        children: [
          _buildMobileHeader(context, [], 0),
          _buildMobileMonthSelector(context),
          Divider(height: 1, color: ColorManager.of(context).divider),
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      loaded: (expenses, totals, _) {
        return Column(
          children: [
            _buildMobileHeader(context, totals, expenses.length),
            _buildMobileMonthSelector(context),
            Divider(height: 1, color: ColorManager.of(context).divider),
            Expanded(
              child: expenses.isEmpty
                  ? _buildMobileEmptyState(context)
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          _buildMobileHeader(context, [], 0),
          _buildMobileMonthSelector(context),
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
  }

  Widget _buildMobileMonthSelector(BuildContext context) {
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

  Widget _buildMobileHeader(
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
                          fontSize: 22.sp,
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

  Widget _buildMobileEmptyState(BuildContext context) {
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

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDesktop(BuildContext context, ExpenseState state) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);

    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => _desktopScaffold(
        context,
        totals: const [],
        count: 0,
        fontFamily: fontFamily,
        content: _desktopLoadingCard(context),
      ),
      loaded: (expenses, totals, _) => _desktopScaffold(
        context,
        totals: totals,
        count: expenses.length,
        fontFamily: fontFamily,
        content: expenses.isEmpty
            ? _desktopEmptyCard(context, l10n, fontFamily)
            : _desktopExpensesTable(context, expenses, fontFamily),
      ),
      error: (message) => _desktopScaffold(
        context,
        totals: const [],
        count: 0,
        fontFamily: fontFamily,
        content: Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.borderLight),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: 40, color: c.textTertiary),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    color: c.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopScaffold(
    BuildContext context, {
    required List<ExpenseTotalEntity> totals,
    required int count,
    required String fontFamily,
    required Widget content,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.expenses,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 26,
                        fontWeight: FontWeightManager.bold,
                        color: c.textPrimary,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$count ${l10n.transactions}',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              _DesktopMonthSelector(
                label: _monthLabel(context),
                isCurrentMonth: _isCurrentMonth,
                onPrev: _goToPreviousMonth,
                onNext: _isCurrentMonth ? null : _goToNextMonth,
                fontFamily: fontFamily,
              ),
              const SizedBox(width: 12),
              _DesktopNewExpenseButton(
                label: l10n.addExpense,
                onTap: () => _showAddExpense(context),
                fontFamily: fontFamily,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Summary cards: transactions count + per-currency totals
          _DesktopSummaryRow(
            count: count,
            totals: totals,
            fontFamily: fontFamily,
            transactionsLabel: l10n.transactions,
          ),

          const SizedBox(height: 20),

          // ── Main content card ───────────────────────────────
          content,
        ],
      ),
    );
  }

  Widget _desktopLoadingCard(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }

  Widget _desktopEmptyCard(
    BuildContext context,
    AppLocalizations l10n,
    String fontFamily,
  ) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 30,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noExpensesThisMonth,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _monthLabel(context),
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textTertiary,
            ),
          ),
          const SizedBox(height: 20),
          _DesktopNewExpenseButton(
            label: l10n.addExpense,
            onTap: () => _showAddExpense(context),
            fontFamily: fontFamily,
          ),
        ],
      ),
    );
  }

  Widget _desktopExpensesTable(
    BuildContext context,
    List<ExpenseEntity> expenses,
    String fontFamily,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Column headers
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              border: Border(
                bottom: BorderSide(color: c.borderLight),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _tableHeader(l10n.expenseType, fontFamily, c),
                ),
                Expanded(
                  flex: 4,
                  child: _tableHeader(l10n.notes, fontFamily, c),
                ),
                Expanded(
                  flex: 2,
                  child: _tableHeader(l10n.date, fontFamily, c),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: _tableHeader(l10n.amount, fontFamily, c),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          // Rows
          ...List.generate(expenses.length, (i) {
            return _DesktopExpenseRow(
              expense: expenses[i],
              isLast: i == expenses.length - 1,
              fontFamily: fontFamily,
              onTap: () => _showExpenseDetails(context, expenses[i]),
            );
          }),
        ],
      ),
    );
  }

  Widget _tableHeader(String label, String fontFamily, AppColors c) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeightManager.semiBold,
        color: c.textTertiary,
        letterSpacing: 0.4,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP WIDGETS
// ═══════════════════════════════════════════════════════════════════════

class _DesktopMonthSelector extends StatelessWidget {
  const _DesktopMonthSelector({
    required this.label,
    required this.isCurrentMonth,
    required this.onPrev,
    required this.onNext,
    required this.fontFamily,
  });

  final String label;
  final bool isCurrentMonth;
  final VoidCallback onPrev;
  final VoidCallback? onNext;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _arrowButton(Icons.chevron_left, onPrev, c),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                fontWeight: FontWeightManager.semiBold,
                color: c.textPrimary,
              ),
            ),
          ),
          _arrowButton(Icons.chevron_right, onNext, c),
        ],
      ),
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback? onTap, AppColors c) {
    final enabled = onTap != null;
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 20,
            color: enabled ? ColorManager.primary : c.textSubtle,
          ),
        ),
      ),
    );
  }
}

class _DesktopNewExpenseButton extends StatelessWidget {
  const _DesktopNewExpenseButton({
    required this.label,
    required this.onTap,
    required this.fontFamily,
  });

  final String label;
  final VoidCallback onTap;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeightManager.semiBold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopSummaryRow extends StatelessWidget {
  const _DesktopSummaryRow({
    required this.count,
    required this.totals,
    required this.fontFamily,
    required this.transactionsLabel,
  });

  final int count;
  final List<ExpenseTotalEntity> totals;
  final String fontFamily;
  final String transactionsLabel;

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      _SummaryCard(
        icon: Icons.receipt_long_outlined,
        accentColor: ColorManager.primary,
        label: transactionsLabel,
        value: count.toString(),
        fontFamily: fontFamily,
      ),
      ...totals.map(
        (t) => _SummaryCard(
          icon: Icons.payments_outlined,
          accentColor: _accentForCurrency(t.currencyCode),
          label: t.currencyName.isNotEmpty ? t.currencyName : t.currencyCode,
          value: t.total,
          suffix: t.currencyCode,
          fontFamily: fontFamily,
        ),
      ),
    ];

    // Render in a row with equal spacing; wrap if overflows
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: cards.map((card) {
            final itemWidth = _itemWidth(constraints.maxWidth, cards.length);
            return SizedBox(width: itemWidth, child: card);
          }).toList(),
        );
      },
    );
  }

  double _itemWidth(double maxWidth, int n) {
    // Aim for up to 4 per row (min width 210)
    const gap = 14.0;
    const minWidth = 210.0;
    final perRow = ((maxWidth + gap) / (minWidth + gap)).floor().clamp(1, n);
    return (maxWidth - gap * (perRow - 1)) / perRow;
  }

  Color _accentForCurrency(String code) {
    switch (code.toUpperCase()) {
      case 'USD':
        return const Color(0xFF16A34A);
      case 'EUR':
        return const Color(0xFF2563EB);
      case 'SYP':
        return const Color(0xFFEA580C);
      case 'GBP':
        return const Color(0xFF9333EA);
      default:
        return ColorManager.primary;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.accentColor,
    required this.label,
    required this.value,
    this.suffix,
    required this.fontFamily,
  });

  final IconData icon;
  final Color accentColor;
  final String label;
  final String value;
  final String? suffix;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 18),
              ),
              const Spacer(),
              if (suffix != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    suffix!,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeightManager.semiBold,
                      color: accentColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 22,
              fontWeight: FontWeightManager.bold,
              color: c.textPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopExpenseRow extends StatefulWidget {
  const _DesktopExpenseRow({
    required this.expense,
    required this.isLast,
    required this.fontFamily,
    required this.onTap,
  });

  final ExpenseEntity expense;
  final bool isLast;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_DesktopExpenseRow> createState() => _DesktopExpenseRowState();
}

class _DesktopExpenseRowState extends State<_DesktopExpenseRow> {
  bool _hovered = false;

  String _formatDate(String raw) {
    final d = DateTime.tryParse(raw);
    if (d == null) return raw;
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(d);
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final e = widget.expense;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorManager.primary.withValues(alpha: 0.04)
                : Colors.transparent,
            border: widget.isLast
                ? null
                : Border(bottom: BorderSide(color: c.borderLight)),
          ),
          child: Row(
            children: [
              // Category
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.receipt_outlined,
                        size: 18,
                        color: ColorManager.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e.category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: widget.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeightManager.semiBold,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Note
              Expanded(
                flex: 4,
                child: Text(
                  e.notes.isEmpty ? '—' : e.notes,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: 13,
                    color: e.notes.isEmpty ? c.textSubtle : c.textSecondary,
                  ),
                ),
              ),

              // Date
              Expanded(
                flex: 2,
                child: Text(
                  _formatDate(e.entryDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: 13,
                    color: c.textSecondary,
                  ),
                ),
              ),

              // Amount + currency pill
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        e.amount,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: widget.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeightManager.semiBold,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        e.currency.currencyCode,
                        style: TextStyle(
                          fontFamily: widget.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron
              SizedBox(
                width: 40,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: _hovered ? ColorManager.primary : c.textSubtle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
