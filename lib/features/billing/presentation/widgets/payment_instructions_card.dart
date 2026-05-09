import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentInstructionsCard extends StatelessWidget {
  const PaymentInstructionsCard({super.key, required this.instructions});

  final PaymentInstructions instructions;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.howToPayTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            l10n.howToPaySubtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: fontFamily,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 12.h),
          _ReferenceTile(reference: instructions.referenceNumber),
          SizedBox(height: 12.h),
          ...instructions.channels.map(
            (ch) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _ChannelTile(channel: ch),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorManager.warningBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline,
                    size: 16.w, color: ColorManager.warning),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    l10n.payOutsideAppNotice,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: fontFamily,
                      color: ColorManager.warning,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceTile extends StatelessWidget {
  const _ReferenceTile({required this.reference});

  final String reference;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.confirmation_number_outlined,
              size: 18.w, color: ColorManager.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.referenceNumber,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: fontFamily,
                    color: c.textTertiary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  reference,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.copy_rounded,
                size: 18.w, color: ColorManager.primary),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: reference));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.copied)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ChannelTile extends StatelessWidget {
  const _ChannelTile({required this.channel});

  final ManualPaymentChannel channel;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(_iconFor(channel.method),
                size: 18.w, color: ColorManager.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _labelFor(channel.method, l10n),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  channel.account,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: fontFamily,
                    color: c.textSecondary,
                  ),
                ),
                if (channel.holderName != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    channel.holderName!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: fontFamily,
                      color: c.textTertiary,
                    ),
                  ),
                ],
                if (channel.note != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    channel.note!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: fontFamily,
                      color: c.textTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(ManualPaymentMethod method) {
    switch (method) {
      case ManualPaymentMethod.cash:
        return Icons.payments_outlined;
      case ManualPaymentMethod.syriatelCash:
        return Icons.phone_iphone_outlined;
      case ManualPaymentMethod.shamCash:
        return Icons.account_balance_wallet_outlined;
      case ManualPaymentMethod.bankTransfer:
        return Icons.account_balance_outlined;
    }
  }

  String _labelFor(ManualPaymentMethod method, AppLocalizations l10n) {
    switch (method) {
      case ManualPaymentMethod.cash:
        return l10n.paymentMethodCash;
      case ManualPaymentMethod.syriatelCash:
        return l10n.paymentMethodSyriatelCash;
      case ManualPaymentMethod.shamCash:
        return l10n.paymentMethodShamCash;
      case ManualPaymentMethod.bankTransfer:
        return l10n.paymentMethodBankTransfer;
    }
  }
}
