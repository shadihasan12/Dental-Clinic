import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Search-and-pick for the appointment's patient.
///
/// Wears the shared form-kit input shell so it sits at the same radius,
/// hairline and type size as every typed field on Add Patient - a picker and
/// a text field should not look like two different kinds of control.
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
  final _focusNode = FocusNode();
  bool _isSearching = false;
  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.patients;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

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
    _focusNode.unfocus();
    widget.onPatientChanged(patient);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.selectedPatient != null && !_isSearching)
          _buildSelected()
        else
          _buildSearch(l10n),
        SizedBox(height: 10.h),
        _buildAddNewLink(l10n),
      ],
    );
  }

  Widget _buildSelected() {
    final c = ColorManager.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? ColorManager.primary : ColorManager.primaryDarker;

    return GestureDetector(
      onTap: () => setState(() => _isSearching = true),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorManager.primary.withValues(alpha: 0.30),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Text(
                widget.selectedPatient![0].toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                widget.selectedPatient!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ),
            Icon(Icons.close_rounded, size: 17.w, color: c.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: formInputDecoration(
            context,
            focused: _focusNode.hasFocus,
            hasError: false,
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            autofocus: _isSearching,
            onTap: () => setState(() => _isSearching = true),
            onChanged: _filter,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: family,
              color: c.textPrimary,
            ),
            decoration: bareInputDecoration().copyWith(
              hintText: l10n.searchPatientName,
              hintStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: family,
                color: c.textTertiary,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 18.w,
                color: c.textTertiary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 38.w,
                minHeight: 0,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
        if (_isSearching && _filtered.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 6.h),
            // A desktop window has the vertical room to show roughly twice
            // as many matches before the list starts scrolling.
            constraints: BoxConstraints(
              maxHeight: Responsive.isDesktop(context) ? 240 : 180.h,
            ),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _filtered.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: c.borderLight),
              itemBuilder: (context, index) {
                final patient = _filtered[index];
                return InkWell(
                  onTap: () => _select(patient),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 26.w,
                          height: 26.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: c.cardBgSecondary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            patient[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: family,
                              fontWeight: FontWeight.w600,
                              color: c.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            patient,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: family,
                              color: c.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        if (_isSearching && _filtered.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              l10n.noPatientsFound,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontFamily: family,
                color: c.textTertiary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddNewLink(AppLocalizations l10n) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: widget.onAddNewPatient,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: 15.w,
              color: ColorManager.primary,
            ),
            SizedBox(width: 6.w),
            Text(
              l10n.addNewPatient,
              style: TextStyle(
                fontSize: 11.5.sp,
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
}
