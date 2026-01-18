import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:intl/intl.dart';

enum PaymentMethod {
  cash('Cash', Icons.payments_outlined),
  creditCard('Credit Card', Icons.credit_card),
  debitCard('Debit Card', Icons.credit_card_outlined),
  insurance('Insurance', Icons.health_and_safety_outlined),
  bankTransfer('Bank Transfer', Icons.account_balance_outlined),
  other('Other', Icons.more_horiz);

  final String label;
  final IconData icon;
  const PaymentMethod(this.label, this.icon);
}

class PaymentRecord {
  final String id;
  final double amount;
  final PaymentMethod method;
  final String? note;
  final DateTime date;

  const PaymentRecord({
    required this.id,
    required this.amount,
    required this.method,
    this.note,
    required this.date,
  });
}

class RecordPaymentPopup extends StatefulWidget {
  final String patientName;
  final String caseTitle;
  final double totalCost;
  final double paidAmount;
  final ValueChanged<PaymentRecord> onSave;

  const RecordPaymentPopup({
    super.key,
    required this.patientName,
    required this.caseTitle,
    required this.totalCost,
    required this.paidAmount,
    required this.onSave,
  });

  static Future<PaymentRecord?> show(
    BuildContext context, {
    required String patientName,
    required String caseTitle,
    required double totalCost,
    required double paidAmount,
    required ValueChanged<PaymentRecord> onSave,
  }) {
    return showModalBottomSheet<PaymentRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecordPaymentPopup(
        patientName: patientName,
        caseTitle: caseTitle,
        totalCost: totalCost,
        paidAmount: paidAmount,
        onSave: onSave,
      ),
    );
  }

  @override
  State<RecordPaymentPopup> createState() => _RecordPaymentPopupState();
}

class _RecordPaymentPopupState extends State<RecordPaymentPopup> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  DateTime _selectedDate = DateTime.now();

  double get _remainingAmount => widget.totalCost - widget.paidAmount;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final payment = PaymentRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: double.parse(_amountController.text),
        method: _selectedMethod,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        date: _selectedDate,
      );
      widget.onSave(payment);
      Navigator.pop(context, payment);
    }
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _setFullAmount() {
    _amountController.text = _remainingAmount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.gray300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: ColorManager.success.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.payments_outlined,
                            color: ColorManager.success,
                            size: 24.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Record Payment',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: FontFamily.geist,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.textPrimary,
                                ),
                              ),
                              Text(
                                widget.caseTitle,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontFamily.geist,
                                  color: ColorManager.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: ColorManager.textSecondary),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Payment summary
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: ColorManager.gray50,
                        borderRadius: BorderRadiusManager.lg,
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow('Patient', widget.patientName),
                          SizedBox(height: 8.h),
                          _buildSummaryRow('Total Cost', '\$${widget.totalCost.toStringAsFixed(2)}'),
                          SizedBox(height: 8.h),
                          _buildSummaryRow('Already Paid', '\$${widget.paidAmount.toStringAsFixed(2)}', valueColor: ColorManager.success),
                          SizedBox(height: 8.h),
                          Divider(color: ColorManager.gray200),
                          SizedBox(height: 8.h),
                          _buildSummaryRow(
                            'Remaining',
                            '\$${_remainingAmount.toStringAsFixed(2)}',
                            valueColor: _remainingAmount > 0 ? ColorManager.warning : ColorManager.success,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Amount field
                    _buildLabel('Amount *'),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              hintText: '0.00',
                              prefixText: '\$ ',
                              hintStyle: TextStyle(
                                color: ColorManager.textTertiary,
                                fontFamily: FontFamily.geist,
                              ),
                              filled: true,
                              fillColor: ColorManager.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadiusManager.lg,
                                borderSide: BorderSide(color: ColorManager.gray200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadiusManager.lg,
                                borderSide: BorderSide(color: ColorManager.gray200),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadiusManager.lg,
                                borderSide: BorderSide(color: ColorManager.primary),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              final amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return 'Please enter a valid amount';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: _setFullAmount,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              color: ColorManager.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadiusManager.lg,
                              border: Border.all(color: ColorManager.primary),
                            ),
                            child: Text(
                              'Full',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: FontFamily.geist,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Payment method
                    _buildLabel('Payment Method'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: PaymentMethod.values.map((method) {
                        final isSelected = _selectedMethod == method;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedMethod = method),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelected ? ColorManager.primary : ColorManager.white,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: isSelected ? ColorManager.primary : ColorManager.gray300,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  method.icon,
                                  size: 16.w,
                                  color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  method.label,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: FontFamily.geist,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 16.h),

                    // Date
                    _buildLabel('Date'),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: _selectDate,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadiusManager.lg,
                          border: Border.all(color: ColorManager.gray200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 20.w, color: ColorManager.textSecondary),
                            SizedBox(width: 8.w),
                            Text(
                              DateFormat('MMM d, yyyy').format(_selectedDate),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: FontFamily.geist,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_drop_down, color: ColorManager.textSecondary),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Note (optional)
                    _buildLabel('Note (Optional)'),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Add a note...',
                        hintStyle: TextStyle(
                          color: ColorManager.textTertiary,
                          fontFamily: FontFamily.geist,
                        ),
                        filled: true,
                        fillColor: ColorManager.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadiusManager.lg,
                          borderSide: BorderSide(color: ColorManager.gray200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusManager.lg,
                          borderSide: BorderSide(color: ColorManager.gray200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusManager.lg,
                          borderSide: BorderSide(color: ColorManager.primary),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Save button
                    PrimaryButton(
                      text: 'Record Payment',
                      onPressed: _handleSave,
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.geist,
        fontWeight: FontWeight.w500,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontFamily.geist,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: valueColor ?? ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}