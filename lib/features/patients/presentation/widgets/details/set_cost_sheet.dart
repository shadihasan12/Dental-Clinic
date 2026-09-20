import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/cost_fields.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';
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
  double _totalCost = 0;
  double _labFees = 0;
  CurrencyEntity? _totalCostCurrency;
  CurrencyEntity? _labFeesCurrency;

  bool get _canSave => _totalCost > 0 && _totalCostCurrency != null;

  @override
  void initState() {
    super.initState();
    _totalCost = widget.initialTotalCost;
    _labFees = widget.initialLabFees;
    _totalCostCurrency = widget.initialTotalCostCurrency;
    _labFeesCurrency = widget.initialLabFeesCurrency;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: c.cardBg,
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
                color: c.border,
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
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          // The same two fields the summary card opens inline.
          CostFields(
            initialTotalCost: widget.initialTotalCost,
            initialLabFees: widget.initialLabFees,
            initialTotalCostCurrency: widget.initialTotalCostCurrency,
            initialLabFeesCurrency: widget.initialLabFeesCurrency,
            onChanged: (total, lab, totalCurrency, labCurrency) {
              setState(() {
                _totalCost = total;
                _labFees = lab;
                _totalCostCurrency = totalCurrency;
                _labFeesCurrency = labCurrency;
              });
            },
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
                color: _canSave ? ColorManager.primary : c.borderLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                l10n.save,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: _canSave ? ColorManager.white : c.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
