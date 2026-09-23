import 'package:dartz/dartz.dart' show Either;
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/report_payment_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_cards.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class _PaymentsData {
  const _PaymentsData(this.payments, this.methodNames);

  final List<ClinicPaymentEntity> payments;

  /// method code -> its translated name, from the payment-methods list.
  final Map<String, String> methodNames;
}

Future<Either<NetworkExceptions, Map<String, String>>> _loadMethodNames(
  BillingRepository repository,
) async {
  final result = await repository.getPaymentMethods();
  return result.map((list) => {for (final m in list) m.method: m.name});
}

/// Every transfer the clinic reported, newest first, with where its review
/// stands. A pending one can be withdrawn; a refused one shows the admin's
/// reason and can be reported again.
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    Future<Either<NetworkExceptions, _PaymentsData>> load() async {
      final paymentsF = repository.getPayments();
      final namesF = _loadMethodNames(repository);
      final payments = await paymentsF;
      final names = (await namesF).getOrElse(() => const {});
      return payments.map((list) => _PaymentsData(list, names));
    }

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.reportedTransfersTitle),
      body: BillingAsync<_PaymentsData>(
        load: load,
        builder: (context, data, reload) {
          final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
          if (data.payments.isEmpty) {
            return ListView(
              padding: EdgeInsets.all(14.w),
              children: [
                StateCard(
                  icon: Icons.swap_horiz_rounded,
                  title: l10n.noTransfersYet,
                  message: l10n.noTransfersYetHint,
                ),
              ],
            );
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
            itemCount: data.payments.length,
            separatorBuilder: (_, _) => SizedBox(height: 8.h),
            itemBuilder: (context, i) {
              final payment = data.payments[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PaymentCard(
                    payment: payment,
                    methodNames: data.methodNames,
                    onTap: () async {
                      await context.pushNamed(
                        AppRoutesNames.paymentDetails,
                        pathParameters: {'paymentId': payment.id},
                      );
                      reload();
                    },
                  ),
                  _PaymentActions(payment: payment, onChanged: reload),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Withdraw on a pending report, report again on a refused one; nothing on
/// the rest.
class _PaymentActions extends StatelessWidget {
  const _PaymentActions({required this.payment, required this.onChanged});

  final ClinicPaymentEntity payment;
  final Future<void> Function() onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (payment.status) {
      case ClinicPaymentStatus.pending:
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: () async {
              if (await withdrawPayment(context, payment)) onChanged();
            },
            icon: const Icon(Icons.undo_rounded, size: 18),
            label: Text(l10n.withdrawReport),
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
          ),
        );
      case ClinicPaymentStatus.rejected:
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: () async {
              await reportAgain(context, payment);
              onChanged();
            },
            icon: const Icon(Icons.replay_rounded, size: 18),
            label: Text(l10n.reportAgain),
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.primaryDarker,
            ),
          ),
        );
      case ClinicPaymentStatus.verified:
      case ClinicPaymentStatus.cancelled:
      case ClinicPaymentStatus.unknown:
        return const SizedBox.shrink();
    }
  }
}

/// Opens the form pre-filled from a refused report, so only what was wrong -
/// usually the reference - needs correcting.
Future<void> reportAgain(BuildContext context, ClinicPaymentEntity payment) {
  return context.pushNamed(
    AppRoutesNames.reportPayment,
    extra: ReportPaymentPrefill(
      method: payment.method,
      accountId: payment.paymentAccountId,
      currency: payment.currencyOriginal,
      amount: formatPlainAmount(payment.amountOriginal),
      reference: payment.referenceNumber,
      bankName: payment.bankName,
    ),
  );
}

/// Withdraws a pending report after asking, with an optional reason.
/// Returns whether the list should be read again - on success, and also
/// when the server says it is no longer pending (it was just reviewed).
Future<bool> withdrawPayment(
  BuildContext context,
  ClinicPaymentEntity payment,
) async {
  final l10n = AppLocalizations.of(context)!;
  final reason = TextEditingController();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final c = ColorManager.of(dialogContext);
      return AlertDialog(
        backgroundColor: c.cardBg,
        title: Text(
          l10n.withdrawReportTitle,
          style: TextStyle(fontFamily: FontHelper.fontFamily(dialogContext)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.withdrawReportBody,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(dialogContext),
                fontSize: 13.sp,
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            FormTextField(
              label: l10n.withdrawReasonOptional,
              controller: reason,
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: Text(l10n.withdrawReport),
          ),
        ],
      );
    },
  );
  final text = reason.text.trim();
  reason.dispose();
  if (confirmed != true || !context.mounted) return false;

  final result = await getIt<BillingRepository>().cancelPayment(
    payment.id,
    reason: text.isEmpty ? null : text,
  );
  if (!context.mounted) return true;
  result.fold(
    (e) => AppSnackbar.showError(
      context,
      title: l10n.errorTitle,
      message: NetworkExceptions.localizedMessage(context, e),
    ),
    (_) => AppSnackbar.showSuccess(context, title: l10n.reportWithdrawn),
  );
  return true;
}
