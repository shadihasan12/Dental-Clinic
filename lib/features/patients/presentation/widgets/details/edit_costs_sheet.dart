import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditCostsSheet extends StatefulWidget {
  final double initialTotalCost;
  final double initialLabFees;
  final String? initialTotalCostCurrencyId;
  final String? initialLabFeesCurrencyId;
  final Future<void> Function(
    double totalCost,
    String? totalCostCurrencyId,
    double labFees,
    String? labFeesCurrencyId,
  ) onSave;

  const EditCostsSheet({
    super.key,
    required this.initialTotalCost,
    required this.initialLabFees,
    this.initialTotalCostCurrencyId,
    this.initialLabFeesCurrencyId,
    required this.onSave,
  });

  static void show(
    BuildContext context, {
    required double initialTotalCost,
    required double initialLabFees,
    String? initialTotalCostCurrencyId,
    String? initialLabFeesCurrencyId,
    required Future<void> Function(
      double totalCost,
      String? totalCostCurrencyId,
      double labFees,
      String? labFeesCurrencyId,
    ) onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditCostsSheet(
        initialTotalCost: initialTotalCost,
        initialLabFees: initialLabFees,
        initialTotalCostCurrencyId: initialTotalCostCurrencyId,
        initialLabFeesCurrencyId: initialLabFeesCurrencyId,
        onSave: onSave,
      ),
    );
  }

  @override
  State<EditCostsSheet> createState() => _EditCostsSheetState();
}

class _EditCostsSheetState extends State<EditCostsSheet> {
  late final TextEditingController _totalCostController;
  late final TextEditingController _labFeesController;
  CurrencyEntity? _selectedTotalCostCurrency;
  CurrencyEntity? _selectedLabFeesCurrency;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _totalCostController = TextEditingController(
      text: widget.initialTotalCost > 0
          ? widget.initialTotalCost.toStringAsFixed(0)
          : '',
    );
    _labFeesController = TextEditingController(
      text: widget.initialLabFees > 0
          ? widget.initialLabFees.toStringAsFixed(0)
          : '',
    );

    final currencyBloc = getIt<CurrencyBloc>();
    final isLoaded = currencyBloc.state.maybeMap(
      loaded: (_) => true,
      orElse: () => false,
    );
    if (!isLoaded) {
      currencyBloc.add(const CurrencyEvent.load());
    }
  }

  void _initCurrencySelections(List<CurrencyEntity> currencies) {
    if (currencies.isEmpty) return;
    if (_selectedTotalCostCurrency == null) {
      if (widget.initialTotalCostCurrencyId != null) {
        final match = currencies
            .where((c) => c.id == widget.initialTotalCostCurrencyId);
        _selectedTotalCostCurrency =
            match.isNotEmpty ? match.first : currencies.first;
      } else {
        _selectedTotalCostCurrency = currencies.first;
      }
    }
    if (_selectedLabFeesCurrency == null) {
      if (widget.initialLabFeesCurrencyId != null) {
        final match = currencies
            .where((c) => c.id == widget.initialLabFeesCurrencyId);
        _selectedLabFeesCurrency =
            match.isNotEmpty ? match.first : currencies.first;
      } else {
        _selectedLabFeesCurrency = currencies.first;
      }
    }
  }

  @override
  void dispose() {
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final totalCost =
        double.tryParse(_totalCostController.text.trim()) ?? 0;
    final labFees =
        double.tryParse(_labFeesController.text.trim()) ?? 0;

    setState(() => _saving = true);
    try {
      await widget.onSave(
        totalCost,
        _selectedTotalCostCurrency?.id,
        labFees,
        _selectedLabFeesCurrency?.id,
      );
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: BlocBuilder<CurrencyBloc, CurrencyState>(
        bloc: getIt<CurrencyBloc>(),
        builder: (context, currencyState) {
          final currencies = currencyState.maybeMap(
            loaded: (s) => s.currencies,
            orElse: () => <CurrencyEntity>[],
          );

          if (currencies.isNotEmpty) {
            _initCurrencySelections(currencies);
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: ColorManager.of(context).border,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Title
                Text(
                  AppLocalizations.of(context)!.editCosts,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),

                // Total Cost
                _buildLabel(context, AppLocalizations.of(context)!.totalCost),
                SizedBox(height: 8.h),
                _buildTextField(_totalCostController, AppLocalizations.of(context)!.enterTotalCost),
                if (currencies.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  CurrencyChips(
                    currencies: currencies,
                    selectedCurrency: _selectedTotalCostCurrency,
                    onSelected: (c) =>
                        setState(() => _selectedTotalCostCurrency = c),
                  ),
                ],
                SizedBox(height: 20.h),

                // Lab Fees
                _buildLabel(context, AppLocalizations.of(context)!.labFees),
                SizedBox(height: 8.h),
                _buildTextField(_labFeesController, AppLocalizations.of(context)!.enterLabFees),
                if (currencies.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  CurrencyChips(
                    currencies: currencies,
                    selectedCurrency: _selectedLabFeesCurrency,
                    onSelected: (c) =>
                        setState(() => _selectedLabFeesCurrency = c),
                  ),
                ],
                SizedBox(height: 24.h),

                // Save button
                GestureDetector(
                  onTap: _saving ? null : _save,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: _saving
                          ? ColorManager.primary.withValues(alpha: 0.5)
                          : ColorManager.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: _saving
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.save,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.white,
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

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontHelper.fontFamily(context),
        fontWeight: FontWeight.w500,
        color: ColorManager.of(context).textSecondary,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 15.sp,
        fontFamily: FontHelper.fontFamily(context),
        color: ColorManager.of(context).textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: ColorManager.of(context).textTertiary,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        filled: true,
        fillColor: ColorManager.of(context).cardBgSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorManager.of(context).borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorManager.of(context).borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
      ),
    );
  }
}
