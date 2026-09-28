import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:dental_clinic_app/custom_widgets/custom_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// What a plan costs: a total, a lab fee, and a currency for each.
///
/// Lives on its own because the same two fields are asked for in two places -
/// folded into the summary card on a phone, and laid open inside the blue
/// plan card on desktop. One copy of the form means the two cannot drift
/// apart.
///
/// Reports on every keystroke and every chip rather than behind a save
/// button: there is nothing to save *to* until the plan itself is saved.
class CostFields extends StatefulWidget {
  const CostFields({
    super.key,
    required this.initialTotalCost,
    required this.initialLabFees,
    this.initialTotalCostCurrency,
    this.initialLabFeesCurrency,
    required this.onChanged,
    this.autofocus = false,
    this.direction = Axis.vertical,
    this.onPrimary = false,
  });

  final double initialTotalCost;
  final double initialLabFees;
  final CurrencyEntity? initialTotalCostCurrency;
  final CurrencyEntity? initialLabFeesCurrency;

  final void Function(
    double totalCost,
    double labFees,
    CurrencyEntity? totalCostCurrency,
    CurrencyEntity? labFeesCurrency,
  )
  onChanged;

  /// Puts the caret in the total the moment the form appears - worth it when
  /// the form opened because the user asked for it, and wrong when it is
  /// simply on screen.
  final bool autofocus;

  /// [Axis.horizontal] sets the two figures side by side, each with its
  /// currency beside the field rather than under it - one line, for a desktop
  /// card with the width for it.
  final Axis direction;

  /// Drawn on the primary-coloured plan card: light labels, card-coloured
  /// fields and chips that stay legible on blue.
  final bool onPrimary;

  @override
  State<CostFields> createState() => _CostFieldsState();
}

class _CostFieldsState extends State<CostFields> {
  late final TextEditingController _totalCostController;
  late final TextEditingController _labFeesController;
  CurrencyEntity? _totalCostCurrency;
  CurrencyEntity? _labFeesCurrency;
  final _currencyBloc = getIt<CurrencyBloc>();

  double get _totalCost => double.tryParse(_totalCostController.text) ?? 0;
  double get _labFees => double.tryParse(_labFeesController.text) ?? 0;

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

    _currencyBloc.state.maybeWhen(
      loaded: _selectDefaults,
      orElse: () => _currencyBloc.add(const CurrencyEvent.load()),
    );

    _totalCostController.addListener(_report);
    _labFeesController.addListener(_report);
  }

  @override
  void dispose() {
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  /// Most clinics bill in one currency, so the list's SYP - or whatever comes
  /// first - is filled in rather than asked for.
  ///
  /// This can run from [initState], which happens while the owning page is
  /// itself building - so the page is told about the defaults after the
  /// frame, never during it.
  void _selectDefaults(List<CurrencyEntity> currencies) {
    if (currencies.isEmpty) return;
    if (_totalCostCurrency != null && _labFeesCurrency != null) return;
    final fallback = currencies.firstWhere(
      (c) => c.currencyCode.toUpperCase() == 'SYP',
      orElse: () => currencies.first,
    );
    _totalCostCurrency ??= fallback;
    _labFeesCurrency ??= fallback;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _report();
    });
  }

  void _report() {
    widget.onChanged(
      _totalCost,
      _labFees,
      _totalCostCurrency,
      _labFeesCurrency,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<CurrencyBloc, CurrencyState>(
      bloc: _currencyBloc,
      listener: (_, state) {
        state.maybeWhen(loaded: _selectDefaults, orElse: () {});
      },
      child: widget.direction == Axis.horizontal
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _totalGroup(l10n)),
                SizedBox(width: 20.w),
                Expanded(child: _labGroup(l10n)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _totalGroup(l10n),
                SizedBox(height: 14.h),
                _labGroup(l10n),
              ],
            ),
    );
  }

  Widget _totalGroup(AppLocalizations l10n) => _group(
    label: l10n.totalCost,
    controller: _totalCostController,
    autofocus: widget.autofocus,
    currency: _CurrencyRow(
      bloc: _currencyBloc,
      selected: _totalCostCurrency,
      onPrimary: widget.onPrimary,
      showError: _totalCost > 0 && _totalCostCurrency == null,
      onSelected: (currency) {
        _totalCostCurrency = currency;
        _report();
      },
    ),
  );

  Widget _labGroup(AppLocalizations l10n) => _group(
    label: l10n.labFees,
    controller: _labFeesController,
    currency: _CurrencyRow(
      bloc: _currencyBloc,
      selected: _labFeesCurrency,
      onPrimary: widget.onPrimary,
      showError: _labFees > 0 && _labFeesCurrency == null,
      onSelected: (currency) {
        _labFeesCurrency = currency;
        _report();
      },
    ),
  );

  /// Label, field and currency for one figure. Side by side, the chips sit
  /// on the field's line; stacked, under it.
  Widget _group({
    required String label,
    required TextEditingController controller,
    required Widget currency,
    bool autofocus = false,
  }) {
    final field = _field(controller, autofocus: autofocus);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        SizedBox(height: 6.h),
        if (widget.direction == Axis.horizontal)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: field),
              SizedBox(width: 10.w),
              // Nudged to sit centred on the field's line.
              Padding(padding: EdgeInsets.only(top: 9.h), child: currency),
            ],
          )
        else ...[
          field,
          SizedBox(height: 8.h),
          currency,
        ],
      ],
    );
  }

  /// The same 11.5sp label every other form field in the app carries, so
  /// these two do not read a size larger than the fields around them.
  Widget _label(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 11.5.sp,
      fontFamily: FontHelper.fontFamily(context),
      fontWeight: FontWeight.w500,
      color: widget.onPrimary
          ? ColorManager.white.withValues(alpha: 0.85)
          : ColorManager.of(context).textSecondary,
    ),
  );

  /// [CustomTextField] rather than a hand-decorated [TextField]: the sheet
  /// this form came out of drew its own 10px radius, 15sp text and a 1px
  /// focus ring, none of which is the house style - inputs are 12px with
  /// 13sp text and a 1.5px focused border, and every other field in the app
  /// gets that by going through this widget.
  Widget _field(
    TextEditingController controller, {
    bool autofocus = false,
  }) {
    return CustomTextField(
      controller: controller,
      autofocus: autofocus,
      hintText: '0.00',
      // On the blue card the field is lifted to the card colour: the usual
      // grey input fill reads as a hole punched through the blue.
      fillColor: widget.onPrimary ? ColorManager.of(context).cardBg : null,
      // Taller on the desktop card, where the fields are the card's main
      // content rather than something folded under it. Null keeps the phone
      // on the shared padding.
      contentPadding: widget.onPrimary
          ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 17.h)
          : null,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
    );
  }
}

class _CurrencyRow extends StatelessWidget {
  const _CurrencyRow({
    required this.bloc,
    required this.selected,
    required this.showError,
    required this.onSelected,
    this.onPrimary = false,
  });

  final CurrencyBloc bloc;
  final CurrencyEntity? selected;
  final bool onPrimary;

  /// A figure was typed but no currency picked - the one state the API
  /// cannot take.
  final bool showError;
  final ValueChanged<CurrencyEntity> onSelected;

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
                  color: onPrimary ? ColorManager.white : ColorManager.primary,
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
                  onPrimary: onPrimary,
                ),
                if (showError) ...[
                  SizedBox(height: 4.h),
                  Text(
                    AppLocalizations.of(context)!.pleaseSelectCurrency,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      // Error red is unreadable on the blue card.
                      color: onPrimary
                          ? const Color(0xFFFFE3E3)
                          : ColorManager.error,
                      fontWeight: onPrimary ? FontWeight.w600 : null,
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
