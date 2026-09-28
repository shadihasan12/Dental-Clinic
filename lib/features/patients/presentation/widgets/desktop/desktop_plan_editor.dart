import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/cost_fields.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/tooth_names.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_type_grid.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';

/// Desktop pieces of the new-treatment-plan screen.
///
/// A phone has to split writing a plan across a sheet for the costs and a
/// second page for the tooth chart. A desktop window has the room to show
/// all of it at once, so here nothing opens: the costs are typed into the
/// plan card itself, and the chart, the treatments for the tapped tooth and
/// the plan so far sit side by side on the one page.

typedef CostChanged =
    void Function(
      double totalCost,
      double labFees,
      CurrencyEntity? totalCostCurrency,
      CurrencyEntity? labFeesCurrency,
    );

// ═══════════════════════════════════════════════════════════════
// COST CARD
// ═══════════════════════════════════════════════════════════════

/// The blue plan card, with the cost form living inside it.
///
/// The figures at the top follow the fields as they are typed, so there is
/// no edit mode and no save step for the costs - they go out with the plan.
class DesktopPlanCostCard extends StatelessWidget {
  const DesktopPlanCostCard({
    super.key,
    required this.plan,
    required this.totalCostCurrency,
    required this.labFeesCurrency,
    required this.onCostChanged,
  });

  final TreatmentPlan plan;
  final CurrencyEntity? totalCostCurrency;
  final CurrencyEntity? labFeesCurrency;
  final CostChanged onCostChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final total = plan.totalCost;
    final paid = plan.paid;
    final pending = (total - paid).clamp(0, double.infinity).toDouble();
    final code = totalCostCurrency?.currencyCode;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorManager.primary, ColorManager.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.treatmentPlan,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        color: ColorManager.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // The currency is whatever was picked, not a dollar sign:
                    // a plan priced in SYP read as USD is off by three orders
                    // of magnitude.
                    _money(
                      value: total,
                      code: code,
                      fontFamily: fontFamily,
                      size: 32,
                      codeSize: 15,
                    ),
                    if (plan.labFees > 0) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.labFees}: ${plan.labFees.toStringAsFixed(0)}'
                        ' ${labFeesCurrency?.currencyCode ?? code ?? ''}',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _pill(l10n.paidLabel, paid, code, fontFamily),
              const SizedBox(width: 12),
              _pill(l10n.pendingLabel, pending, code, fontFamily),
            ],
          ),
          const SizedBox(height: 18),
          Divider(height: 1, color: ColorManager.white.withValues(alpha: 0.22)),
          const SizedBox(height: 16),
          CostFields(
            initialTotalCost: plan.totalCost,
            initialLabFees: plan.labFees,
            initialTotalCostCurrency: totalCostCurrency,
            initialLabFeesCurrency: labFeesCurrency,
            direction: Axis.horizontal,
            onPrimary: true,
            onChanged: onCostChanged,
          ),
        ],
      ),
    );
  }

  Widget _money({
    required double value,
    required String? code,
    required String fontFamily,
    required double size,
    required double codeSize,
  }) {
    return Text.rich(
      TextSpan(
        text: value.toStringAsFixed(0),
        children: [
          if (code != null)
            TextSpan(
              text: ' $code',
              style: TextStyle(
                fontSize: codeSize,
                fontWeight: FontWeight.w600,
                color: ColorManager.white.withValues(alpha: 0.75),
                letterSpacing: 0,
              ),
            ),
        ],
      ),
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: ColorManager.white,
        letterSpacing: size > 20 ? -0.8 : 0,
      ),
    );
  }

  Widget _pill(String label, double value, String? code, String fontFamily) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ColorManager.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 11,
              color: ColorManager.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          _money(
            value: value,
            code: code,
            fontFamily: fontFamily,
            size: 18,
            codeSize: 10,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PLAN BUILDER
// ═══════════════════════════════════════════════════════════════

/// Tooth chart on one side; on the other, the treatments for whichever tooth
/// was tapped, with the plan so far underneath.
///
/// Every tile is a toggle straight onto the plan - tap to add, tap again to
/// take it off - so building a plan is one click per treatment, with no
/// sheet to confirm and no page to come back from.
class DesktopPlanBuilder extends StatefulWidget {
  const DesktopPlanBuilder({
    super.key,
    required this.categories,
    required this.teeth,
    required this.treatments,
    required this.onAdd,
    required this.onRemove,
  });

  /// Tooth-level treatments first, then the general categories - the order
  /// the page sorts them into.
  final List<TreatmentCategoryGroup> categories;
  final List<Tooth> teeth;
  final List<PlannedTreatment> treatments;
  final ValueChanged<PlannedTreatment> onAdd;
  final ValueChanged<PlannedTreatment> onRemove;

  @override
  State<DesktopPlanBuilder> createState() => _DesktopPlanBuilderState();
}

class _DesktopPlanBuilderState extends State<DesktopPlanBuilder> {
  /// Which category the picker shows; 0 is the tooth-level one.
  int _tab = 0;

  /// FDI code of the tooth being worked on.
  String? _toothCode;
  int _idCounter = 0;

  List<Tooth> get _chartTeeth =>
      widget.teeth.isNotEmpty ? widget.teeth : ToothChart.fallbackTeeth();

  String _idToCode(String id) =>
      _chartTeeth.where((t) => t.id == id).firstOrNull?.universalCode ?? id;

  String? _codeToId(String? code) => code == null
      ? null
      : _chartTeeth.where((t) => t.universalCode == code).firstOrNull?.id;

  List<String> get _markedToothIds {
    final codes = widget.treatments
        .map((t) => t.toothNumber)
        .whereType<String>()
        .toSet();
    return _chartTeeth
        .where((t) => codes.contains(t.universalCode))
        .map((t) => t.id)
        .toList();
  }

  void _focusTooth(String code) {
    setState(() {
      _toothCode = code;
      _tab = 0;
    });
  }

  /// Adds the treatment to the plan, or takes it back off if it is already
  /// on it for this tooth ([toothCode] null for a general treatment).
  void _toggle(TreatmentTypeInfo type, String? toothCode) {
    final queued = widget.treatments
        .where((t) => t.toothNumber == toothCode && t.type.id == type.id)
        .firstOrNull;
    if (queued != null) {
      widget.onRemove(queued);
      return;
    }
    widget.onAdd(
      PlannedTreatment(
        id: 'new_${DateTime.now().microsecondsSinceEpoch}_${_idCounter++}',
        type: type,
        toothNumber: toothCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final picker = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _pickerCard(context),
            const SizedBox(height: 16),
            _planCard(context),
          ],
        );

        // A narrow window cannot hold the chart beside the picker; stack
        // them rather than squeeze the tiles.
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: _chartCard(context),
                ),
              ),
              const SizedBox(height: 16),
              picker,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 330, child: _chartCard(context)),
            const SizedBox(width: 16),
            Expanded(child: picker),
          ],
        );
      },
    );
  }

  // ── Chart ────────────────────────────────────────────────────

  Widget _chartCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return DesktopSectionCard(
      title: l10n.planTreatments,
      subtitle: l10n.tapToothToAddTreatments,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          ToothChart(
            teeth: _chartTeeth,
            selectedTeeth: _markedToothIds,
            focusedTooth: _codeToId(_tab == 0 ? _toothCode : null),
            onToothTap: (id) => _focusTooth(_idToCode(id)),
            aspectRatio: 0.62,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorManager.primary, width: 1.5),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                l10n.hasPlannedTreatment,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 11.5,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Picker ───────────────────────────────────────────────────

  Widget _pickerCard(BuildContext context) {
    final c = ColorManager.of(context);
    final categories = widget.categories;
    final tab = _tab < categories.length ? _tab : 0;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (categories.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: _tabs(context, categories, tab),
            ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: categories.isEmpty
                ? const SizedBox.shrink()
                : tab == 0
                ? _toothPicker(context, categories[0])
                : _generalPicker(categories[tab]),
          ),
        ],
      ),
    );
  }

  Widget _tabs(
    BuildContext context,
    List<TreatmentCategoryGroup> categories,
    int selected,
  ) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (var i = 0; i < categories.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: i == selected ? c.cardBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: i == selected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          i == 0
                              ? Icons.grid_view_rounded
                              : Icons.medical_services_outlined,
                          size: 15,
                          color: i == selected
                              ? ColorManager.primary
                              : c.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            categories[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 13,
                              fontWeight: i == selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: i == selected
                                  ? ColorManager.primary
                                  : c.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _toothPicker(BuildContext context, TreatmentCategoryGroup category) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final code = _toothCode;

    if (code == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.touch_app_outlined,
                size: 26,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.pickToothHint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13.5,
                color: c.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    final name = toothDisplayName(l10n, code);
    final queued = widget.treatments
        .where((t) => t.toothNumber == code)
        .map((t) => t.type.id)
        .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                code,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.primaryDarker,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.toothLabel(code),
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                  if (name.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.5,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _toothCode = null),
              tooltip: l10n.close,
              icon: Icon(Icons.close_rounded, size: 18, color: c.textTertiary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TreatmentTypeGrid(
          types: category.treatments,
          selectedIds: queued,
          maxTileExtent: 124,
          onSelect: (type) => _toggle(type, code),
        ),
      ],
    );
  }

  Widget _generalPicker(TreatmentCategoryGroup category) {
    return TreatmentTypeGrid(
      types: category.treatments,
      selectedIds: widget.treatments
          .where((t) => t.toothNumber == null)
          .map((t) => t.type.id)
          .toSet(),
      maxTileExtent: 124,
      onSelect: (type) => _toggle(type, null),
    );
  }

  // ── The plan so far ──────────────────────────────────────────

  Widget _planCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final treatments = widget.treatments;

    return DesktopSectionCard(
      title: l10n.addedTreatments,
      subtitle: l10n.nTreatments(treatments.length),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: treatments.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 18),
              child: Center(
                child: Text(
                  l10n.noTreatmentsYetAddOne,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    color: c.textTertiary,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                for (final t in treatments)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _planRow(context, t),
                  ),
              ],
            ),
    );
  }

  Widget _planRow(BuildContext context, PlannedTreatment t) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final tooth = t.toothNumber;
    final isFocused = tooth != null && tooth == _toothCode && _tab == 0;

    return Material(
      color: isFocused
          ? ColorManager.primary.withValues(alpha: 0.06)
          : c.inputBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        // Jumps the picker to the row's tooth, so it can be topped up
        // without hunting for it on the chart.
        onTap: tooth == null ? null : () => _focusTooth(tooth),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isFocused
                  ? ColorManager.primary.withValues(alpha: 0.4)
                  : c.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: tooth != null
                    ? Text(
                        tooth,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.primaryDarker,
                        ),
                      )
                    : Icon(
                        t.type.icon,
                        size: 17,
                        color: ColorManager.primaryDarker,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.type.name,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tooth != null
                          ? l10n.toothLabel(tooth)
                          : l10n.generalTreatmentLabel,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => widget.onRemove(t),
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: c.textTertiary,
                ),
                tooltip: l10n.delete,
                hoverColor: ColorManager.error.withValues(alpha: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
