import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:go_router/go_router.dart';

class RecordPaymentPopup extends StatefulWidget {
  final String patientName;
  final String caseTitle;
  final double totalCost;
  final double paidAmount;
  final String? caseCurrencyId;
  final String? caseCurrencyCode;
  final Future<void> Function(
    double amount,
    String currencyId,
    String caseCurrencyId,
    double amountInCaseCurrency,
    double exchangeRate,
    String? notes,
  )
  onSave;

  const RecordPaymentPopup({
    super.key,
    required this.patientName,
    required this.caseTitle,
    required this.totalCost,
    required this.paidAmount,
    this.caseCurrencyId,
    this.caseCurrencyCode,
    required this.onSave,
  });

  static Future<void> show(
    BuildContext context, {
    required String patientName,
    required String caseTitle,
    required double totalCost,
    required double paidAmount,
    String? caseCurrencyId,
    String? caseCurrencyCode,
    required Future<void> Function(
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )
    onSave,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecordPaymentPopup(
        patientName: patientName,
        caseTitle: caseTitle,
        totalCost: totalCost,
        paidAmount: paidAmount,
        caseCurrencyId: caseCurrencyId,
        caseCurrencyCode: caseCurrencyCode,
        onSave: onSave,
      ),
    );
  }

  @override
  State<RecordPaymentPopup> createState() => _RecordPaymentPopupState();
}

class _RecordPaymentPopupState extends State<RecordPaymentPopup> {
  final _amountController = TextEditingController();
  final _exchangeRateController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final CurrencyBloc _currencyBloc;
  CurrencyEntity? _selectedCurrency;
  bool _isSubmitting = false;

  /// When false: 1 [caseCurrency] = X [selectedCurrency]
  /// When true:  1 [selectedCurrency] = X [caseCurrency]
  bool _isExchangeSwapped = false;

  double get _remainingAmount => widget.totalCost - widget.paidAmount;

  bool get _isCurrencyChanged =>
      _selectedCurrency != null &&
      widget.caseCurrencyId != null &&
      _selectedCurrency!.id != widget.caseCurrencyId;

  @override
  void initState() {
    super.initState();
    _currencyBloc = getIt<CurrencyBloc>()..add(const CurrencyEvent.load());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _exchangeRateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _setFullAmount() {
    final remaining = _remainingAmount;
    if (!_isCurrencyChanged) {
      _amountController.text = remaining.toStringAsFixed(2);
      return;
    }
    final rate = double.tryParse(_exchangeRateController.text);
    if (rate == null || rate <= 0) {
      _amountController.text = remaining.toStringAsFixed(2);
      return;
    }
    // Reverse of the save conversion:
    //   Not swapped: 1 caseCurrency = X selectedCurrency → multiply
    //   Swapped:     1 selectedCurrency = X caseCurrency → divide
    final converted = _isExchangeSwapped ? remaining / rate : remaining * rate;
    _amountController.text = converted.toStringAsFixed(2);
  }

  void _initCurrencySelection(List<CurrencyEntity> currencies) {
    if (_selectedCurrency != null) return;
    if (widget.caseCurrencyId != null) {
      _selectedCurrency = currencies.cast<CurrencyEntity?>().firstWhere(
        (c) => c!.id == widget.caseCurrencyId,
        orElse: () => currencies.isNotEmpty ? currencies.first : null,
      );
    } else if (currencies.isNotEmpty) {
      _selectedCurrency = currencies.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Padding(
      // Keyboard inset — keeps the Save button above the on-screen keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
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
                color: ColorManager.of(context).border,
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
                              color: ColorManager.success.withValues(
                                alpha: 0.1,
                              ),
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
                                  l10n.recordPaymentTitle,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.of(context).textPrimary,
                                  ),
                                ),
                                Text(
                                  widget.patientName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: FontHelper.fontFamily(context),
                                    color: ColorManager.of(
                                      context,
                                    ).textSecondary,
                                  ),
                                ),
                                if (widget.caseCurrencyCode != null)
                                  Text(
                                    '${l10n.caseCurrency}: ${widget.caseCurrencyCode}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: fontFamily,
                                      color: ColorManager.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: ColorManager.of(context).textSecondary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Payment summary
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: ColorManager.of(context).cardBgSecondary,
                          borderRadius: BorderRadiusManager.lg,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 8.h),
                            _buildSummaryRow(
                              l10n.totalCost,
                              '${widget.caseCurrencyCode ?? ''} ${widget.totalCost.toStringAsFixed(2)}',
                            ),
                            SizedBox(height: 8.h),
                            _buildSummaryRow(
                              l10n.alreadyPaid,
                              '${widget.caseCurrencyCode ?? ''} ${widget.paidAmount.toStringAsFixed(2)}',
                              valueColor: ColorManager.success,
                            ),
                            SizedBox(height: 8.h),
                            Divider(
                              color: ColorManager.of(context).borderLight,
                            ),
                            SizedBox(height: 8.h),
                            _buildSummaryRow(
                              l10n.remaining,
                              '${widget.caseCurrencyCode ?? ''} ${_remainingAmount.toStringAsFixed(2)}',
                              valueColor: _remainingAmount > 0
                                  ? ColorManager.warning
                                  : ColorManager.success,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Currency selector
                      _buildLabel(l10n.currency),
                      SizedBox(height: 6.h),
                      BlocBuilder<CurrencyBloc, CurrencyState>(
                        bloc: _currencyBloc,
                        builder: (context, state) {
                          return state.when(
                            initial: () => const SizedBox.shrink(),
                            loading: () => SizedBox(
                              height: 40.h,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            loaded: (currencies) {
                              _initCurrencySelection(currencies);
                              return CurrencyChips(
                                currencies: currencies,
                                selectedCurrency: _selectedCurrency,
                                onSelected: (currency) {
                                  setState(() {
                                    _selectedCurrency = currency;
                                    _isExchangeSwapped = false;
                                    _exchangeRateController.clear();
                                  });
                                },
                              );
                            },
                            error: (msg) => Text(
                              msg,
                              style: TextStyle(
                                color: ColorManager.error,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Exchange rate (only if currency changed)
                      if (_isCurrencyChanged) ...[
                        _buildLabel(l10n.exchangeRate),
                        SizedBox(height: 6.h),
                        _buildExchangeRateFields(fontFamily),
                        SizedBox(height: 16.h),
                      ],

                      // Amount field
                      _buildAmountField(),

                      SizedBox(height: 16.h),

                      // Note (optional)
                      _buildLabel(l10n.noteOptional),
                      SizedBox(height: 6.h),
                      TextFormField(
                        controller: _noteController,
                        maxLines: 2,
                        decoration: formOutlinedInput(
                          context,
                          hintText: l10n.addNote,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Save button
                      _isSubmitting
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: l10n.save,
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    _selectedCurrency != null) {
                                  final amount = double.tryParse(
                                    _amountController.text.trim(),
                                  );
                                  if (amount == null) return;
                                  // The rate field is only rendered when the
                                  // payment currency differs from the case
                                  // currency, so on the common same-currency
                                  // path this controller is empty - parsing it
                                  // outright threw FormatException on every
                                  // save.
                                  final parsedRate = double.tryParse(
                                    _exchangeRateController.text.trim(),
                                  );
                                  // Guard the divide below: a zero rate would
                                  // send Infinity to the API.
                                  final exchangeRate =
                                      (parsedRate == null || parsedRate <= 0)
                                      ? 1.0
                                      : parsedRate;
                                  final caseCurrencyId =
                                      widget.caseCurrencyId ??
                                      _selectedCurrency!.id;

                                  // If same currency, no conversion needed
                                  // If different currency, convert based on swap direction:
                                  //   Not swapped: 1 [caseCurrency] = X [selectedCurrency] → divide
                                  //   Swapped:     1 [selectedCurrency] = X [caseCurrency] → multiply
                                  double amountInCaseCurrency;
                                  if (!_isCurrencyChanged) {
                                    amountInCaseCurrency = amount;
                                  } else if (_isExchangeSwapped) {
                                    // 1 selectedCurrency = X caseCurrency → multiply
                                    amountInCaseCurrency =
                                        amount * exchangeRate;
                                  } else {
                                    // 1 caseCurrency = X selectedCurrency → divide
                                    amountInCaseCurrency =
                                        amount / exchangeRate;
                                  }

                                  final notes =
                                      _noteController.text.trim().isEmpty
                                      ? null
                                      : _noteController.text.trim();

                                  setState(() => _isSubmitting = true);
                                  try {
                                    await widget.onSave(
                                      amount,
                                      _selectedCurrency!.id,
                                      caseCurrencyId,
                                      amountInCaseCurrency,
                                      exchangeRate,
                                      notes,
                                    );
                                    if (mounted) context.pop();
                                  } catch (_) {
                                    if (mounted) {
                                      setState(() => _isSubmitting = false);
                                    }
                                  }
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeRateFields(String fontFamily) {
    final l10n = AppLocalizations.of(context)!;
    final caseCurrencyCode = widget.caseCurrencyCode ?? '';
    final selectedCurrencyCode = _selectedCurrency?.currencyCode ?? '';

    // Determine which currency is on each side
    final leftCurrency = _isExchangeSwapped
        ? selectedCurrencyCode
        : caseCurrencyCode;
    final rightCurrency = _isExchangeSwapped
        ? caseCurrencyCode
        : selectedCurrencyCode;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left field: always "1"
        Expanded(
          child: TextFormField(
            initialValue: '1',
            readOnly: true,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600,
              color: ColorManager.of(context).textPrimary,
            ),
            decoration: InputDecoration(
              prefixIcon: _buildCurrencyPrefix(leftCurrency, fontFamily),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              filled: true,
              fillColor: ColorManager.of(context).cardBgSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(
                  color: ColorManager.of(context).borderLight,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(
                  color: ColorManager.of(context).borderLight,
                ),
              ),
            ),
          ),
        ),

        // Swap button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExchangeSwapped = !_isExchangeSwapped;
                _exchangeRateController.clear();
              });
            },
            child: Container(
              width: 36.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Icon(
                Icons.swap_horiz,
                color: ColorManager.primary,
                size: 20.w,
              ),
            ),
          ),
        ),

        // Right field: user enters value
        Expanded(
          child: TextFormField(
            controller: _exchangeRateController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,6}')),
            ],
            style: TextStyle(
              fontFamily: fontFamily,
              color: ColorManager.of(context).textPrimary,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              prefixIcon: _buildCurrencyPrefix(rightCurrency, fontFamily),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              hintStyle: TextStyle(
                color: ColorManager.of(context).textTertiary,
                fontFamily: fontFamily,
              ),
              filled: true,
              fillColor: ColorManager.of(context).inputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(
                  color: ColorManager.of(context).borderLight,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(
                  color: ColorManager.of(context).borderLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.primary),
              ),
            ),
            validator: (value) {
              if (!_isCurrencyChanged) return null;
              if (value == null || value.isEmpty) {
                return l10n.pleaseEnterAmount;
              }
              final rate = double.tryParse(value);
              if (rate == null || rate <= 0) {
                return l10n.pleaseEnterValidAmount;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildAmountField() {
    final l10n = AppLocalizations.of(context)!;
    final currencyCode = _selectedCurrency?.currencyCode ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(l10n.amountRequired),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: '0.00',
                  prefixIcon: _buildCurrencyPrefix(
                    currencyCode,
                    FontHelper.fontFamily(context),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  hintStyle: TextStyle(
                    color: ColorManager.of(context).textTertiary,
                    fontFamily: FontHelper.fontFamily(context),
                  ),
                  filled: true,
                  fillColor: ColorManager.of(context).inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadiusManager.lg,
                    borderSide: BorderSide(
                      color: ColorManager.of(context).borderLight,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadiusManager.lg,
                    borderSide: BorderSide(
                      color: ColorManager.of(context).borderLight,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadiusManager.lg,
                    borderSide: BorderSide(color: ColorManager.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterAmount;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return l10n.pleaseEnterValidAmount;
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
                  l10n.fullAmount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyPrefix(String code, String fontFamily) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 6.w),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: ColorManager.of(context).textSecondary,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontHelper.fontFamily(context),
        fontWeight: FontWeight.w500,
        color: ColorManager.of(context).textPrimary,
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: valueColor ?? ColorManager.of(context).textPrimary,
          ),
        ),
      ],
    );
  }
}
