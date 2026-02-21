import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations_ar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({super.key});

  @override
  State<NewAppointmentPage> createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _searchController = TextEditingController();

  String? _selectedPatient;
  final List<String> _selectedTreatments = [];
  DateTime _selectedDate = DateTime.now();
  int _duration = 30;
  String? _selectedSlot;
  bool _sendReminder = true;
  bool _isSearchingPatient = false;

  final List<String> _patients = [
    'Sarah Johnson',
    'Michael Brown',
    'Emma Wilson',
    'James Davis',
    'Lisa Anderson',
    'Robert Taylor',
  ];

  final List<String> _treatmentTypes = [
    'Checkup',
    'Cleaning',
    'Filling',
    'Root Canal',
    'Extraction',
    'Crown',
    'Whitening',
    'Consultation',
    'X-Ray',
  ];

  final List<Map<String, dynamic>> _durations = [
    {'label': '15m', 'value': 15},
    {'label': '30m', 'value': 30},
    {'label': '45m', 'value': 45},
    {'label': '1h', 'value': 60},
    {'label': '1h 30m', 'value': 90},
    {'label': '2h', 'value': 120},
  ];

  List<String> _availableSlots = [];
  List<String> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _patients;
    _loadAvailableSlots();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadAvailableSlots() {
    setState(() {
      _availableSlots = [
        '9:00 AM',
        '10:00 AM',
        '11:30 AM',
        '2:00 PM',
        '3:00 PM',
        '4:30 PM',
      ];
      _selectedSlot = null;
    });
  }

  void _filterPatients(String query) {
    setState(() {
      _filteredPatients = query.isEmpty
          ? _patients
          : _patients
                .where((p) => p.toLowerCase().contains(query.toLowerCase()))
                .toList();
    });
  }

  void _selectPatient(String patient) {
    setState(() {
      _selectedPatient = patient;
      _isSearchingPatient = false;
      _searchController.clear();
      _filteredPatients = _patients;
    });
  }

  Future<void> _selectDate() async {
    DateTime tempDate = _selectedDate;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _selectedDate = tempDate);
                      _loadAvailableSlots();
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.done,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime.now().subtract(const Duration(days: 1)),
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveAppointment() {
    if (_selectedPatient == null) {
      AppSnackbar.showWarning(
        context,
        title: AppLocalizations.of(context)!.missingData,
        message: AppLocalizations.of(context)!.pleaseSelectAPatient,
      );
      return;
    }
    if (_selectedTreatments.isEmpty) {
      AppSnackbar.showWarning(
        context,
        title: AppLocalizations.of(context)!.missingData,
        message: AppLocalizations.of(context)!.pleaseSelectAtLeastOneTreatment,
      );
      return;
    }
    if (_selectedSlot == null) {
      AppSnackbar.showWarning(
        context,
        title: AppLocalizations.of(context)!.missingData,
        message: AppLocalizations.of(context)!.pleaseSelectAnAvailableTimeSlot,
      );
      return;
    }

    AppSnackbar.showSuccess(
      context,
      title: AppLocalizations.of(context)!.appointmentScheduled,
      message: AppLocalizations.of(context)!.successfullyAddedToCalendar,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageHeader(
        title: AppLocalizations.of(context)!.newAppointment,
        onBack: () => context.pop(),
      ) ,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_isSearchingPatient) {
            setState(() => _isSearchingPatient = false);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // — Patient
                _buildPatientSection(),

                _divider(),

                // — Treatment types
                _sectionLabel(AppLocalizations.of(context)!.treatment),
                SizedBox(height: 10.h),
                _buildTreatmentChips(),

                _divider(),

                // — Duration
                _sectionLabel(AppLocalizations.of(context)!.duration),
                SizedBox(height: 10.h),
                _buildDurationChips(),

                _divider(),

                // — Date
                _buildDateRow(),

                _divider(),

                // — Available slots
                _sectionLabel(AppLocalizations.of(context)!.availableSlots),
                SizedBox(height: 10.h),
                _buildSlots(),

                _divider(),

                // — Notes
                _sectionLabel(AppLocalizations.of(context)!.notes),
                SizedBox(height: 10.h),
                AppFormField(
                  controller: _notesController,
                  maxLines: 3,
                  hintText: AppLocalizations.of(context)!.addNotesForAppointment,
                  label: '',
                ),

                _divider(),

                // — Reminder
                _buildReminderRow(),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _saveAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Patient section with search ────────────────────────────────────────

  Widget _buildPatientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(AppLocalizations.of(context)!.patient),
        SizedBox(height: 10.h),

        // Selected patient or search field
        if (_selectedPatient != null && !_isSearchingPatient)
          _buildSelectedPatient()
        else
          _buildPatientSearch(),

        SizedBox(height: 10.h),

        // Add new patient link
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutesNames.addPatient),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 18.w,
                color: ColorManager.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                AppLocalizations.of(context)!.addNewPatient,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedPatient() {
    return GestureDetector(
      onTap: () => setState(() => _isSearchingPatient = true),
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
                _selectedPatient![0],
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
                _selectedPatient!,
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

  Widget _buildPatientSearch() {
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
            autofocus: _isSearchingPatient,
            onTap: () => setState(() => _isSearchingPatient = true),
            onChanged: _filterPatients,
            style: TextStyle(fontSize: 14.sp, fontFamily: FontHelper.fontFamily(context)),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchPatientName,
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

        // Dropdown results
        if (_isSearchingPatient && _filteredPatients.isNotEmpty)
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
              itemCount: _filteredPatients.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final patient = _filteredPatients[index];
                return InkWell(
                  onTap: () => _selectPatient(patient),
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

        if (_isSearchingPatient && _filteredPatients.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              AppLocalizations.of(context)!.noPatientsFound,
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

  // ─── Treatment chips ────────────────────────────────────────────────────

  Widget _buildTreatmentChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _treatmentTypes.map((treatment) {
        final isSelected = _selectedTreatments.contains(treatment);
        final l10n = AppLocalizations.of(context)!;
        final localizedTreatment = _getLocalizedTreatmentName(context, treatment);
        return GestureDetector(
          onTap: () => setState(() {
            isSelected
                ? _selectedTreatments.remove(treatment)
                : _selectedTreatments.add(treatment);
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.primary : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? ColorManager.primary : Colors.grey.shade300,
              ),
            ),
            child: Text(
              localizedTreatment,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── Duration chips ─────────────────────────────────────────────────────

  Widget _buildDurationChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _durations.map((d) {
        final isSelected = _duration == d['value'];
        return GestureDetector(
          onTap: () {
            setState(() => _duration = d['value']);
            _loadAvailableSlots();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.primary : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? ColorManager.primary : Colors.grey.shade300,
              ),
            ),
            child: Text(
              d['label'],
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── Date row (same style as visit form) ────────────────────────────────

  Widget _buildDateRow() {
    final formatted = DateFormat('MMM d, yyyy').format(_selectedDate);
    final isToday = DateUtils.isSameDay(_selectedDate, DateTime.now());

    return GestureDetector(
      onTap: _selectDate,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16.w,
              color: Colors.grey.shade500,
            ),
            SizedBox(width: 8.w),
            Text(
              isToday ? '${AppLocalizations.of(context)!.today}, $formatted' : formatted,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.change,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Available slots ────────────────────────────────────────────────────

  Widget _buildSlots() {
    if (_availableSlots.isEmpty) {
      return Text(
        AppLocalizations.of(context)!.noAvailableSlotsForThisDate,
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: FontHelper.fontFamily(context),
          color: Colors.grey.shade400,
        ),
      );
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _availableSlots.map((slot) {
        final isSelected = _selectedSlot == slot;
        return GestureDetector(
          onTap: () => setState(() => _selectedSlot = slot),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.primary : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected ? ColorManager.primary : Colors.grey.shade300,
              ),
            ),
            child: Text(
              slot,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── Reminder toggle ───────────────────────────────────────────────────

  Widget _buildReminderRow() {
    return GestureDetector(
      onTap: () => setState(() => _sendReminder = !_sendReminder),
      child: Row(
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 18.w,
            color: Colors.grey.shade500,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.sendReminderToPatient,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: _sendReminder ? ColorManager.primary : Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: _sendReminder
                    ? ColorManager.primary
                    : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: _sendReminder
                ? Icon(Icons.check, size: 14.w, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  Widget _sectionLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
        fontFamily: FontHelper.fontFamily(context),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Divider(color: Colors.grey.shade200),
    );
  }

  String _getLocalizedTreatmentName(BuildContext context, String treatment) {
    final l10n = AppLocalizations.of(context)!;
    switch (treatment) {
      case 'Checkup':
        return l10n.checkup;
      case 'Cleaning':
        return l10n.cleaning;
      case 'Filling':
        return l10n.filling;
      case 'Root Canal':
        return l10n.rootCanal;
      case 'Extraction':
        return l10n.extraction;
      case 'Crown':
        return l10n.crown;
      case 'Whitening':
        return l10n.whitening;
      case 'Consultation':
        return l10n.consultation;
      case 'X-Ray':
        return l10n.xray;
      default:
        return treatment;
    }
  }
}
