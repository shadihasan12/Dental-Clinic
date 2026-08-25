import 'dart:io';

import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';

/// Strategy interface for "how to bill the dentist for this plan".
///
/// The app today has only [ManualPaymentProvider] (cash + local wallets,
/// proof uploaded by hand). Stripe, fawry, etc. become new implementations
/// of this interface — the bloc + UI shell stay the same, the provider
/// decides what the "Pay" screen looks like.
///
/// App Store policy note: never build a provider here that *initiates an
/// external charge from a button in the app for the IAP-eligible product*.
/// Use this interface for off-app/manual flows, web checkout, or in-app
/// purchases via the platform billing — not direct credit-card capture.
abstract class PaymentProvider {
  PaymentProviderKind get kind;

  /// Create an invoice for the given plan + cycle. The returned invoice
  /// should already be persisted by the provider's data source so the bloc
  /// can immediately surface it on the list.
  Future<InvoiceEntity> createInvoice({
    required String clinicId,
    required SubscriptionPlanEntity plan,
    required BillingCycle cycle,
    required bool isRenewal,
  });

  /// What the dentist sees while paying. For manual providers this is
  /// the list of channels + the reference number. Other providers may
  /// surface a checkout URL or a native widget; in those cases
  /// [PaymentInstructions.channels] would be empty and the UI would
  /// branch on [kind].
  PaymentInstructions instructionsFor(InvoiceEntity invoice);

  /// Attach a payment proof. Only meaningful for providers that don't
  /// confirm payment automatically (i.e. manual). For online providers
  /// this can throw [UnsupportedError].
  Future<InvoiceEntity> submitProof({
    required String invoiceId,
    required File receipt,
    required String referenceNumber,
    required ManualPaymentMethod method,
    String? notes,
  });
}
