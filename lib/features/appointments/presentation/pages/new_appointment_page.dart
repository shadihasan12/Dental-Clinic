import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/create_appointment_use_case.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/patient_picker.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/selectable_chip.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_patients_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({super.key});

  @override
  State<NewAppointmentPage> createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  // Patient data from API
  List<PatientEntity> _patients = [];
  bool _isPatientsLoading = true;
  PatientEntity? _selectedPatientEntity;

  final List<String> _selectedTreatments = [];
  DateTime _selectedDate = DateTime.now();
  int _duration = 30;
  String? _selectedSlot;
  bool _sendReminder = true;

  final List<String> _treatmentKeys = [
    'Checkup', 'Cleaning', 'Filling', 'Root Canal',
    'Extraction', 'Crown', 'Whitening', 'Consultation', 'X-Ray',
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

  @override
  void initState() {
    super.initState();
    _loadAvailableSlots();
    _loadPatients();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadPatients() async {
    final result = await getIt<GetAllPatientsUseCase>()(NoParams());
    result.fold(
      (error) {
        if (mounted) {
          setState(() => _isPatientsLoading = false);
          AppSnackbar.showError(context,
              title: AppLocalizations.of(context)!.error,
              message: NetworkExceptions.getErrorMessage(error));
        }
      },
      (patients) {
        if (mounted) {
          setState(() {
            _patients = patients;
            _isPatientsLoading = false;
          });
        }
      },
    );
  }

  void _loadAvailableSlots() {
    setState(() {
      _availableSlots = [
        '9:00 AM', '10:00 AM', '11:30 AM',
        '2:00 PM', '3:00 PM', '4:30 PM',
      ];
      _selectedSlot = null;
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
      builder: (ctx) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
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
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.save,
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
                minimumDate:
                    DateTime.now().subtract(const Duration(days: 1)),
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAppointment() async {
    final l10n = AppLocalizations.of(context)!;

    if (_selectedPatientEntity == null) {
      AppSnackbar.showWarning(context,
          title: l10n.missingData, message: l10n.pleaseSelectAPatient);
      return;
    }
    if (_selectedTreatments.isEmpty) {
      AppSnackbar.showWarning(context,
          title: l10n.missingData,
          message: l10n.pleaseSelectAtLeastOneTreatment);
      return;
    }
    if (_selectedSlot == null) {
      AppSnackbar.showWarning(context,
          title: l10n.missingData,
          message: l10n.pleaseSelectAnAvailableTimeSlot);
      return;
    }

    // Parse selected time slot into DateTime
    final slotTime = _parseSlotTime(_selectedSlot!);
    final appointmentDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      slotTime.hour,
      slotTime.minute,
    );

    final appointment = AppointmentEntity(
      id: '',
      patientId: _selectedPatientEntity!.id,
      patientName: _selectedPatientEntity!.name,
      doctorId: 'doctor_1',
      doctorName: 'Dr. Ahmad',
      dateTime: appointmentDateTime,
      durationMinutes: _duration,
      treatmentType: _selectedTreatments.join(', '),
      status: AppointmentStatus.pending,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
    );

    AppLoadingDialog.show(context: context, message: l10n.savingAppointment);

    final result = await getIt<CreateAppointmentUseCase>()(appointment);

    if (!mounted) return;
    AppLoadingDialog.dismiss(context);

    result.fold(
      (error) {
        AppSnackbar.showError(context,
            title: l10n.error,
            message: NetworkExceptions.getErrorMessage(error));
      },
      (_) {
        AppSnackbar.showSuccess(context,
            title: l10n.appointmentScheduled,
            message: l10n.successfullyAddedToCalendar);
        context.pop();
      },
    );
  }

  DateTime _parseSlotTime(String slot) {
    final parts = slot.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final isPm = parts[1].toUpperCase() == 'PM';
    if (isPm && hour != 12) hour += 12;
    if (!isPm && hour == 12) hour = 0;
    return DateTime(0, 1, 1, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          PageHeader(
            title: l10n.newAppointment,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // — Patient
                      _sectionLabel(l10n.patient),
                      SizedBox(height: 10.h),
                      if (_isPatientsLoading)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        PatientPicker(
                          patients:
                              _patients.map((p) => p.name).toList(),
                          selectedPatient: _selectedPatientEntity?.name,
                          onPatientChanged: (name) {
                            final entity = name != null
                                ? _patients.firstWhere((p) => p.name == name)
                                : null;
                            setState(
                                () => _selectedPatientEntity = entity);
                          },
                          onAddNewPatient: () =>
                              context.pushNamed(AppRoutesNames.addPatient),
                        ),

                      _divider(),

                      // — Treatment types
                      _sectionLabel(l10n.treatment),
                      SizedBox(height: 10.h),
                      _buildTreatmentChips(l10n),

                      _divider(),

                      // — Duration
                      _sectionLabel(l10n.duration),
                      SizedBox(height: 10.h),
                      _buildDurationChips(),

                      _divider(),

                      // — Date
                      _buildDateRow(l10n),

                      _divider(),

                      // — Available slots
                      _sectionLabel(l10n.availableSlots),
                      SizedBox(height: 10.h),
                      _buildSlots(l10n),

                      _divider(),

                      // — Notes
                      _sectionLabel(l10n.notes),
                      SizedBox(height: 10.h),
                      AppFormField(
                        controller: _notesController,
                        maxLines: 3,
                        hintText: l10n.addNotesForAppointment,
                        label: '',
                      ),

                      _divider(),

                      // — Reminder
                      _buildReminderRow(l10n),

                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
              l10n.save,
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

  // ─── Chips ──────────────────────────────────────────────────────────────

  Widget _buildTreatmentChips(AppLocalizations l10n) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _treatmentKeys.map((key) {
        final isSelected = _selectedTreatments.contains(key);
        return SelectableChip(
          label: _localizedTreatment(l10n, key),
          isSelected: isSelected,
          onTap: () => setState(() {
            isSelected
                ? _selectedTreatments.remove(key)
                : _selectedTreatments.add(key);
          }),
        );
      }).toList(),
    );
  }

  Widget _buildDurationChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _durations.map((d) {
        return SelectableChip(
          label: d['label'],
          isSelected: _duration == d['value'],
          onTap: () {
            setState(() => _duration = d['value']);
            _loadAvailableSlots();
          },
        );
      }).toList(),
    );
  }

  Widget _buildSlots(AppLocalizations l10n) {
    if (_availableSlots.isEmpty) {
      return Text(
        l10n.noAvailableSlotsForThisDate,
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
        return SelectableChip(
          label: slot,
          isSelected: _selectedSlot == slot,
          onTap: () => setState(() => _selectedSlot = slot),
          borderRadius: 10,
        );
      }).toList(),
    );
  }

  // ─── Date row ───────────────────────────────────────────────────────────

  Widget _buildDateRow(AppLocalizations l10n) {
    final formatted = DateFormat('MMM d, yyyy').format(_selectedDate);
    final isToday = DateUtils.isSameDay(_selectedDate, DateTime.now());

    return GestureDetector(
      onTap: _selectDate,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 16.w, color: Colors.grey.shade500),
            SizedBox(width: 8.w),
            Text(
              isToday ? '${l10n.today}, $formatted' : formatted,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              l10n.change,
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

  // ─── Reminder toggle ───────────────────────────────────────────────────

  Widget _buildReminderRow(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => setState(() => _sendReminder = !_sendReminder),
      child: Row(
        children: [
          Icon(Icons.notifications_outlined,
              size: 18.w, color: Colors.grey.shade500),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              l10n.sendReminderToPatient,
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

  String _localizedTreatment(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Checkup':       return l10n.checkup;
      case 'Cleaning':      return l10n.cleaning;
      case 'Filling':       return l10n.filling;
      case 'Root Canal':    return l10n.rootCanal;
      case 'Extraction':    return l10n.extraction;
      case 'Crown':         return l10n.crown;
      case 'Whitening':     return l10n.whitening;
      case 'Consultation':  return l10n.consultation;
      case 'X-Ray':         return l10n.xray;
      default:              return key;
    }
  }
}
