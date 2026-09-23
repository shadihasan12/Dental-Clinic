import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class BillingOverviewState {
  const BillingOverviewState({
    this.isLoading = true,
    this.statusError,
    this.status,
    this.usage,
    this.invoices = const [],
    this.payments = const [],
    this.wallet,
  });

  final bool isLoading;

  /// Why the status could not be read. The rest of the screen still renders
  /// whatever did load.
  final NetworkExceptions? statusError;
  final SubscriptionStatusEntity? status;
  final SubscriptionUsageEntity? usage;
  final List<InvoiceEntity> invoices;
  final List<ClinicPaymentEntity> payments;

  /// `credit_balance_usd`, preformatted.
  final String? wallet;

  /// A clinic has at most one open invoice at a time.
  InvoiceEntity? get openInvoice {
    for (final i in invoices) {
      if (i.isOpen && !i.isCreditNote) return i;
    }
    return null;
  }

  List<ClinicPaymentEntity> get pendingPayments =>
      payments.where((p) => p.isPending).toList();
}

/// Everything the subscription screen shows, loaded side by side: status,
/// usage, invoices, payments and the wallet.
@injectable
class BillingOverviewCubit extends Cubit<BillingOverviewState> {
  BillingOverviewCubit(this._subscriptions, this._billing)
      : super(const BillingOverviewState());

  final SubscriptionRepository _subscriptions;
  final BillingRepository _billing;

  Future<void> load() async {
    final statusF = _subscriptions.getStatus();
    final usageF = _subscriptions.getUsage();
    final invoicesF = _billing.getInvoices();
    final paymentsF = _billing.getPayments();
    final walletF = _billing.getWalletBalance();

    final status = await statusF;
    final usage = await usageF;
    final invoices = await invoicesF;
    final payments = await paymentsF;
    final wallet = await walletF;
    if (isClosed) return;

    emit(BillingOverviewState(
      isLoading: false,
      statusError: status.fold((e) => e, (_) => null),
      status: status.fold((_) => null, (s) => s),
      usage: usage.fold((_) => null, (u) => u),
      invoices: invoices.getOrElse(() => const []),
      payments: payments.getOrElse(() => const []),
      wallet: wallet.getOrElse(() => null),
    ));
  }
}
