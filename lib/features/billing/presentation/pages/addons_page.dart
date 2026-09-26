import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/quote_sheet.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extra seats and storage: the add-ons on sale, the units the clinic holds
/// now and for its next cycle, and buying more for the rest of this cycle.
///
/// Units are only ever added here. Dropping them happens at a renewal, so
/// the page says so rather than offering a remove button.
class AddonsPage extends StatelessWidget {
  const AddonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    return AdaptivePageScaffold(
      backgroundColor: c.scaffoldBg,
      title: l10n.addonsTitle,
      maxContentWidth: 760,
      body: BillingAsync<List<AddonEntity>>(
        load: repository.getAddons,
        builder: (context, addons, _) {
          final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
          if (addons.isEmpty) {
            return ListView(
              padding: EdgeInsets.all(14.w),
              children: [
                StateCard(
                  icon: Icons.extension_outlined,
                  title: l10n.addonsEmptyTitle,
                  message: l10n.addonsEmptyMessage,
                ),
              ],
            );
          }
          return ListView(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
            children: [
              _PageNote(text: l10n.addonsIntro),
              SizedBox(height: 12.h),
              for (final addon in addons) ...[
                _AddonCard(key: ValueKey(addon.versionId), addon: addon),
                SizedBox(height: 10.h),
              ],
              SizedBox(height: 2.h),
              _PageNote(
                text: l10n.addonsRemoveNote,
                icon: Icons.info_outline_rounded,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A quiet line of explanation above or below the cards.
class _PageNote extends StatelessWidget {
  const _PageNote({required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final label = Text(
      text,
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 12.sp,
        height: 1.4,
        color: c.textTertiary,
      ),
    );
    if (icon == null) return label;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Icon(icon, size: 15.w, color: c.textTertiary),
        ),
        SizedBox(width: 6.w),
        Expanded(child: label),
      ],
    );
  }
}

class _AddonCard extends StatefulWidget {
  const _AddonCard({super.key, required this.addon});

  final AddonEntity addon;

  @override
  State<_AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<_AddonCard> {
  static const int _minQuantity = 1;
  static const int _maxQuantity = 1000;

  int _quantity = _minQuantity;

  AddonEntity get _addon => widget.addon;

  Future<void> _seePrice() async {
    final repository = getIt<BillingRepository>();
    final addon = _addon;
    final quantity = _quantity;
    final result = await showQuoteSheet(
      context,
      quote: () => repository.getAddonQuote(addon.versionId, quantity),
      request: () => repository.requestAddons(addon.versionId, quantity),
    );
    if (result != null && mounted) handleQuoteSheetResult(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final addon = _addon;
    final isStorage =
        addon.limit == 'max-storage-mb' || addon.slug == 'storage-addon';

    final description = addon.description;
    final monthly = _unitPrice(addon.priceMonthly, addon.priceMonthlyUsd);
    final yearly = _unitPrice(addon.priceYearly, addon.priceYearlyUsd);

    final nextCycle = addon.nextCycleUnits;
    final owned = [
      l10n.addonOwnedNow(addon.ownedUnits),
      if (nextCycle != null) l10n.addonOwnedNextCycle(nextCycle),
    ].join(' · ');

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(
                icon: isStorage
                    ? Icons.cloud_outlined
                    : Icons.people_alt_outlined,
                tone: isStorage ? ColorManager.info : ColorManager.primary,
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addon.name,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 11.sp,
                          height: 1.35,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.addonPricePerUnitMonthly(monthly),
            style: TextStyle(
              fontFamily: family,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            l10n.addonPricePerUnitYearly(yearly),
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          BillingInfoRow(label: l10n.addonOwnedLabel, value: owned),
          SizedBox(height: 8.h),
          if (addon.canBuy) ...[
            _QuantityStepper(
              quantity: _quantity,
              min: _minQuantity,
              max: _maxQuantity,
              onChanged: (q) => setState(() => _quantity = q),
            ),
            SizedBox(height: 10.h),
            DentaButton(
              label: l10n.seePriceAction,
              icon: Icons.receipt_long_outlined,
              expand: true,
              onTap: _seePrice,
            ),
          ] else if (addon.reason != null && addon.reason!.isNotEmpty)
            _ReasonBox(text: addon.reason!),
        ],
      ),
    );
  }

  /// The SYP figure when the server prices one - picked by currency, since
  /// the list's order is not fixed - else the first currency given, else
  /// the USD number.
  static String _unitPrice(List<PriceEntity> prices, double usd) {
    for (final p in prices) {
      if (p.currency.toUpperCase() == 'SYP') return formatPrice(p);
    }
    if (prices.isNotEmpty) return formatPrice(prices.first);
    return formatUsd(usd);
  }
}

/// How many units to add, one at a time.
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final int quantity;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    Widget button(IconData icon, VoidCallback? onTap) => IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 18.w),
          color: ColorManager.primaryDarker,
          disabledColor: c.textSubtle,
          style: IconButton.styleFrom(
            backgroundColor: c.cardBgSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.addonQuantityLabel,
            style: TextStyle(
              fontFamily: family,
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
        ),
        button(
          Icons.remove_rounded,
          quantity > min ? () => onChanged(quantity - 1) : null,
        ),
        SizedBox(
          width: 56.w,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
        ),
        button(
          Icons.add_rounded,
          quantity < max ? () => onChanged(quantity + 1) : null,
        ),
      ],
    );
  }
}

/// Why units cannot be bought now, in the server's words.
class _ReasonBox extends StatelessWidget {
  const _ReasonBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 16.w, color: ColorManager.warning),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                height: 1.4,
                color: c.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
