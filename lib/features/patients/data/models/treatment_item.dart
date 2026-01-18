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
  implant('Implant', Icons.add_box_outlined);

  final String label;
  final IconData icon;
  const TreatmentType(this.label, this.icon);
}

/// Represents a single treatment item within a case
class TreatmentItem {
  final String id;
  final String description;
  final List<TreatmentType> treatmentTypes;
  final List<int> selectedTeeth;
  final List<String> attachments;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isDone;

  const TreatmentItem({
    required this.id,
    required this.description,
    this.treatmentTypes = const [],
    this.selectedTeeth = const [],
    this.attachments = const [],
    required this.createdAt,
    this.completedAt,
    this.isDone = false,
  });

  TreatmentItem copyWith({
    String? id,
    String? description,
    List<TreatmentType>? treatmentTypes,
    List<int>? selectedTeeth,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isDone,
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
  final double paidAmount;
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
    required this.paidAmount,
    this.treatmentItems = const [],
  });

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
    double? paidAmount,
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
      paidAmount: paidAmount ?? this.paidAmount,
      treatmentItems: treatmentItems ?? this.treatmentItems,
    );
  }
}