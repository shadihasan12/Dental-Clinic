import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'expense_models.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key, required this.onSave});

  final ValueChanged<ExpenseEntity> onSave;

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
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
    if (_amountController.text.isEmpty) return;
    widget.onSave(
      ExpenseEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        amount: double.tryParse(_amountController.text) ?? 0,
        date: _date,
        category: _category,
      ),
    );
    Navigator.pop(context);
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
      builder: (ctx) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(ctx),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _date = tempDate);
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      l10n.save,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(ctx),
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
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).viewPadding.bottom;
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

          // Title
          TextField(
            controller: _titleController,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: '${l10n.whatWasThisFor} (${l10n.optional.toLowerCase()})',
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
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            ),
          ),

          SizedBox(height: 14.h),
          // Category + Date row
          Row(
            children: [
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
                      icon: Icon(Icons.expand_more, size: 18.w, color: Colors.grey.shade400),
                      items: ExpenseCategory.values
                          .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(
                                  categoryLabel(context, c),
                                  style: TextStyle(
                                    fontFamily: FontHelper.fontFamily(context),
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _category = v);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14.w, color: Colors.grey.shade500),
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
}
