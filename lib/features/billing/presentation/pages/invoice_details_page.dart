import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/invoice_status_badge.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/payment_instructions_card.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key, required this.invoice});

  /// Snapshot at the time of navigation. Live state comes from the bloc
  /// via [BillingBloc.activeInvoice] once we select it on init.
  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<BillingBloc>()..add(BillingEvent.selectInvoice(invoice)),
      child: const _InvoiceDetailsView(),
    );
  }
}

class _InvoiceDetailsView extends StatelessWidget {
  const _InvoiceDetailsView();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.invoiceDetailsTitle),
      body: BlocBuilder<BillingBloc, BillingState>(
        builder: (context, state) {
          final invoice = state.activeInvoice;
          if (invoice == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final instructions = state.activeInstructions;

          // viewPadding.bottom = the actual system nav inset, even when
          // edge-to-edge mode lets the body paint behind the nav bar.
          // Without this the Approve/Reject buttons sit underneath it.
          final bottomInset = MediaQuery.of(context).viewPadding.bottom;
          return DentaRefresh(
            onRefresh: () => _refresh(context, invoice),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                20.w,
                16.h,
                20.w,
                24.h + bottomInset,
              ),
              children: [
                _Header(invoice: invoice),
                SizedBox(height: 16.h),
                _Summary(invoice: invoice),
                SizedBox(height: 16.h),
                if (invoice.status == InvoiceStatus.rejected &&
                    invoice.rejection != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _RejectionCard(rejection: invoice.rejection!),
                  ),
                if (invoice.awaitsProof && instructions != null) ...[
                  PaymentInstructionsCard(instructions: instructions),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    text: l10n.uploadPaymentProof,
                    onPressed: () => context.pushNamed(
                      AppRoutesNames.submitPaymentProof,
                      extra: invoice,
                    ),
                  ),
                ],
                if (invoice.awaitsAdmin) _UnderReviewCard(invoice: invoice),
                if (invoice.isPaid) _PaidCard(invoice: invoice),

                // Debug-only admin simulation panel. Lets us test the
                // full approve/reject flow without a separate admin app.
                // Stripped from release builds via kDebugMode.
                if (kDebugMode &&
                    (invoice.awaitsAdmin || invoice.awaitsProof)) ...[
                  SizedBox(height: 24.h),
                  _DebugAdminPanel(
                    invoiceId: invoice.id,
                    isProcessing: state.isProcessing,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  /// This screen is a projection of the invoice list, so a pull refetches the
  /// list and re-selects the same invoice out of it - that is what picks up an
  /// approval or a rejection that landed while the screen was open.
  Future<void> _refresh(BuildContext context, InvoiceEntity invoice) async {
    final bloc = context.read<BillingBloc>();
    final clinicId =
        bloc.state.clinicId ?? getIt<UserStorage>().getSelectedClinicId() ?? '';
    bloc.add(BillingEvent.loadInvoices(clinicId));
    await bloc.stream.settled((state) => !state.isLoading);
    for (final refreshed in bloc.state.invoices) {
      if (refreshed.id == invoice.id) {
        bloc.add(BillingEvent.selectInvoice(refreshed));
        break;
      }
    }
  }
}

class _DebugAdminPanel extends StatelessWidget {
  const _DebugAdminPanel({required this.invoiceId, required this.isProcessing});

  final String invoiceId;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.warning.withValues(alpha: 0.4),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bug_report_outlined,
                size: 16.w,
                color: ColorManager.warning,
              ),
              SizedBox(width: 6.w),
              Text(
                'Debug · simulate admin',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.warning,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Available in debug builds only — stands in for the real '
            'admin verification step.',
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: fontFamily,
              color: c.textTertiary,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isProcessing
                      ? null
                      : () {
                          context.read<BillingBloc>().add(
                            BillingEvent.adminApproveInvoice(invoiceId),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.success,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Approve',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: isProcessing ? null : () => _onReject(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.error,
                    side: BorderSide(color: ColorManager.error),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Reject',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onReject(BuildContext context) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (dialogCtx) {
        final c = ColorManager.of(dialogCtx);
        return AlertDialog(
          backgroundColor: c.cardBg,
          title: const Text('Reject reason (optional)'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: formOutlinedInput(
              dialogCtx,
              hintText: 'e.g. proof unreadable',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogCtx).pop(controller.text.trim()),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
    if (reason == null) return;
    if (!context.mounted) return;
    context.read<BillingBloc>().add(
      BillingEvent.adminRejectInvoice(
        invoiceId: invoiceId,
        reason: reason.isEmpty ? null : reason,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  invoice.number,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              InvoiceStatusBadge(status: invoice.status),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '${invoice.currency} ${invoice.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w800,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();
    final tier = invoice.planTier;
    final plan = tier == null ? null : SubscriptionPlans.getPlanByTier(tier);
    final cycle = invoice.billingCycle == BillingCycle.yearly
        ? l10n.billingYearly
        : l10n.billingMonthly;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          if (plan != null)
            _Row(label: l10n.plan, value: '${plan.name} · $cycle'),
          _Row(
            label: l10n.invoiceIssuedOn,
            value: dateFormat.format(invoice.issuedAt),
          ),
          _Row(
            label: l10n.invoiceDueOn,
            value: dateFormat.format(invoice.dueAt),
          ),
          if (invoice.activatesUntil != null)
            _Row(
              label: l10n.activatesUntil,
              value: dateFormat.format(invoice.activatesUntil!),
            ),
          if (invoice.isRenewal)
            _Row(label: l10n.invoiceType, value: l10n.renewal),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: fontFamily,
                color: c.textTertiary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnderReviewCard extends StatelessWidget {
  const _UnderReviewCard({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final proof = invoice.proof;
    final dateFormat = DateFormat.yMMMd().add_jm();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.infoBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.hourglass_top_rounded,
                color: ColorManager.info,
                size: 18.w,
              ),
              SizedBox(width: 8.w),
              Text(
                l10n.underReviewTitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.info,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            l10n.underReviewMessage,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: fontFamily,
              color: ColorManager.info,
              height: 1.4,
            ),
          ),
          if (proof != null) ...[
            SizedBox(height: 12.h),
            Text(
              '${l10n.transactionRefShort}: ${proof.referenceNumber}',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: fontFamily,
                color: ColorManager.info,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${l10n.submittedAt}: ${dateFormat.format(proof.submittedAt)}',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: fontFamily,
                color: ColorManager.info,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaidCard extends StatelessWidget {
  const _PaidCard({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final dateFormat = DateFormat.yMMMd();
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.successBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.successBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: ColorManager.success,
                size: 18.w,
              ),
              SizedBox(width: 8.w),
              Text(
                l10n.invoicePaidTitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.success,
                ),
              ),
            ],
          ),
          if (invoice.paidAt != null) ...[
            SizedBox(height: 6.h),
            Text(
              '${l10n.invoicePaidOn}: ${dateFormat.format(invoice.paidAt!)}',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: fontFamily,
                color: ColorManager.success,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RejectionCard extends StatelessWidget {
  const _RejectionCard({required this.rejection});

  final RejectionInfo rejection;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.errorBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.errorBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cancel_rounded, color: ColorManager.error, size: 18.w),
              SizedBox(width: 8.w),
              Text(
                l10n.invoiceRejectedTitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.error,
                ),
              ),
            ],
          ),
          if (rejection.reason != null && rejection.reason!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              rejection.reason!,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: fontFamily,
                color: ColorManager.error,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
