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
  final double defaultCost;

  const TreatmentTypeInfo({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.category,
    this.defaultCost = 0,
  });
}

// ─── Planned Treatment (a single item in the plan) ──────────────────
class PlannedTreatment {
  final String id;
  final TreatmentTypeInfo type;
  final String? toothNumber; // null = general treatment
  TreatmentPlanStatus status;
  double cost;
  String notes;
  DateTime? completedDate;
  int? visitNumber;

  PlannedTreatment({
    required this.id,
    required this.type,
    this.toothNumber,
    this.status = TreatmentPlanStatus.planned,
    this.cost = 0,
    this.notes = '',
    this.completedDate,
    this.visitNumber,
  });

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

  TreatmentPlan({
    required this.id,
    required this.patientName,
    required this.treatments,
    required this.createdAt,
  });

  List<PlannedTreatment> get planned =>
      treatments.where((t) => t.status == TreatmentPlanStatus.planned).toList();

  List<PlannedTreatment> get completed => treatments
      .where((t) => t.status == TreatmentPlanStatus.completed)
      .toList();

  List<PlannedTreatment> get inProgress => treatments
      .where((t) => t.status == TreatmentPlanStatus.inProgress)
      .toList();

  double get totalCost => treatments.fold(0, (sum, t) => sum + t.cost);

  double get completedCost =>
      completed.fold(0, (sum, t) => sum + t.cost);

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
      defaultCost: 500,
    ),
    TreatmentTypeInfo(
      id: 'filling_composite',
      nameEn: 'Filling (Composite)',
      nameAr: 'حشوة (كومبوزيت)',
      icon: Icons.circle,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 200,
    ),
    TreatmentTypeInfo(
      id: 'filling_amalgam',
      nameEn: 'Filling (Amalgam)',
      nameAr: 'حشوة (أملغم)',
      icon: Icons.circle_outlined,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 150,
    ),
    TreatmentTypeInfo(
      id: 'crown',
      nameEn: 'Crown',
      nameAr: 'تاج',
      icon: Icons.shield,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 800,
    ),
    TreatmentTypeInfo(
      id: 'extraction',
      nameEn: 'Extraction',
      nameAr: 'خلع',
      icon: Icons.arrow_upward,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 300,
    ),
    TreatmentTypeInfo(
      id: 'veneer',
      nameEn: 'Veneer',
      nameAr: 'فينير',
      icon: Icons.auto_awesome,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 1000,
    ),
    TreatmentTypeInfo(
      id: 'implant',
      nameEn: 'Implant',
      nameAr: 'زراعة',
      icon: Icons.push_pin,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 2000,
    ),
    TreatmentTypeInfo(
      id: 'bridge',
      nameEn: 'Bridge',
      nameAr: 'جسر',
      icon: Icons.join_full,
      category: TreatmentCategory.toothSpecific,
      defaultCost: 1200,
    ),
  ];

  static const general = [
    TreatmentTypeInfo(
      id: 'cleaning',
      nameEn: 'Cleaning',
      nameAr: 'تنظيف',
      icon: Icons.cleaning_services,
      category: TreatmentCategory.general,
      defaultCost: 100,
    ),
    TreatmentTypeInfo(
      id: 'checkup',
      nameEn: 'Checkup',
      nameAr: 'فحص',
      icon: Icons.search,
      category: TreatmentCategory.general,
      defaultCost: 50,
    ),
    TreatmentTypeInfo(
      id: 'upper_braces',
      nameEn: 'Upper Metal Braces',
      nameAr: 'تقويم علوي معدني',
      icon: Icons.view_comfy_alt,
      category: TreatmentCategory.general,
      defaultCost: 3000,
    ),
    TreatmentTypeInfo(
      id: 'lower_braces',
      nameEn: 'Lower Metal Braces',
      nameAr: 'تقويم سفلي معدني',
      icon: Icons.view_comfy_alt_outlined,
      category: TreatmentCategory.general,
      defaultCost: 3000,
    ),
    TreatmentTypeInfo(
      id: 'gum_cleaning',
      nameEn: 'Gum Cleaning',
      nameAr: 'تنظيف لثة',
      icon: Icons.water_drop_outlined,
      category: TreatmentCategory.general,
      defaultCost: 150,
    ),
    TreatmentTypeInfo(
      id: 'gum_trimming',
      nameEn: 'Gum Trimming',
      nameAr: 'قص لثة',
      icon: Icons.content_cut,
      category: TreatmentCategory.general,
      defaultCost: 200,
    ),
    TreatmentTypeInfo(
      id: 'whitening',
      nameEn: 'Whitening',
      nameAr: 'تبييض',
      icon: Icons.light_mode,
      category: TreatmentCategory.general,
      defaultCost: 500,
    ),
    TreatmentTypeInfo(
      id: 'xray',
      nameEn: 'X-Ray',
      nameAr: 'أشعة',
      icon: Icons.image,
      category: TreatmentCategory.general,
      defaultCost: 80,
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
          cost: 500,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't2',
          type: MockTreatmentTypes.toothSpecific[3], // Crown
          toothNumber: '16',
          status: TreatmentPlanStatus.inProgress,
          cost: 800,
          visitNumber: 2,
        ),
        PlannedTreatment(
          id: 't3',
          type: MockTreatmentTypes.toothSpecific[1], // Filling Composite
          toothNumber: '24',
          status: TreatmentPlanStatus.planned,
          cost: 200,
        ),
        PlannedTreatment(
          id: 't4',
          type: MockTreatmentTypes.toothSpecific[4], // Extraction
          toothNumber: '48',
          status: TreatmentPlanStatus.planned,
          cost: 300,
        ),
        PlannedTreatment(
          id: 't5',
          type: MockTreatmentTypes.general[0], // Cleaning
          status: TreatmentPlanStatus.completed,
          cost: 100,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't6',
          type: MockTreatmentTypes.general[7], // X-Ray
          status: TreatmentPlanStatus.planned,
          cost: 80,
        ),
      ],
    );
  }
}

