import 'dart:async';
import 'dart:math' as math;

import 'package:dental_clinic_app/features/billing/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

/// In-memory invoice store. Replace with a real remote data source once
/// the backend is wired up. The interface is intentionally small so the
/// swap is mechanical — nothing outside the data layer touches these
/// models.
abstract class BillingLocalDataSource {
  Future<List<InvoiceModel>> listInvoices(String clinicId);
  Future<InvoiceModel> getInvoice(String id);
  Future<InvoiceModel> saveInvoice(InvoiceModel invoice);

  /// Subscribe to mutations. The billing bloc listens to this to refresh
  /// the list when an invoice transitions (e.g. proof submitted).
  Stream<InvoiceModel> get changes;
}

@LazySingleton(as: BillingLocalDataSource)
class InMemoryBillingDataSource implements BillingLocalDataSource {
  final Map<String, InvoiceModel> _store = {};
  final StreamController<InvoiceModel> _changes =
      StreamController.broadcast();
  final math.Random _rng = math.Random();

  @override
  Stream<InvoiceModel> get changes => _changes.stream;

  @override
  Future<List<InvoiceModel>> listInvoices(String clinicId) async {
    final list = _store.values
        .where((i) => i.clinicId == clinicId)
        .toList()
      ..sort((a, b) => b.issuedAt.compareTo(a.issuedAt));
    return list;
  }

  @override
  Future<InvoiceModel> getInvoice(String id) async {
    final found = _store[id];
    if (found == null) {
      throw StateError('Invoice $id not found');
    }
    return found;
  }

  @override
  Future<InvoiceModel> saveInvoice(InvoiceModel invoice) async {
    _store[invoice.id] = invoice;
    _changes.add(invoice);
    return invoice;
  }

  /// Used by the manual provider to mint a deterministic-looking invoice
  /// number such as `INV-2026-04-A1B2C3`. Not a security primitive.
  String generateInvoiceNumber(DateTime now) {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final suffix = List.generate(
      6,
      (_) => chars[_rng.nextInt(chars.length)],
    ).join();
    final yyyy = now.year.toString().padLeft(4, '0');
    final mm = now.month.toString().padLeft(2, '0');
    return 'INV-$yyyy$mm-$suffix';
  }
}
