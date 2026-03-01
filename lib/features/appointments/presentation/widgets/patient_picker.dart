import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    return GestureDetector(
      onTap: () => setState(() => _isSearching = true),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: ColorManager.primary.withValues(alpha: 0.15),
              child: Text(
                widget.selectedPatient![0],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                widget.selectedPatient!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.close, size: 18.w, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: _isSearching,
            onTap: () => setState(() => _isSearching = true),
            onChanged: _filter,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
            ),
            decoration: InputDecoration(
              hintText: l10n.searchPatientName,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: Colors.grey.shade400,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 20.w,
                color: Colors.grey.shade400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
        if (_isSearching && _filtered.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 4.h),
            constraints: BoxConstraints(maxHeight: 180.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _filtered.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final patient = _filtered[index];
                return InkWell(
                  onTap: () => _select(patient),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Colors.grey.shade100,
                          child: Text(
                            patient[0],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          patient,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: Colors.black87,
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
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: Colors.grey.shade400,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddNewLink(AppLocalizations l10n) {
    return GestureDetector(
      onTap: widget.onAddNewPatient,
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 18.w,
            color: ColorManager.primary,
          ),
          SizedBox(width: 6.w),
          Text(
            l10n.addNewPatient,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
