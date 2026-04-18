import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientPicker extends StatefulWidget {
  final List<String> patients;
  final String? selectedPatient;
  final ValueChanged<String?> onPatientChanged;
  final VoidCallback onAddNewPatient;

  const PatientPicker({
    super.key,
    required this.patients,
    required this.selectedPatient,
    required this.onPatientChanged,
    required this.onAddNewPatient,
  });

  @override
  State<PatientPicker> createState() => _PatientPickerState();
}

class _PatientPickerState extends State<PatientPicker> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.patients;
  }

  @override
  void didUpdateWidget(covariant PatientPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patients != widget.patients) {
      _filtered = _searchController.text.isEmpty
          ? widget.patients
          : widget.patients
              .where((p) => p
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filter(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? widget.patients
          : widget.patients
              .where((p) => p.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  void _select(String patient) {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filtered = widget.patients;
    });
    widget.onPatientChanged(patient);
  }

  void _clear() {
    widget.onPatientChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.selectedPatient != null && !_isSearching)
          _buildSelected(isDesktop)
        else
          _buildSearch(l10n, isDesktop),
        SizedBox(height: isDesktop ? 12 : 10.h),
        _buildAddNewLink(l10n, isDesktop),
      ],
    );
  }

  Widget _buildSelected(bool isDesktop) {
    final c = ColorManager.of(context);
    final name = widget.selectedPatient!;
    final double hPad = isDesktop ? 14 : 14.w;
    final double vPad = isDesktop ? 12 : 12.h;
    final double radius = isDesktop ? 12 : 10.r;
    final double avatarR = isDesktop ? 18 : 16.r;
    final double fontSize = isDesktop ? 14 : 14.sp;
    final double iconSize = isDesktop ? 20 : 18.w;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarR,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.18),
            child: Text(
              _initials(name),
              style: TextStyle(
                fontSize: isDesktop ? 13 : 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w700,
                color: ColorManager.primary,
              ),
            ),
          ),
          SizedBox(width: isDesktop ? 12 : 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context)!.patient,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
          _IconAction(
            icon: Icons.swap_horiz_rounded,
            size: iconSize,
            onTap: () => setState(() => _isSearching = true),
            isDesktop: isDesktop,
          ),
          SizedBox(width: isDesktop ? 4 : 4.w),
          _IconAction(
            icon: Icons.close_rounded,
            size: iconSize,
            onTap: _clear,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(AppLocalizations l10n, bool isDesktop) {
    final c = ColorManager.of(context);
    final double radius = isDesktop ? 12 : 10.r;
    final double fontSize = isDesktop ? 14 : 14.sp;
    final double hPad = isDesktop ? 14 : 14.w;
    final double vPad = isDesktop ? 13 : 12.h;
    final double iconSize = isDesktop ? 20 : 20.w;
    final double dropdownMax = isDesktop ? 240 : 180.h;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: c.borderLight),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: _isSearching,
            onTap: () => setState(() => _isSearching = true),
            onChanged: _filter,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: l10n.searchPatientName,
              hintStyle: TextStyle(
                fontSize: fontSize,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSubtle,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: iconSize,
                color: c.textSubtle,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: hPad,
                vertical: vPad,
              ),
            ),
          ),
        ),
        if (_isSearching && _filtered.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: isDesktop ? 6 : 4.h),
            constraints: BoxConstraints(maxHeight: dropdownMax),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: c.borderLight),
              boxShadow: isDesktop
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _filtered.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: c.borderLight,
                ),
                itemBuilder: (context, index) {
                  final patient = _filtered[index];
                  return _PatientRow(
                    name: patient,
                    isDesktop: isDesktop,
                    onTap: () => _select(patient),
                  );
                },
              ),
            ),
          ),
        if (_isSearching && _filtered.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: isDesktop ? 10 : 8.h),
            child: Text(
              l10n.noPatientsFound,
              style: TextStyle(
                fontSize: isDesktop ? 13 : 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSubtle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddNewLink(AppLocalizations l10n, bool isDesktop) {
    return GestureDetector(
      onTap: widget.onAddNewPatient,
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        cursor: isDesktop
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: isDesktop ? 18 : 18.w,
              color: ColorManager.primary,
            ),
            SizedBox(width: isDesktop ? 6 : 6.w),
            Text(
              l10n.addNewPatient,
              style: TextStyle(
                fontSize: isDesktop ? 13.5 : 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

class _IconAction extends StatefulWidget {
  const _IconAction({
    required this.icon,
    required this.size,
    required this.onTap,
    required this.isDesktop,
  });

  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final bool isDesktop;

  @override
  State<_IconAction> createState() => _IconActionState();
}

class _IconActionState extends State<_IconAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final bg = (_hovered && widget.isDesktop)
        ? c.cardBgSecondary
        : Colors.transparent;

    final child = Container(
      padding: EdgeInsets.all(widget.isDesktop ? 6 : 4),
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(widget.icon, size: widget.size, color: c.textSubtle),
    );

    if (!widget.isDesktop) {
      return GestureDetector(onTap: widget.onTap, child: child);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(onTap: widget.onTap, child: child),
    );
  }
}

class _PatientRow extends StatefulWidget {
  const _PatientRow({
    required this.name,
    required this.isDesktop,
    required this.onTap,
  });

  final String name;
  final bool isDesktop;
  final VoidCallback onTap;

  @override
  State<_PatientRow> createState() => _PatientRowState();
}

class _PatientRowState extends State<_PatientRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final double hPad = widget.isDesktop ? 14 : 14.w;
    final double vPad = widget.isDesktop ? 12 : 12.h;
    final double fontSize = widget.isDesktop ? 13.5 : 14.sp;
    final double avatarR = widget.isDesktop ? 15 : 14.r;

    final row = Material(
      color: _hovered && widget.isDesktop
          ? ColorManager.primary.withValues(alpha: 0.06)
          : Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          child: Row(
            children: [
              CircleAvatar(
                radius: avatarR,
                backgroundColor: c.cardBgSecondary,
                child: Text(
                  widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: widget.isDesktop ? 12 : 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w700,
                    color: c.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: widget.isDesktop ? 12 : 10.w),
              Expanded(
                child: Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: c.textPrimary,
                  ),
                ),
              ),
              if (widget.isDesktop)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _hovered ? 1 : 0,
                  child: Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: ColorManager.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    if (!widget.isDesktop) return row;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: row,
    );
  }
}
