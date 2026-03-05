import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/presentation/manager/expense_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/add_expense_sheet.dart';
import '../widgets/expense_detail_sheet.dart';
import '../widgets/expense_row.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExpenseBloc>()
        ..add(const ExpenseEvent.loadExpenses()),
      child: const _ExpensesContent(),
    );
  }
}

class _ExpensesContent extends StatelessWidget {
  const _ExpensesContent();

  void _showAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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

  void _showExpenseDetails(
    BuildContext context,
    ExpenseEntity expense,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => ExpenseDetailSheet(
        expense: expense,
        onDelete: () {
          context
              .read<ExpenseBloc>()
              .add(ExpenseEvent.deleteExpense(expense.id));
        },
        onEdit: () {
          Navigator.pop(context); // close detail sheet
          _showEditExpense(context, expense);
        },
      ),
    );
  }

  void _showEditExpense(
    BuildContext context,
    ExpenseEntity expense,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => AddExpenseSheet(
        expense: expense,
        onSave: (body) {
          context
              .read<ExpenseBloc>()
              .add(ExpenseEvent.updateExpense(expense.id, body));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Divider(height: 1, color: Colors.grey.shade200),
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
              loaded: (expenses, totals, _) {
                return Column(
                children: [
                  _buildHeader(context, totals, expenses.length),
                  Divider(height: 1, color: Colors.grey.shade200),
                  Expanded(
                    child: expenses.isEmpty
                        ? _buildEmptyState(context)
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: expenses.length,
                            separatorBuilder: (_, _) =>
                                Divider(height: 1, color: Colors.grey.shade100),
                            itemBuilder: (_, index) => ExpenseRow(
                              expense: expenses[index],
                              onTap: () => _showExpenseDetails(
                                  context, expenses[index]),
                            ),
                          ),
                  ),
                ],
              );
            },
            error: (message) => Column(
              children: [
                _buildHeader(context, [], 0),
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
                          vertical: 10.h, horizontal: 12.w),
                      margin: EdgeInsetsDirectional.only(
                        end: isLast ? 0 : 8.w,
                      ),
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
                              color: const Color(0xFF2D2D2D),
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

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 48.w, color: Colors.grey.shade300),
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
