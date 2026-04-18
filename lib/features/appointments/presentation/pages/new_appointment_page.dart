import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
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
    final result = await getIt<GetAllPatientsUseCase>()(1);
    result.fold(
      (error) {
        if (mounted) {
          setState(() => _isPatientsLoading = false);
          AppSnackbar.showError(context,
              title: AppLocalizations.of(context)!.error,
              message: NetworkExceptions.getErrorMessage(error));
        }
      },
      (response) {
        if (mounted) {
          setState(() {
            _patients = response.data;
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
    if (Responsive.isDesktop(context)) {
      final picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: ColorManager.primary,
                  ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && mounted) {
        setState(() => _selectedDate = picked);
        _loadAvailableSlots();
      }
      return;
    }

    DateTime tempDate = _selectedDate;
    await showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.of(context).cardBg,
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
                        color: ColorManager.of(context).textTertiary,
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
            Divider(height: 1, color: ColorManager.of(context).divider),
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

  String _localizedTreatment(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Checkup':      return l10n.checkup;
      case 'Cleaning':     return l10n.cleaning;
      case 'Filling':      return l10n.filling;
      case 'Root Canal':   return l10n.rootCanal;
      case 'Extraction':   return l10n.extraction;
      case 'Crown':        return l10n.crown;
      case 'Whitening':    return l10n.whitening;
      case 'Consultation': return l10n.consultation;
      case 'X-Ray':        return l10n.xray;
      default:             return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktop(context);
    }
    return _buildMobile(context);
  }

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDesktop(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return DesktopShell(
      title: l10n.newAppointment,
      breadcrumb: l10n.appointments,
      selectedTabIndex: 2,
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final stackSidebar = constraints.maxWidth < 1100;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DesktopHeader(
                        fontFamily: fontFamily,
                        selectedDate: _selectedDate,
                      ),
                      const SizedBox(height: 22),
                      stackSidebar
                          ? Column(
                              children: [
                                _buildFormCard(l10n, c, fontFamily),
                                const SizedBox(height: 20),
                                _buildSummaryCard(l10n, c, fontFamily),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _buildFormCard(
                                      l10n, c, fontFamily),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 360,
                                  child: _buildSummaryCard(
                                      l10n, c, fontFamily),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormCard(
    AppLocalizations l10n,
    AppColors c,
    String fontFamily,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 22, 26, 26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DesktopSectionHeader(
                icon: Icons.person_outline_rounded,
                title: l10n.patient,
                subtitle: 'Who is this appointment for?',
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 14),
              if (_isPatientsLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                PatientPicker(
                  patients: _patients.map((p) => p.name).toList(),
                  selectedPatient: _selectedPatientEntity?.name,
                  onPatientChanged: (name) {
                    final entity = name != null
                        ? _patients.firstWhere((p) => p.name == name)
                        : null;
                    setState(() => _selectedPatientEntity = entity);
                  },
                  onAddNewPatient: () =>
                      context.pushNamed(AppRoutesNames.addPatient),
                ),

              _DesktopSectionDivider(c: c),

              _DesktopSectionHeader(
                icon: Icons.medical_services_outlined,
                title: l10n.treatment,
                subtitle: 'Pick one or more treatments',
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
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
              ),

              _DesktopSectionDivider(c: c),

              _DesktopSectionHeader(
                icon: Icons.timer_outlined,
                title: l10n.duration,
                subtitle: 'How long will the visit take?',
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
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
              ),

              _DesktopSectionDivider(c: c),

              _DesktopSectionHeader(
                icon: Icons.notes_rounded,
                title: l10n.notes,
                subtitle: 'Optional details for the visit',
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 12),
              AppFormField(
                controller: _notesController,
                maxLines: 4,
                hintText: l10n.addNotesForAppointment,
                label: '',
              ),

              _DesktopSectionDivider(c: c),

              _DesktopReminderTile(
                value: _sendReminder,
                onChanged: (v) => setState(() => _sendReminder = v),
                fontFamily: fontFamily,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    AppLocalizations l10n,
    AppColors c,
    String fontFamily,
  ) {
    final formattedDate = DateFormat('EEEE, MMM d').format(_selectedDate);
    final patientName = _selectedPatientEntity?.name;
    final treatments = _selectedTreatments.isEmpty
        ? null
        : _selectedTreatments
            .map((t) => _localizedTreatment(l10n, t))
            .join(', ');
    final canSave = _selectedPatientEntity != null &&
        _selectedTreatments.isNotEmpty &&
        _selectedSlot != null;

    return Column(
      children: [
        // Date & slots card
        Container(
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: ColorManager.primary10,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        size: 17,
                        color: ColorManager.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 11.5,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600,
                              color: c.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: c.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: c.cardBgSecondary,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: _selectDate,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            l10n.change,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: c.borderLight),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.availableSlots,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.5,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        color: c.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDesktopSlots(l10n, c, fontFamily),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Summary card
        Container(
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.borderLight),
          ),
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.5,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                  color: c.textTertiary,
                ),
              ),
              const SizedBox(height: 12),
              _SummaryRow(
                icon: Icons.person_outline_rounded,
                label: l10n.patient,
                value: patientName,
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 10),
              _SummaryRow(
                icon: Icons.medical_services_outlined,
                label: l10n.treatment,
                value: treatments,
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 10),
              _SummaryRow(
                icon: Icons.schedule_rounded,
                label: l10n.duration,
                value: _durationLabel(_duration),
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 10),
              _SummaryRow(
                icon: Icons.access_time_rounded,
                label: 'Time',
                value: _selectedSlot,
                fontFamily: fontFamily,
              ),
              const SizedBox(height: 10),
              _SummaryRow(
                icon: Icons.notifications_outlined,
                label: 'Reminder',
                value: _sendReminder ? 'On' : 'Off',
                fontFamily: fontFamily,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Save button
        SizedBox(
          width: double.infinity,
          child: Material(
            color: canSave
                ? ColorManager.primary
                : ColorManager.primary.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _saveAppointment,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: canSave
                      ? [
                          BoxShadow(
                            color: ColorManager.primary
                                .withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      l10n.save,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSlots(
    AppLocalizations l10n,
    AppColors c,
    String fontFamily,
  ) {
    if (_availableSlots.isEmpty) {
      return Text(
        l10n.noAvailableSlotsForThisDate,
        style: TextStyle(
          fontSize: 13,
          fontFamily: fontFamily,
          color: c.textSubtle,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _availableSlots.map((slot) {
        return SelectableChip(
          label: slot,
          icon: Icons.access_time_rounded,
          isSelected: _selectedSlot == slot,
          borderRadius: 10,
          onTap: () => setState(() => _selectedSlot = slot),
        );
      }).toList(),
    );
  }

  String _durationLabel(int minutes) {
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final rem = minutes % 60;
    if (rem == 0) return '$hours h';
    return '$hours h ${rem}m';
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
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

                      _sectionLabel(l10n.treatment),
                      SizedBox(height: 10.h),
                      _buildTreatmentChips(l10n),

                      _divider(),

                      _sectionLabel(l10n.duration),
                      SizedBox(height: 10.h),
                      _buildDurationChips(),

                      _divider(),

                      _buildDateRow(l10n),

                      _divider(),

                      _sectionLabel(l10n.availableSlots),
                      SizedBox(height: 10.h),
                      _buildSlots(l10n),

                      _divider(),

                      _sectionLabel(l10n.notes),
                      SizedBox(height: 10.h),
                      AppFormField(
                        controller: _notesController,
                        maxLines: 3,
                        hintText: l10n.addNotesForAppointment,
                        label: '',
                      ),

                      _divider(),

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
          color: ColorManager.of(context).textSubtle,
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
                size: 16.w, color: ColorManager.of(context).textTertiary),
            SizedBox(width: 8.w),
            Text(
              isToday ? '${l10n.today}, $formatted' : formatted,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
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

  Widget _buildReminderRow(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => setState(() => _sendReminder = !_sendReminder),
      child: Row(
        children: [
          Icon(Icons.notifications_outlined,
              size: 18.w, color: ColorManager.of(context).textTertiary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              l10n.sendReminderToPatient,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: _sendReminder
                  ? ColorManager.primary
                  : ColorManager.of(context).cardBg,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: _sendReminder
                    ? ColorManager.primary
                    : ColorManager.of(context).border,
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

  Widget _sectionLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textSecondary,
        fontFamily: FontHelper.fontFamily(context),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Divider(color: ColorManager.of(context).divider),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP SUB-WIDGETS
// ═══════════════════════════════════════════════════════════════════════

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({
    required this.fontFamily,
    required this.selectedDate,
  });

  final String fontFamily;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: ColorManager.primary10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.event_available_rounded,
            size: 22,
            color: ColorManager.primary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.newAppointment,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: c.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Schedule a new visit and notify the patient.',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopSectionHeader extends StatelessWidget {
  const _DesktopSectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.fontFamily,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.primary10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: ColorManager.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopSectionDivider extends StatelessWidget {
  const _DesktopSectionDivider({required this.c});
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Divider(height: 1, color: c.borderLight),
    );
  }
}

class _DesktopReminderTile extends StatelessWidget {
  const _DesktopReminderTile({
    required this.value,
    required this.onChanged,
    required this.fontFamily,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: value
          ? ColorManager.primary.withValues(alpha: 0.06)
          : c.cardBgSecondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(!value),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: 17,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.sendReminderToPatient,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'The patient will receive a notification before the appointment.',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: ColorManager.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.fontFamily,
  });

  final IconData icon;
  final String label;
  final String? value;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final hasValue = value != null && value!.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 14, color: c.textSecondary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 11.5,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                  color: c.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                hasValue ? value! : '—',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: hasValue ? c.textPrimary : c.textSubtle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
