import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Add treatments to the active case without leaving the patient screen.
///
/// Keeps the existing [ToothChart] exactly as it was - it is the part of this
/// flow that already works. What changed is the container: a full-height
/// sheet, and tapping a tooth scrolls the sheet down to the treatment picker
/// so the next action is under the thumb rather than off-screen.
class AddTreatmentSheet extends StatefulWidget {
  const AddTreatmentSheet({
    super.key,
    required this.categories,
    required this.teeth,
  });

  final List<TreatmentCategoryGroup> categories;
  final List<Tooth> teeth;

  /// Resolves to the treatments to add, or null if dismissed.
  static Future<List<PlannedTreatment>?> show(
    BuildContext context, {
    required List<TreatmentCategoryGroup> categories,
    required List<Tooth> teeth,
  }) {
    return showModalBottomSheet<List<PlannedTreatment>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTreatmentSheet(categories: categories, teeth: teeth),
    );
  }

  @override
  State<AddTreatmentSheet> createState() => _AddTreatmentSheetState();
}

class _AddTreatmentSheetState extends State<AddTreatmentSheet> {
  final _scroll = ScrollController();
  final _pickerKey = GlobalKey();

  /// Universal codes of teeth the dentist has tapped.
  final Set<String> _selectedTeeth = {};

  /// What will be added when they confirm.
  final List<PlannedTreatment> _staged = [];

  bool _generalTab = false;
  int _idSeed = 0;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  /// The behaviour asked for: selecting a tooth brings the treatment cards
  /// into view instead of leaving them below the fold.
  void _scrollToPicker() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _pickerKey.currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        alignment: 0.05,
      );
    });
  }

  void _onToothTap(String universalCode) {
    setState(() {
      if (!_selectedTeeth.remove(universalCode)) {
        _selectedTeeth.add(universalCode);
      }
      if (_selectedTeeth.isNotEmpty) _generalTab = false;
    });
    if (_selectedTeeth.isNotEmpty) _scrollToPicker();
  }

  bool get _generalMode => _generalTab || _selectedTeeth.isEmpty;

  /// A card reads as selected when the current context is fully covered: in
  /// general mode that is a single entry, and with teeth selected it means
  /// every one of them already has this treatment staged.
  bool _isSelected(TreatmentTypeInfo type) {
    if (_generalMode) {
      return _staged
          .any((s) => s.type.id == type.id && s.toothNumber == null);
    }
    return _selectedTeeth.every(
      (code) => _staged
          .any((s) => s.type.id == type.id && s.toothNumber == code),
    );
  }

  /// Tap to stage, tap again to unstage. The tooth selection deliberately
  /// survives the tap so the card keeps showing its selected border - use
  /// Clear, or deselect the teeth on the chart, to move to the next tooth.
  void _toggle(TreatmentTypeInfo type) {
    final selected = _isSelected(type);
    setState(() {
      if (_generalMode) {
        if (selected) {
          _staged.removeWhere(
            (s) => s.type.id == type.id && s.toothNumber == null,
          );
        } else {
          _staged.add(PlannedTreatment(id: 'new_${_idSeed++}', type: type));
        }
        return;
      }
      for (final code in _selectedTeeth) {
        final existing = _staged
            .where((s) => s.type.id == type.id && s.toothNumber == code)
            .toList();
        if (selected) {
          for (final s in existing) {
            _staged.remove(s);
          }
        } else if (existing.isEmpty) {
          _staged.add(
            PlannedTreatment(
              id: 'new_${_idSeed++}',
              type: type,
              toothNumber: code,
            ),
          );
        }
      }
    });
  }

  List<String> _selectedToothIds() {
    if (widget.teeth.isEmpty) return _selectedTeeth.toList();
    return widget.teeth
        .where((t) => _selectedTeeth.contains(t.universalCode))
        .map((t) => t.id)
        .toList();
  }

  String _codeForId(String id) {
    final match = widget.teeth.where((t) => t.id == id);
    return match.isNotEmpty ? match.first.universalCode : id;
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    final toothCats = widget.categories
        .where((g) => !g.name.contains('عامة'))
        .toList();
    final generalCats = widget.categories
        .where((g) => g.name.contains('عامة'))
        .toList();
    final active = _generalTab ? generalCats : toothCats;

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.96,
      expand: false,
      builder: (_, sheetScroll) {
        return Container(
          decoration: BoxDecoration(
            color: c.scaffoldBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              _Grabber(),
              _Header(
                title: l10n.addTreatmentButton,
                subtitle: _staged.isEmpty
                    ? null
                    : '${_staged.length} ${l10n.selectedCount}',
                onClose: () => Navigator.pop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scroll,
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The existing chart, untouched.
                      ToothChart(
                        teeth: widget.teeth,
                        selectedTeeth: _selectedToothIds(),
                        aspectRatio: 0.75,
                        onSelectionChanged: (ids) {
                          if (ids.isEmpty) return;
                          _onToothTap(_codeForId(ids.last));
                        },
                      ),
                      SizedBox(height: 10.h),
                      if (_selectedTeeth.isNotEmpty)
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: [
                            for (final code in _selectedTeeth)
                              _Pill(
                                label: l10n.toothLabel(code),
                                onRemove: () =>
                                    setState(() => _selectedTeeth.remove(code)),
                              ),
                            _ClearButton(
                              label: l10n.clearSelection,
                              onTap: () => setState(_selectedTeeth.clear),
                            ),
                          ],
                        ),
                      SizedBox(height: 14.h),
                      Container(key: _pickerKey),
                      _TabSwitch(
                        toothLabel: l10n.toothSpecificTab,
                        generalLabel: l10n.generalTab,
                        generalActive: _generalTab,
                        onChanged: (g) => setState(() => _generalTab = g),
                      ),
                      SizedBox(height: 10.h),
                      if (!_generalTab && _selectedTeeth.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Center(
                            child: Text(
                              l10n.selectToothFirst,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: family,
                                color: c.textTertiary,
                              ),
                            ),
                          ),
                        )
                      else
                        for (final group in active) ...[
                          Text(
                            group.name,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: family,
                              color: c.textSecondary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              for (final t in group.treatments)
                                _TreatmentChoice(
                                  type: t,
                                  selected: _isSelected(t),
                                  onTap: () => _toggle(t),
                                ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                        ],
                      if (_staged.isNotEmpty) ...[
                        Divider(color: c.borderLight),
                        SizedBox(height: 8.h),
                        Text(
                          '${_staged.length} ${l10n.selectedCount}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: family,
                            color: c.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: [
                            // Read-only: the card above is the toggle, so a
                            // second remove affordance here would just be a
                            // way to desync the two.
                            for (final s in _staged)
                              _Pill(
                                label: s.toothNumber == null
                                    ? s.type.name
                                    : '${s.type.name} - ${s.toothNumber}',
                              ),
                          ],
                        ),
                      ],
                      // Keep the sheet scrollable past the docked button.
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
              _Confirm(
                enabled: _staged.isNotEmpty,
                label: l10n.addToThisCase,
                onTap: () => Navigator.pop(context, List.of(_staged)),
              ),
              // Consume the sheet's own controller so the drag handle works.
              SizedBox(height: 0, child: SingleChildScrollView(controller: sheetScroll)),
            ],
          ),
        );
      },
    );
  }
}

class _Grabber extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: ColorManager.of(context).border,
            borderRadius: BorderRadius.circular(999.r),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.title, this.subtitle, required this.onClose});
  final String title;
  final String? subtitle;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 8.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: family,
                    color: c.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: family,
                      color: ColorManager.primaryDarker,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close_rounded, size: 20.w, color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _TabSwitch extends StatelessWidget {
  const _TabSwitch({
    required this.toothLabel,
    required this.generalLabel,
    required this.generalActive,
    required this.onChanged,
  });

  final String toothLabel;
  final String generalLabel;
  final bool generalActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          _seg(context, toothLabel, !generalActive, () => onChanged(false)),
          _seg(context, generalLabel, generalActive, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _seg(BuildContext context, String label, bool active, VoidCallback t) {
    final c = ColorManager.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: t,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: active ? c.cardBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                fontFamily: FontHelper.fontFamily(context),
                color: active ? c.textPrimary : c.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TreatmentChoice extends StatelessWidget {
  const _TreatmentChoice({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final TreatmentTypeInfo type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(12.r);

    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: 104.w,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: selected
                ? ColorManager.primary.withValues(alpha: 0.08)
                : c.cardBg,
            borderRadius: radius,
            border: Border.all(
              color: selected ? ColorManager.primary : c.borderLight,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(type.icon, size: 20.w, color: ColorManager.primaryDarker),
              SizedBox(height: 6.h),
              Text(
                type.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  fontFamily: FontHelper.fontFamily(context),
                  color: selected ? ColorManager.primaryDarker : c.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.onRemove});
  final String label;

  /// Omit for a read-only pill - the staged list is driven by the cards.
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: onRemove == null
          ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h)
          : EdgeInsetsDirectional.only(start: 10.w, end: 4.w),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.primaryDarker,
            ),
          ),
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              visualDensity: VisualDensity.compact,
              constraints: BoxConstraints(minWidth: 28.w, minHeight: 28.w),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.close_rounded,
                size: 14.w,
                color: ColorManager.primaryDarker,
              ),
            ),
        ],
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.of(context).textSecondary,
        ),
      ),
    );
  }
}

class _Confirm extends StatelessWidget {
  const _Confirm({
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: enabled ? onTap : null,
            style: FilledButton.styleFrom(
              backgroundColor: ColorManager.primary,
              disabledBackgroundColor: c.cardBgSecondary,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: enabled ? ColorManager.white : c.textTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
