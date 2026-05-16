import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/create_appointment_use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_available_slots_use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_clinic_doctors_use_case.dart';
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

  /// Bumped after a successful POST so other screens (home's today's
  /// schedule, etc.) can refresh without owning the create flow.
  static final ValueNotifier<int> created = ValueNotifier<int>(0);

  @override
  State<NewAppointmentPage> createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  // Patients
  List<PatientEntity> _patients = [];
  bool _isPatientsLoading = true;
  PatientEntity? _selectedPatientEntity;

  // Doctors
  List<ClinicDoctorEntity> _doctors = [];
  ClinicDoctorEntity? _selectedDoctor;
  bool _isDoctorsLoading = true;

  // Date / duration / slots
  DateTime _selectedDate = DateTime.now();
  int _duration = 30;
  String? _selectedSlot;
  List<String> _availableSlots = [];
  bool _isSlotsLoading = false;

  // VIP appointments bypass the doctor's schedule and surface every slot
  // returned by the server.
  bool _isVip = false;

  bool _sendReminder = true;

  final List<Map<String, dynamic>> _durations = [
    {'label': '15m', 'value': 15},
    {'label': '30m', 'value': 30},
    {'label': '45m', 'value': 45},
    {'label': '1h', 'value': 60},
    {'label': '1h 15m', 'value': 75},
    {'label': '1h 30m', 'value': 90},
    {'label': '1h 45m', 'value': 105},
    {'label': '2h', 'value': 120},
  ];

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _loadDoctors();
    // Slots can't be fetched yet — they need a doctor — so we wait until
    // the user picks one (or until the doctors load and we auto-select
    // the only available doctor).
  }

  Future<void> _loadDoctors() async {
    final result = await getIt<GetClinicDoctorsUseCase>()(NoParams());
    if (!mounted) return;
    result.fold(
      (error) {
        setState(() => _isDoctorsLoading = false);
        AppSnackbar.showError(context,
            title: AppLocalizations.of(context)!.error,
            message: NetworkExceptions.getErrorMessage(error));
      },
      (doctors) {
        setState(() {
          _doctors = doctors;
          _isDoctorsLoading = false;
          // If there's only one doctor, auto-select them so the user can
          // immediately see slots without an extra tap.
          if (doctors.length == 1) {
            _selectedDoctor = doctors.first;
          }
        });
        if (_selectedDoctor != null) {
          _loadAvailableSlots();
        }
      },
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadPatients() async {
    final result = await getIt<GetAllPatientsUseCase>()(1);
    if (!mounted) return;
    result.fold(
      (error) {
        setState(() => _isPatientsLoading = false);
        AppSnackbar.showError(context,
            title: AppLocalizations.of(context)!.error,
            message: NetworkExceptions.getErrorMessage(error));
      },
      (response) {
        setState(() {
          _patients = response.data;
          _isPatientsLoading = false;
        });
      },
    );
  }

  Future<void> _loadAvailableSlots() async {
    // Slots depend on the doctor — bail until one is picked.
    if (_selectedDoctor == null) {
      setState(() {
        _isSlotsLoading = false;
        _selectedSlot = null;
        _availableSlots = [];
      });
      return;
    }

    setState(() {
      _isSlotsLoading = true;
      _selectedSlot = null;
      _availableSlots = [];
    });

    final result = await getIt<GetAvailableSlotsUseCase>()(
      GetAvailableSlotsParams(
        date: _selectedDate,
        durationMinutes: _duration,
        doctorId: _selectedDoctor!.id,
        isVip: _isVip,
      ),
    );

    if (!mounted) return;
    result.fold(
      (error) {
        setState(() => _isSlotsLoading = false);
        AppSnackbar.showError(context,
            title: AppLocalizations.of(context)!.error,
            message: NetworkExceptions.getErrorMessage(error));
      },
      (slots) {
        setState(() {
          _availableSlots = slots;
          _isSlotsLoading = false;
        });
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime tempDate = _selectedDate;

    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
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
    if (_selectedDoctor == null) {
      AppSnackbar.showWarning(context,
          title: l10n.missingData, message: l10n.pleaseSelectADoctor);
      return;
    }
    if (_selectedSlot == null) {
      AppSnackbar.showWarning(context,
          title: l10n.missingData,
          message: l10n.pleaseSelectAnAvailableTimeSlot);
      return;
    }

    final start = _slotToDateTime(_selectedSlot!);
    final end = start.add(Duration(minutes: _duration));

    final params = CreateAppointmentParams(
      patientId: _selectedPatientEntity!.id,
      doctorId: _selectedDoctor!.id,
      startTime: start,
      endTime: end,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      notifyPatient: _sendReminder,
    );

    AppLoadingDialog.show(context: context, message: l10n.savingAppointment);

    final result = await getIt<CreateAppointmentUseCase>()(params);

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
        NewAppointmentPage.created.value++;
        context.pop();
      },
    );
  }

  /// Combines `_selectedDate` with a slot string like `13:30` or `13:30:00`.
  DateTime _slotToDateTime(String slot) {
    final parts = slot.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts.length > 1 ? int.parse(parts[1]) : 0;
    final second = parts.length > 2 ? int.parse(parts[2]) : 0;
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      hour,
      minute,
      second,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        _buildPatientPickerSkeleton()
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

                      _sectionLabel(l10n.doctor),
                      SizedBox(height: 10.h),
                      _buildDoctorChips(l10n),

                      _divider(),

                      _sectionLabel(l10n.duration),
                      SizedBox(height: 10.h),
                      _buildDurationChips(),

                      _divider(),

                      _buildDateRow(l10n),

                      _divider(),

                      _buildVipSwitch(l10n),

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

  Widget _buildDoctorChips(AppLocalizations l10n) {
    if (_isDoctorsLoading) {
      return _buildChipRowSkeleton(count: 3, chipWidth: 90.w);
    }
    if (_doctors.isEmpty) {
      return Text(
        l10n.noData,
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.of(context).textSubtle,
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < _doctors.length; i++) ...[
            if (i > 0) SizedBox(width: 8.w),
            SelectableChip(
              label: _doctors[i].name.isNotEmpty ? _doctors[i].name : '—',
              isSelected: _selectedDoctor?.id == _doctors[i].id,
              onTap: () {
                setState(() => _selectedDoctor = _doctors[i]);
                _loadAvailableSlots();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVipSwitch(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: () {
        setState(() => _isVip = !_isVip);
        _loadAvailableSlots();
      },
      child: Row(
        children: [
          Icon(Icons.workspace_premium_outlined,
              size: 18.w, color: c.textTertiary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.vipAppointment,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  l10n.vipAppointmentSubtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isVip,
            onChanged: (val) {
              setState(() => _isVip = val);
              _loadAvailableSlots();
            },
            activeThumbColor: ColorManager.primary,
            activeTrackColor: ColorManager.primary.withValues(alpha: 0.4),
          ),
        ],
      ),
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
    if (_isSlotsLoading) {
      return _buildChipRowSkeleton(count: 6, chipWidth: 64.w, radius: 10);
    }
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < _availableSlots.length; i++) ...[
            if (i > 0) SizedBox(width: 8.w),
            SelectableChip(
              label: _availableSlots[i],
              isSelected: _selectedSlot == _availableSlots[i],
              onTap: () =>
                  setState(() => _selectedSlot = _availableSlots[i]),
              borderRadius: 10,
            ),
          ],
        ],
      ),
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
              color: _sendReminder ? ColorManager.primary : ColorManager.of(context).cardBg,
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

  // ─── Loading skeletons ──────────────────────────────────────────────────

  Widget _buildPatientPickerSkeleton() {
    final fill = ColorManager.of(context).shimmerBase;
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field placeholder
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 10.h),
          // "Add new patient" link placeholder
          Container(
            width: 160.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipRowSkeleton({
    required int count,
    required double chipWidth,
    double radius = 20,
  }) {
    final fill = ColorManager.of(context).shimmerBase;
    return AppShimmer(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Container(
                width: chipWidth,
                height: 36.h,
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(radius.r),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
