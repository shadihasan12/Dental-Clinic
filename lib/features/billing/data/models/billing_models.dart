import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';

// JSON -> entity for every billing response. Each parser is tolerant of a
// missing optional field - a screen with one blank value beats one that
// fails to open - but not of a missing id.

DateTime? _date(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());

double _double(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

int _int(dynamic value, [int fallback = 0]) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

String? _string(dynamic value) {
  if (value == null) return null;
  final text = value.toString();
  return text.isEmpty ? null : text;
}

List<Map<String, dynamic>> _maps(dynamic value) =>
    value is List ? value.whereType<Map<String, dynamic>>().toList() : const [];

abstract final class BillingLineModel {
  static BillingLineEntity fromJson(Map<String, dynamic> json) {
    return BillingLineEntity(
      kind: (json['kind'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      quantity: _int(json['quantity'], 1),
      unitPriceUsd: _double(json['unit_price_usd']),
      amountUsd: _double(json['amount_usd']),
      periodStart: _date(json['period_start']),
      periodEnd: _date(json['period_end']),
    );
  }
}

abstract final class InvoiceModel {
  static InvoiceEntity fromJson(Map<String, dynamic> json) {
    return InvoiceEntity(
      id: json['id'] as String,
      number: (json['number'] ?? '').toString(),
      kind: (json['kind'] ?? 'charge').toString(),
      purpose: (json['purpose'] ?? '').toString(),
      status: InvoiceStatus.fromApi(json['status'] as String?),
      isCreditNote: json['is_credit_note'] as bool? ?? false,
      amountUsd: _double(json['amount_usd']),
      amountPaidUsd: _double(json['amount_paid_usd']),
      remainingUsd: _double(json['remaining_usd']),
      amounts: PriceModel.listFromJson(json['amounts']),
      items: _maps(json['items']).map(BillingLineModel.fromJson).toList(),
      dueAt: _date(json['due_at']),
      paidAt: _date(json['paid_at']),
      voidedAt: _date(json['voided_at']),
      createdAt: _date(json['created_at']),
    );
  }
}

abstract final class QuoteModel {
  static QuoteEntity fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>? ?? const {};
    return QuoteEntity(
      kind: (json['kind'] ?? '').toString(),
      canRequest: json['can_request'] as bool? ?? false,
      reason: _string(json['reason']),
      planName: (plan['name'] ?? '').toString(),
      planVersionId: (plan['version_id'] ?? '').toString(),
      billingPeriod: BillingPeriod.fromApi(json['billing_period'] as String?),
      durationQuantity: _int(json['duration_quantity'], 1),
      periodStart: _date(json['period_start']),
      periodEnd: _date(json['period_end']),
      paymentPurpose: _string(json['payment_purpose']),
      isCredit: json['is_credit'] as bool? ?? false,
      amountUsd: _double(json['amount_usd']),
      amounts: PriceModel.listFromJson(json['amounts']),
      lines: _maps(json['lines']).map(BillingLineModel.fromJson).toList(),
      blockers: _maps(json['blockers'])
          .map(
            (b) => QuoteBlockerEntity(
              limit: (b['limit'] ?? '').toString(),
              allowed: _int(b['allowed']),
              current: _int(b['current']),
              excess: _int(b['excess']),
              message: (b['message'] ?? '').toString(),
            ),
          )
          .toList(),
      startsLater: json['starts_later'] as bool? ?? false,
      addons: _maps(json['addons'])
          .map(
            (a) => QuoteAddonEntity(
              planId: _string(a['plan_id']),
              versionId: (a['version_id'] ?? '').toString(),
              name: (a['name'] ?? '').toString(),
              quantity: _int(a['quantity']),
              unitPriceUsd: a['unit_price_usd'] == null
                  ? null
                  : _double(a['unit_price_usd']),
              amountUsd: _double(a['amount_usd']),
            ),
          )
          .toList(),
    );
  }
}

abstract final class AddonModel {
  static AddonEntity fromJson(Map<String, dynamic> json) {
    return AddonEntity(
      planId: (json['plan_id'] ?? '').toString(),
      versionId: json['version_id'] as String,
      slug: (json['slug'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: _string(json['description']),
      limit: (json['limit'] ?? '').toString(),
      unitValue: _int(json['unit_value'], 1),
      priceMonthly: PriceModel.listFromJson(json['price_monthly']),
      priceYearly: PriceModel.listFromJson(json['price_yearly']),
      priceMonthlyUsd: _double(json['price_monthly_usd']),
      priceYearlyUsd: _double(json['price_yearly_usd']),
      ownedUnits: _int(json['owned_units']),
      nextCycleUnits: json['next_cycle_units'] == null
          ? null
          : _int(json['next_cycle_units']),
      canBuy: json['can_buy'] as bool? ?? false,
      reason: _string(json['reason']),
    );
  }
}

abstract final class PaymentMethodModel {
  static PaymentMethodEntity fromJson(Map<String, dynamic> json) {
    return PaymentMethodEntity(
      method: (json['method'] ?? '').toString(),
      name: (json['name'] ?? json['method'] ?? '').toString(),
      requiresReference: json['requires_reference'] as bool? ?? true,
      accounts: _maps(json['accounts'])
          .map(
            (a) => PaymentAccountEntity(
              id: a['id'] as String,
              accountName: (a['account_name'] ?? '').toString(),
              accountNumber: (a['account_number'] ?? '').toString(),
              currency: (a['currency'] ?? '').toString(),
              currencyName: (a['currency_name'] ?? a['currency'] ?? '')
                  .toString(),
              instructions: _string(a['instructions']),
            ),
          )
          .toList(),
    );
  }
}

abstract final class ClinicPaymentModel {
  static ClinicPaymentEntity fromJson(Map<String, dynamic> json) {
    return ClinicPaymentEntity(
      id: json['id'] as String,
      kind: (json['kind'] ?? 'payment').toString(),
      method: (json['method'] ?? '').toString(),
      referenceNumber: (json['reference_number'] ?? '').toString(),
      amountOriginal: _double(json['amount_original']),
      currencyOriginal: (json['currency_original'] ?? '').toString(),
      amountUsd: _double(json['amount_usd']),
      exchangeRate:
          json['exchange_rate'] == null ? null : _double(json['exchange_rate']),
      status: ClinicPaymentStatus.fromApi(json['status'] as String?),
      paymentAccountId: _string(json['payment_account_id']),
      bankName: _string(json['bank_name']),
      paidAt: _date(json['paid_at']),
      notes: _string(json['notes']),
      rejectionReason: _string(json['rejection_reason']),
      cancellationReason: _string(json['cancellation_reason']),
      attachments: _maps(json['attachments'])
          .where((a) => _string(a['view']) != null)
          .map(
            (a) => PaymentAttachmentEntity(
              id: (a['id'] ?? '').toString(),
              viewUrl: a['view'].toString(),
              downloadUrl: _string(a['download']),
            ),
          )
          .toList(),
    );
  }
}

abstract final class PaymentReceiptModel {
  static PaymentReceiptEntity fromJson(Map<String, dynamic> json) {
    return PaymentReceiptEntity(
      id: json['id'] as String,
      filename:
          (json['formatted_filename'] ?? json['filename'] ?? '').toString(),
      mimeType: (json['mime_type'] ?? '').toString(),
      url: _string(json['url']),
    );
  }
}

abstract final class SubscriptionPeriodModel {
  static SubscriptionPeriodEntity fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>? ?? const {};
    return SubscriptionPeriodEntity(
      id: json['id'] as String,
      kind: (json['kind'] ?? 'paid').toString(),
      endReason: PeriodEndReason.fromApi(_string(json['ended_because'])),
      creditUsd:
          json['credit_usd'] == null ? null : _double(json['credit_usd']),
      status: (json['status'] ?? '').toString(),
      planName: (plan['name'] ?? '').toString(),
      billingPeriod: BillingPeriod.fromApi(json['billing_period'] as String?),
      durationQuantity: _int(json['duration_quantity'], 1),
      startsAt: _date(json['starts_at']),
      endsAt: _date(json['ends_at']),
      priceUsd: _double(json['price_usd']),
      canceledAt: _date(json['canceled_at']),
    );
  }
}

abstract final class PlanFeaturesModel {
  static PlanFeaturesEntity fromJson(Map<String, dynamic> json) {
    return PlanFeaturesEntity(
      features: _groups(json['features']),
      limits: _groups(json['limits']),
      groupNames: {
        if (json['group_names'] is Map)
          for (final e in (json['group_names'] as Map).entries)
            if (e.value != null) e.key.toString(): e.value.toString(),
      },
    );
  }

  /// `{ "Group": [ {...}, ... ] }`, each group ordered by `sort_order`.
  static Map<String, List<PlanFeatureEntity>> _groups(dynamic json) {
    if (json is! Map) return const {};
    final result = <String, List<PlanFeatureEntity>>{};
    json.forEach((group, entries) {
      final list = _maps(entries)
          .map(
            (e) => PlanFeatureEntity(
              slug: (e['slug'] ?? '').toString(),
              name: (e['name'] ?? '').toString(),
              description: _string(e['description']),
              isTrialFeature: e['is_trial_feature'] as bool? ?? true,
              sortOrder: _int(e['sort_order']),
              limitValue: _string(e['limit_value']),
            ),
          )
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      if (list.isNotEmpty) result[group.toString()] = list;
    });
    return result;
  }
}
