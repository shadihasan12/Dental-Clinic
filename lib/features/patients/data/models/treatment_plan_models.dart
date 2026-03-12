import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart'
    as api;
import 'package:flutter/material.dart';

// ─── Treatment Status ───────────────────────────────────────────────
enum TreatmentPlanStatus { planned, inProgress, completed }

// ─── Treatment Type Definition ──────────────────────────────────────
class TreatmentTypeInfo {
  final String id;
  final String name;
  final IconData icon;
  final String categoryId;
  final String categoryName;

  const TreatmentTypeInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.categoryId,
    required this.categoryName,
  });
}

// ─── Category with its treatments ───────────────────────────────────
class TreatmentCategoryGroup {
  final String id;
  final String slug;
  final String name;
  final List<TreatmentTypeInfo> treatments;

  const TreatmentCategoryGroup({
    required this.id,
    this.slug = '',
    required this.name,
    required this.treatments,
  });

  bool get isGeneralCategory => slug.toLowerCase().contains('general');
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
      return 'Tooth $toothNumber → ${type.name}';
    }
    return type.name;
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
// MAPPING: CoreTreatment → TreatmentTypeInfo
// ═══════════════════════════════════════════════════════════════════

/// Maps a [CoreTreatment] from the API to [TreatmentTypeInfo].
TreatmentTypeInfo coreTreatmentToTypeInfo(api.CoreTreatment ct) {
  return TreatmentTypeInfo(
    id: ct.id,
    name: ct.name,
    icon: Icons.medical_services_outlined,
    categoryId: ct.category.id,
    categoryName: ct.category.name,
  );
}

/// Groups a list of [CoreTreatment] by category into [TreatmentCategoryGroup]s.
List<TreatmentCategoryGroup> mapCoreTreatments(
    List<api.CoreTreatment> treatments) {
  final grouped = <String, TreatmentCategoryGroup>{};

  for (final ct in treatments) {
    final info = coreTreatmentToTypeInfo(ct);
    final group = grouped.putIfAbsent(
      ct.category.id,
      () => TreatmentCategoryGroup(
        id: ct.category.id,
        slug: ct.category.slug,
        name: ct.category.name,
        treatments: [],
      ),
    );
    group.treatments.add(info);
  }

  return grouped.values.toList();
}

// ═══════════════════════════════════════════════════════════════════
// MOCK DATA
// ═══════════════════════════════════════════════════════════════════

class MockTreatmentTypes {
  static const _toothCategoryId = 'mock_tooth';
  static const _toothCategoryName = 'علاجات خاصة بالسن';
  static const _generalCategoryId = 'mock_general';
  static const _generalCategoryName = 'علاجات عامة';

  static const toothSpecific = [
    TreatmentTypeInfo(
      id: 'root_canal',
      name: 'علاج عصب',
      icon: Icons.healing,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'filling_composite',
      name: 'حشوة (كومبوزيت)',
      icon: Icons.circle,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'filling_amalgam',
      name: 'حشوة (أملغم)',
      icon: Icons.circle_outlined,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'crown',
      name: 'تاج',
      icon: Icons.shield,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'extraction',
      name: 'خلع',
      icon: Icons.arrow_upward,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'veneer',
      name: 'فينير',
      icon: Icons.auto_awesome,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'implant',
      name: 'زراعة',
      icon: Icons.push_pin,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'bridge',
      name: 'جسر',
      icon: Icons.join_full,
      categoryId: _toothCategoryId,
      categoryName: _toothCategoryName,
    ),
  ];

  static const general = [
    TreatmentTypeInfo(
      id: 'cleaning',
      name: 'تنظيف',
      icon: Icons.cleaning_services,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'checkup',
      name: 'فحص',
      icon: Icons.search,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'upper_braces',
      name: 'تقويم علوي معدني',
      icon: Icons.view_comfy_alt,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'lower_braces',
      name: 'تقويم سفلي معدني',
      icon: Icons.view_comfy_alt_outlined,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'gum_cleaning',
      name: 'تنظيف لثة',
      icon: Icons.water_drop_outlined,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'gum_trimming',
      name: 'قص لثة',
      icon: Icons.content_cut,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'whitening',
      name: 'تبييض',
      icon: Icons.light_mode,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
    TreatmentTypeInfo(
      id: 'xray',
      name: 'أشعة',
      icon: Icons.image,
      categoryId: _generalCategoryId,
      categoryName: _generalCategoryName,
    ),
  ];

  static List<TreatmentTypeInfo> get all => [...toothSpecific, ...general];

  static List<TreatmentCategoryGroup> get categories => [
        TreatmentCategoryGroup(
          id: _toothCategoryId,
          name: _toothCategoryName,
          treatments: toothSpecific,
        ),
        TreatmentCategoryGroup(
          id: _generalCategoryId,
          name: _generalCategoryName,
          treatments: general,
        ),
      ];
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
          type: MockTreatmentTypes.toothSpecific[0],
          toothNumber: '16',
          status: TreatmentPlanStatus.completed,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't2',
          type: MockTreatmentTypes.toothSpecific[3],
          toothNumber: '16',
          status: TreatmentPlanStatus.inProgress,
          visitNumber: 2,
        ),
        PlannedTreatment(
          id: 't3',
          type: MockTreatmentTypes.toothSpecific[1],
          toothNumber: '24',
          status: TreatmentPlanStatus.planned,
        ),
        PlannedTreatment(
          id: 't4',
          type: MockTreatmentTypes.toothSpecific[4],
          toothNumber: '48',
          status: TreatmentPlanStatus.planned,
        ),
        PlannedTreatment(
          id: 't5',
          type: MockTreatmentTypes.general[0],
          status: TreatmentPlanStatus.completed,
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          visitNumber: 1,
        ),
        PlannedTreatment(
          id: 't6',
          type: MockTreatmentTypes.general[7],
          status: TreatmentPlanStatus.planned,
        ),
      ],
    );
  }
}
