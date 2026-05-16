import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetCostSheet extends StatefulWidget {
  final double initialTotalCost;
  final double initialLabFees;
  final CurrencyEntity? initialTotalCostCurrency;
  final CurrencyEntity? initialLabFeesCurrency;
  final void Function(
    double totalCost,
    double labFees,
    CurrencyEntity? totalCostCurrency,
    CurrencyEntity? labFeesCurrency,
  ) onSave;

  const SetCostSheet({
    super.key,
    required this.initialTotalCost,
    required this.initialLabFees,
    this.initialTotalCostCurrency,
    this.initialLabFeesCurrency,
    required this.onSave,
  });

  static Future<void> show(
    BuildContext context, {
    required double totalCost,
    required double labFees,
    CurrencyEntity? totalCostCurrency,
    CurrencyEntity? labFeesCurrency,
    required void Function(
      double totalCost,
      double labFees,
      CurrencyEntity? totalCostCurrency,
      CurrencyEntity? labFeesCurrency,
    ) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SetCostSheet(
        initialTotalCost: totalCost,
        initialLabFees: labFees,
        initialTotalCostCurrency: totalCostCurrency,
        initialLabFeesCurrency: labFeesCurrency,
        onSave: onSave,
      ),
    );
  }

  @override
  State<SetCostSheet> createState() => _SetCostSheetState();
}

class _SetCostSheetState extends State<SetCostSheet> {
  late final TextEditingController _totalCostController;
  late final TextEditingController _labFeesController;
  CurrencyEntity? _totalCostCurrency;
  CurrencyEntity? _labFeesCurrency;
  final _currencyBloc = getIt<CurrencyBloc>();

  double get _totalCost =>
      double.tryParse(_totalCostController.text) ?? 0;
  double get _labFees =>
      double.tryParse(_labFeesController.text) ?? 0;

  bool get _canSave => _totalCost > 0 && _totalCostCurrency != null;

  void _autoSelectDefault(List<CurrencyEntity> currencies) {
    if (currencies.isEmpty) return;
    final defaultCurrency = currencies.firstWhere(
      (c) => c.currencyCode.toUpperCase() == 'SYP',
      orElse: () => currencies.first,
    );
    setState(() {
      _totalCostCurrency ??= defaultCurrency;
      _labFeesCurrency ??= defaultCurrency;
    });
  }

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
    _totalCostCurrency = widget.initialTotalCostCurrency;
    _labFeesCurrency = widget.initialLabFeesCurrency;

    // Trigger load or auto-select if already loaded
    _currencyBloc.state.maybeWhen(
      loaded: (currencies) {
        // currencies are already available — auto-select synchronously
        final defaultCurrency = currencies.firstWhere(
          (c) => c.currencyCode.toUpperCase() == 'SYP',
          orElse: () => currencies.first,
        );
        _totalCostCurrency ??= defaultCurrency;
        _labFeesCurrency ??= defaultCurrency;
      },
      orElse: () => _currencyBloc.add(const CurrencyEvent.load()),
    );

    _totalCostController.addListener(() => setState(() {}));
    _labFeesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({String? errorText}) {
    return InputDecoration(
      hintText: '0.00',
      errorText: errorText,
      hintStyle: TextStyle(fontSize: 15.sp, color: ColorManager.of(context).textTertiary),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<CurrencyBloc, CurrencyState>(
      bloc: _currencyBloc,
      listener: (_, state) {
        state.maybeWhen(
          loaded: _autoSelectDefault,
          orElse: () {},
        );
      },
      child: Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(
            l10n.setCost,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          // ── Total Cost ──────────────────────────────────
          Text(
            l10n.totalCost,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: _totalCostController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textPrimary,
            ),
            decoration: _inputDecoration(),
          ),
          SizedBox(height: 8.h),
          _CurrencyRow(
            bloc: _currencyBloc,
            selected: _totalCostCurrency,
            required: _totalCost > 0,
            onSelected: (c) => setState(() => _totalCostCurrency = c),
          ),

          SizedBox(height: 14.h),

          // ── Lab Fees ────────────────────────────────────
          Text(
            l10n.labFees,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: _labFeesController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.of(context).textPrimary,
            ),
            decoration: _inputDecoration(),
          ),
          SizedBox(height: 8.h),
          _CurrencyRow(
            bloc: _currencyBloc,
            selected: _labFeesCurrency,
            required: _labFees > 0,
            onSelected: (c) => setState(() => _labFeesCurrency = c),
          ),

          SizedBox(height: 16.h),

          // ── Save button ─────────────────────────────────
          GestureDetector(
            onTap: _canSave
                ? () {
                    widget.onSave(
                      _totalCost,
                      _labFees,
                      _totalCostCurrency,
                      _labFeesCurrency,
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: _canSave ? ColorManager.primary : ColorManager.of(context).borderLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                l10n.save,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: _canSave
                      ? ColorManager.white
                      : ColorManager.of(context).textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class _CurrencyRow extends StatelessWidget {
  final CurrencyBloc bloc;
  final CurrencyEntity? selected;
  final bool required;
  final ValueChanged<CurrencyEntity> onSelected;

  const _CurrencyRow({
    required this.bloc,
    required this.selected,
    required this.required,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      bloc: bloc,
      builder: (_, state) {
        return state.maybeWhen(
          loading: () => SizedBox(
            height: 28.h,
            child: Center(
              child: SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
          loaded: (currencies) {
            if (currencies.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrencyChips(
                  currencies: currencies,
                  selectedCurrency: selected,
                  onSelected: onSelected,
                ),
                if (required && selected == null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    AppLocalizations.of(context)!.pleaseSelectCurrency,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.error,
                    ),
                  ),
                ],
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
