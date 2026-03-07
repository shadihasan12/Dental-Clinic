import 'package:flutter/material.dart';

// ─── Treatment Status ───────────────────────────────────────────────
enum TreatmentPlanStatus { planned, inProgress, completed }

// ─── Treatment Category ─────────────────────────────────────────────
enum TreatmentCategory { toothSpecific, general }

// ─── Treatment Type Definition ──────────────────────────────────────
class TreatmentTypeInfo {
  final String id;
  final String nameEn;
  final String nameAr;
  final IconData icon;
  final TreatmentCategory category;

  const TreatmentTypeInfo({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.category,
  });
}

// ─── Visit Note (a single note entry for a treatment) ───────────────
class VisitNote {
  final DateTime date;
  final String text;

  VisitNote({required this.date, required this.text});
}

// ─── Planned Treatment (a single item in the plan) ──────────────────
class PlannedTreatment {
  final String id;
  final TreatmentTypeInfo type;
  final String? toothNumber; // null = general treatment
  TreatmentPlanStatus status;
  String notes;
  DateTime? completedDate;
  int? visitNumber;
  final List<VisitNote> visitNotes;

  PlannedTreatment({
    required this.id,
    required this.type,
    this.toothNumber,
    this.status = TreatmentPlanStatus.planned,
    this.notes = '',
    this.completedDate,
    this.visitNumber,
    List<VisitNote>? visitNotes,
  }) : visitNotes = visitNotes ?? [];

  bool get isToothSpecific => toothNumber != null;

  String get displayLabel {
    if (toothNumber != null) {
      return 'Tooth $toothNumber → ${type.nameEn}';
    }
    return type.nameEn;
  }

  String get displayLabelAr {
    if (toothNumber != null) {
      return 'سن $toothNumber → ${type.nameAr}';
    }
    return type.nameAr;
  }
}

// ─── Treatment Plan (full plan for a patient) ───────────────────────
class TreatmentPlan {
  final String id;
  final String patientName;
  final List<PlannedTreatment> treatments;
  final DateTime createdAt;
  double totalCost;
  double labFees;
  double paid;

  TreatmentPlan({
    required this.id,
    required this.patientName,
    required this.treatments,
    required this.createdAt,
    this.totalCost = 0,
    this.labFees = 0,
    this.paid = 0,
  });

  double get grandTotal => totalCost + labFees;
  double get pending => grandTotal - paid;

  List<PlannedTreatment> get planned =>
      treatments.where((t) => t.status == TreatmentPlanStatus.planned).toList();

  List<PlannedTreatment> get completed => treatments
      .where((t) => t.status == TreatmentPlanStatus.completed)
      .toList();

  List<PlannedTreatment> get inProgress => treatments
      .where((t) => t.status == TreatmentPlanStatus.inProgress)
      .toList();

  /// Group tooth-specific treatments by tooth number
  Map<String, List<PlannedTreatment>> get byTooth {
    final map = <String, List<PlannedTreatment>>{};
    for (final t in treatments.where((t) => t.isToothSpecific)) {
      map.putIfAbsent(t.toothNumber!, () => []).add(t);
    }
    return map;
  }

  List<PlannedTreatment> get generalTreatments =>
      treatments.where((t) => !t.isToothSpecific).toList();
}

// ═══════════════════════════════════════════════════════════════════
// MOCK DATA
// ═══════════════════════════════════════════════════════════════════

// ─── All Treatment Types ────────────────────────────────────────────
class MockTreatmentTypes {
  static const toothSpecific = [
    TreatmentTypeInfo(
      id: 'root_canal',
      nameEn: 'Root Canal',
      nameAr: 'علاج عصب',
      icon: Icons.healing,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'filling_composite',
      nameEn: 'Filling (Composite)',
      nameAr: 'حشوة (كومبوزيت)',
      icon: Icons.circle,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'filling_amalgam',
      nameEn: 'Filling (Amalgam)',
      nameAr: 'حشوة (أملغم)',
      icon: Icons.circle_outlined,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'crown',
      nameEn: 'Crown',
      nameAr: 'تاج',
      icon: Icons.shield,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'extraction',
      nameEn: 'Extraction',
      nameAr: 'خلع',
      icon: Icons.arrow_upward,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'veneer',
      nameEn: 'Veneer',
      nameAr: 'فينير',
      icon: Icons.auto_awesome,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'implant',
      nameEn: 'Implant',
      nameAr: 'زراعة',
      icon: Icons.push_pin,
      category: TreatmentCategory.toothSpecific,
    ),
    TreatmentTypeInfo(
      id: 'bridge',
      nameEn: 'Bridge',
      nameAr: 'جسر',
      icon: Icons.join_full,
      category: TreatmentCategory.toothSpecific,
    ),
  ];

  static const general = [
    TreatmentTypeInfo(
      id: 'cleaning',
      nameEn: 'Cleaning',
      nameAr: 'تنظيف',
      icon: Icons.cleaning_services,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'checkup',
      nameEn: 'Checkup',
      nameAr: 'فحص',
      icon: Icons.search,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'upper_braces',
      nameEn: 'Upper Metal Braces',
      nameAr: 'تقويم علوي معدني',
      icon: Icons.view_comfy_alt,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'lower_braces',
      nameEn: 'Lower Metal Braces',
      nameAr: 'تقويم سفلي معدني',
      icon: Icons.view_comfy_alt_outlined,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'gum_cleaning',
      nameEn: 'Gum Cleaning',
      nameAr: 'تنظيف لثة',
      icon: Icons.water_drop_outlined,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'gum_trimming',
      nameEn: 'Gum Trimming',
      nameAr: 'قص لثة',
      icon: Icons.content_cut,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'whitening',
      nameEn: 'Whitening',
      nameAr: 'تبييض',
      icon: Icons.light_mode,
      category: TreatmentCategory.general,
    ),
    TreatmentTypeInfo(
      id: 'xray',
      nameEn: 'X-Ray',
      nameAr: 'أشعة',
      icon: Icons.image,
      category: TreatmentCategory.general,
    ),
  ];

  static List<TreatmentTypeInfo> get all => [...toothSpecific, ...general];
}

// ─── Mock Data ────────────────────────────────────────────────────────
class MockData {
  static TreatmentPlan samplePlan() {
    return TreatmentPlan(
      id: 'plan_001',
      patientName: 'Ahmed Mohammed',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      treatments: [
        PlannedTreatment(
          id: 't1',
          type: MockTreatmentTypes.toothSpecific[0], // Root Canal
          toothNumber: '16',
          status: TreatmentPlanStatus.completed,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't2',
          type: MockTreatmentTypes.toothSpecific[3], // Crown
          toothNumber: '16',
          status: TreatmentPlanStatus.inProgress,
          visitNumber: 2,
        ),
        PlannedTreatment(
          id: 't3',
          type: MockTreatmentTypes.toothSpecific[1], // Filling Composite
          toothNumber: '24',
          status: TreatmentPlanStatus.planned,
        ),
        PlannedTreatment(
          id: 't4',
          type: MockTreatmentTypes.toothSpecific[4], // Extraction
          toothNumber: '48',
          status: TreatmentPlanStatus.planned,
        ),
        PlannedTreatment(
          id: 't5',
          type: MockTreatmentTypes.general[0], // Cleaning
          status: TreatmentPlanStatus.completed,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't6',
          type: MockTreatmentTypes.general[7], // X-Ray
          status: TreatmentPlanStatus.planned,
        ),
      ],
    );
  }
}
