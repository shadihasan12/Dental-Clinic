import 'package:flutter/material.dart';

/// Treatment types available in the clinic
enum TreatmentType {
  consultation('Consultation', Icons.medical_services_outlined),
  cleaning('Cleaning', Icons.cleaning_services_outlined),
  filling('Filling', Icons.format_color_fill_outlined),
  extraction('Extraction', Icons.remove_circle_outline),
  rootCanal('Root Canal', Icons.settings_outlined),
  crown('Crown', Icons.star_outline),
  xray('X-Ray', Icons.camera_alt_outlined),
  whitening('Whitening', Icons.wb_sunny_outlined),
  braces('Braces', Icons.straighten_outlined),
  implant('Implant', Icons.add_box_outlined),
  veneer('Veneer', Icons.layers_outlined);

  final String label;
  final IconData icon;
  const TreatmentType(this.label, this.icon);
}

/// Represents a single treatment item within a case
class TreatmentItem {
  final String id;
  final String description;
  final List<String> treatmentTypes;
  final List<String> selectedTeeth;
  final List<String> attachments;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isDone;
  /// Raw notes from the API: [{note: '...', date: '2026-03-12'}, ...]
  final List<Map<String, String>> notes;

  const TreatmentItem({
    required this.id,
    required this.description,
    this.treatmentTypes = const [],
    this.selectedTeeth = const [],
    this.attachments = const [],
    required this.createdAt,
    this.completedAt,
    this.isDone = false,
    this.notes = const [],
  });

  TreatmentItem copyWith({
    String? id,
    String? description,
    List<String>? treatmentTypes,
    List<String>? selectedTeeth,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isDone,
    List<Map<String, String>>? notes,
  }) {
    return TreatmentItem(
      id: id ?? this.id,
      description: description ?? this.description,
      treatmentTypes: treatmentTypes ?? this.treatmentTypes,
      selectedTeeth: selectedTeeth ?? this.selectedTeeth,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      isDone: isDone ?? this.isDone,
      notes: notes ?? this.notes,
    );
  }
}

/// Represents a dental case containing multiple treatment items
class DentalCase {
  final String id;
  final String patientId;
  final String patientName;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String status; // 'In Progress', 'Done', 'Pending'
  final double totalCost;
  final double labFees;
  final double paidAmount;
  final String? totalCostCurrencyId;
  final String? labFeesCurrencyId;
  final List<TreatmentItem> treatmentItems;

  const DentalCase({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.totalCost,
    this.labFees = 0,
    required this.paidAmount,
    this.totalCostCurrencyId,
    this.labFeesCurrencyId,
    this.treatmentItems = const [],
  });

  factory DentalCase.fromJson(Map<String, dynamic> json, {String patientName = ''}) {
    return DentalCase(
      id: json['id'] as String,
      patientId: json['patient_id'] as String? ?? '',
      patientName: patientName,
      title: json['title'] as String? ?? '',
      startDate: DateTime.parse(json['started_date'] as String),
      status: json['status'] as String,
      totalCost: (json['total_cost'] as num?)?.toDouble() ?? 0,
      labFees: (json['lab_fees'] as num?)?.toDouble() ?? 0,
      paidAmount: (json['paid_amount'] as num?)?.toDouble() ?? 0,
      totalCostCurrencyId: _parseCurrencyId(json, 'total_cost_currency'),
      labFeesCurrencyId: _parseCurrencyId(json, 'lab_fees_currency'),
    );
  }

  static String? _parseCurrencyId(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is Map<String, dynamic>) return value['id'] as String?;
    if (value is String) return value;
    return json['${key}_id'] as String?;
  }

  double get pendingAmount => totalCost - paidAmount;
  
  List<TreatmentItem> get pendingTreatments => 
      treatmentItems.where((t) => !t.isDone).toList();
  
  List<TreatmentItem> get completedTreatments => 
      treatmentItems.where((t) => t.isDone).toList();

  /// Groups completed treatments by completion date
  Map<DateTime, List<TreatmentItem>> get completedByDate {
    final completed = completedTreatments;
    final Map<DateTime, List<TreatmentItem>> grouped = {};
    
    for (final item in completed) {
      if (item.completedAt != null) {
        final dateKey = DateTime(
          item.completedAt!.year,
          item.completedAt!.month,
          item.completedAt!.day,
        );
        grouped.putIfAbsent(dateKey, () => []).add(item);
      }
    }
    
    // Sort by date descending (most recent first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    
    return Map.fromEntries(
      sortedKeys.map((key) => MapEntry(key, grouped[key]!)),
    );
  }

  DentalCase copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    double? totalCost,
    double? labFees,
    double? paidAmount,
    String? totalCostCurrencyId,
    String? labFeesCurrencyId,
    List<TreatmentItem>? treatmentItems,
  }) {
    return DentalCase(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      totalCost: totalCost ?? this.totalCost,
      labFees: labFees ?? this.labFees,
      paidAmount: paidAmount ?? this.paidAmount,
      totalCostCurrencyId: totalCostCurrencyId ?? this.totalCostCurrencyId,
      labFeesCurrencyId: labFeesCurrencyId ?? this.labFeesCurrencyId,
      treatmentItems: treatmentItems ?? this.treatmentItems,
    );
  }
}