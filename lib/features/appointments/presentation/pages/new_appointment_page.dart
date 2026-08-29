import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/create_appointment_use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_available_slots_use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_clinic_doctors_use_case.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/patient_picker.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_patients_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  final _scrollController = ScrollController();
  final _notesController = TextEditingController();

  // Patients
  List<PatientEntity> _patients = [];
  bool _isPatientsLoading = true;
  PatientEntity? _selectedPatientEntity;

  // Doctors
  List<ClinicDoctorEntity> _doctors = [];
  ClinicDoctorEntity? _selectedDoctor;
  bool _isDoctorsLoading = true;

  /// How deep the available-times strip stacks before it scrolls sideways.
  static const int _slotRows = 3;

  // Date / duration / slots
  DateTime _selectedDate = DateTime.now();
  int _duration = 30;
  String? _selectedSlot;
  List<String> _availableSlots = [];
  bool _isSlotsLoading = false;
  // Working-hours fallback flags — only meaningful when [_availableSlots]
  // came back empty. Distinguish "no hours saved at all" (needs setup)
  // from "user just doesn't work on the selected weekday" so the UI can
  // offer the right CTA.
  bool _hasNoWorkingHours = false;
  bool _doesNotWorkSelectedDay = false;

  // VIP appointments bypass the doctor's schedule and surface every slot
  // returned by the server.
  bool _isVip = false;

  bool _sendReminder = true;

  /// Which of the three required choices are still unanswered. Populated on
  /// the first save attempt and kept current after that, so a fixed field
  /// clears its own error without another save.
  _AppointmentErrors _errors = _AppointmentErrors.none;
  bool _submitted = false;

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
        AppSnackbar.showError(
          context,
          title: AppLocalizations.of(context)!.error,
          message: NetworkExceptions.getErrorMessage(error),
        );
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
    _scrollController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadPatients() async {
    final result = await getIt<GetAllPatientsUseCase>()(1);
    if (!mounted) return;
    result.fold(
      (error) {
        setState(() => _isPatientsLoading = false);
        AppSnackbar.showError(
          context,
          title: AppLocalizations.of(context)!.error,
          message: NetworkExceptions.getErrorMessage(error),
        );
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
        _hasNoWorkingHours = false;
        _doesNotWorkSelectedDay = false;
      });
      return;
    }

    setState(() {
      _isSlotsLoading = true;
      _selectedSlot = null;
      _availableSlots = [];
      _hasNoWorkingHours = false;
      _doesNotWorkSelectedDay = false;
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

    // Early-return pattern so we can `await` the working-hours fallback
    // when slots are empty — fold's sync callbacks can't await.
    final failure = result.fold((l) => l, (_) => null);
    if (failure != null) {
      setState(() => _isSlotsLoading = false);
      AppSnackbar.showError(
        context,
        title: AppLocalizations.of(context)!.error,
        message: NetworkExceptions.getErrorMessage(failure),
      );
      return;
    }

    final slots = result.getOrElse(() => const []);
    if (slots.isNotEmpty) {
      setState(() {
        _availableSlots = slots;
        _isSlotsLoading = false;
      });
      return;
    }

    // Slots are empty — diagnose why. We can only check the *current*
    // user's hours (the `my-hours` endpoint is token-scoped); if the
    // appointment is being booked for another doctor we fall back to
    // the generic "no slots" message without the CTA.
    final currentUserId = getIt<TokenStorage>().getUserId();
    final isSelf =
        currentUserId != null &&
        currentUserId.isNotEmpty &&
        _selectedDoctor!.id == currentUserId;
    if (!isSelf) {
      setState(() => _isSlotsLoading = false);
      return;
    }

    final hoursResult = await getIt<WorkingDaysRepository>().getMyHours();
    if (!mounted) return;
    hoursResult.fold((_) => setState(() => _isSlotsLoading = false), (hours) {
      // Dart's DateTime.weekday is 1=Mon..7=Sun — same convention the
      // working-days API uses, so we can compare directly.
      final selectedDow = _selectedDate.weekday;
      final hasAnyWorkingHours = hours.any((h) => h.isWorking);
      final worksOnDay = hours.any(
        (h) => h.dayOfWeek == selectedDow && h.isWorking,
      );
      setState(() {
        _isSlotsLoading = false;
        _hasNoWorkingHours = !hasAnyWorkingHours;
        _doesNotWorkSelectedDay = hasAnyWorkingHours && !worksOnDay;
      });
    });
  }

  /// Routes the user to the page that actually fixes the empty-slots
  /// situation for their role: admins manage clinic-wide working days
  /// (every doctor's personal hours live on top of that schedule), so
  /// they go to the clinic working-days page; dentists / other roles
  /// can only edit their own hours, so they go to the user-hours page.
  void _navigateToHoursPage() {
    final isAdmin = getIt<UserStorage>().isAdmin;
    if (isAdmin) {
      context.pushNamed(AppRoutesNames.workingDays);
      return;
    }
    final userId = getIt<TokenStorage>().getUserId() ?? '';
    if (userId.isEmpty) return;
    context.pushNamed(
      AppRoutesNames.userHours,
      pathParameters: {'userId': userId},
    );
  }

  _AppointmentErrors _validate() {
    final l10n = AppLocalizations.of(context)!;
    return _AppointmentErrors(
      patient: _selectedPatientEntity == null
          ? l10n.pleaseSelectAPatient
          : null,
      doctor: _selectedDoctor == null ? l10n.pleaseSelectADoctor : null,
      slot: _selectedSlot == null ? l10n.pleaseSelectAnAvailableTimeSlot : null,
    );
  }

  void _revalidate() {
    if (!_submitted) return;
    final next = _validate();
    if (next != _errors) setState(() => _errors = next);
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    final picked = await DatePickerSheet.show(
      context,
      title: l10n.date,
      initial: _selectedDate,
      minimum: DateTime.now().subtract(const Duration(days: 1)),
      maximum: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() => _selectedDate = picked);
    _loadAvailableSlots();
  }

  Future<void> _saveAppointment() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    final errors = _validate();

    setState(() {
      _submitted = true;
      _errors = errors;
    });

    if (errors.hasAny) {
      // Patient is the first required choice on the page, so the top of the
      // scroll is where the earliest unanswered one always is.
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      AppSnackbar.showWarning(
        context,
        title: l10n.missingData,
        message: l10n.checkHighlightedFields,
      );
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
        AppSnackbar.showError(
          context,
          title: l10n.error,
          message: NetworkExceptions.getErrorMessage(error),
        );
      },
      (_) {
        AppSnackbar.showSuccess(
          context,
          title: l10n.appointmentScheduled,
          message: l10n.successfullyAddedToCalendar,
        );
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
    final c = ColorManager.of(context);
    final isDesktop = Responsive.isDesktop(context);

    // The four sections are built once and then arranged per form factor:
    // one column on a phone, two side by side on a desktop window. Only the
    // arrangement differs, so a field cannot exist in one layout and not the
    // other.
    final patientSection = FormSectionCard(
      title: l10n.patient,
      children: [
        if (_isPatientsLoading)
          _buildPatientPickerSkeleton()
        else
          PatientPicker(
            patients: _patients.map((p) => p.name).toList(),
            selectedPatient: _selectedPatientEntity?.name,
            onPatientChanged: (name) {
              final entity = name != null
                  ? _patients.firstWhere((p) => p.name == name)
                  : null;
              setState(() => _selectedPatientEntity = entity);
              _revalidate();
            },
            onAddNewPatient: () => context.pushNamed(AppRoutesNames.addPatient),
          ),
        if (_errors.patient != null) FormErrorLine(message: _errors.patient!),
      ],
    );

    final doctorSection = FormSectionCard(
      title: l10n.doctor,
      children: [
        _buildDoctorChips(l10n),
        if (_errors.doctor != null) FormErrorLine(message: _errors.doctor!),
      ],
    );

    final scheduleSection = FormSectionCard(
      title: l10n.schedule,
      children: [
        FormDateField(
          label: l10n.date,
          value: _selectedDate,
          onTap: _selectDate,
        ),
        FormFieldShell(label: l10n.duration, child: _buildDurationChips()),
        _buildVipSwitch(l10n),
        FormFieldShell(
          label: l10n.availableSlots,
          required: true,
          errorText: _errors.slot,
          child: _buildSlots(l10n),
        ),
      ],
    );

    final notesSection = FormSectionCard(
      title: l10n.notes,
      children: [
        FormTextField(
          label: '',
          controller: _notesController,
          maxLines: 3,
          hintText: l10n.addNotesForAppointment,
        ),
        _buildReminderRow(l10n),
      ],
    );

    // Who and what on one side, when on the other. The slot grid is by far
    // the tallest block, so pairing it against the three short sections is
    // what actually removes the scroll rather than just narrowing it.
    final Widget formBody = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    patientSection,
                    const SizedBox(height: 12),
                    doctorSection,
                    const SizedBox(height: 12),
                    notesSection,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: scheduleSection),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              patientSection,
              SizedBox(height: 8.h),
              doctorSection,
              SizedBox(height: 8.h),
              scheduleSection,
              SizedBox(height: 8.h),
              notesSection,
            ],
          );

    return AdaptivePageScaffold(
      title: l10n.newAppointment,
      onBack: () => context.pop(),
      backgroundColor: c.scaffoldBg,
      breadcrumb: l10n.appointments,
      mobileHeader: FormTopBar(
        title: l10n.newAppointment,
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: AdaptiveContentWidth(
          maxWidth: isDesktop ? 1080 : 780,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: isDesktop
                  ? const EdgeInsets.fromLTRB(24, 20, 24, 24)
                  : EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
              child: Form(key: _formKey, child: formBody),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FormActionBar(
        maxWidth: isDesktop ? 1080 : 780,
        label: l10n.save,
        onPressed: _saveAppointment,
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
          fontSize: 11.5.sp,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.of(context).textTertiary,
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
            FormChip(
              label: _doctors[i].name.isNotEmpty ? _doctors[i].name : '—',
              selected: _selectedDoctor?.id == _doctors[i].id,
              onTap: () {
                setState(() => _selectedDoctor = _doctors[i]);
                _revalidate();
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
          Icon(
            Icons.workspace_premium_outlined,
            size: 16.w,
            color: c.textTertiary,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.vipAppointment,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
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
          Switch(
            value: _isVip,
            onChanged: (val) {
              setState(() => _isVip = val);
              _loadAvailableSlots();
            },
            activeThumbColor: ColorManager.white,
            activeTrackColor: ColorManager.primary,
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
        return FormChip(
          label: d['label'],
          selected: _duration == d['value'],
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
      return _buildSlotGridSkeleton();
    }
    if (_availableSlots.isEmpty) {
      // Three empty states, most specific first:
      //   1. Doctor hasn't set up any working hours → strong CTA.
      //   2. Working hours exist but not for the selected weekday →
      //      hint + lighter CTA.
      //   3. Hours exist for the day but no slots are free → original
      //      generic message.
      // Admins route to the clinic working-days page (their fix lives
      // there); everyone else goes to their personal user-hours page.
      final isAdmin = getIt<UserStorage>().isAdmin;
      if (_hasNoWorkingHours) {
        return _SlotsEmptyHoursCta(
          title: isAdmin
              ? l10n.clinicWorkingDaysMissingTitle
              : l10n.noWorkingHoursTitle,
          message: isAdmin
              ? l10n.clinicWorkingDaysMissingAdminMessage
              : l10n.noWorkingHoursMessage,
          buttonLabel: isAdmin
              ? l10n.setClinicWorkingDays
              : l10n.setWorkingHours,
          onPressed: _navigateToHoursPage,
        );
      }
      if (_doesNotWorkSelectedDay) {
        return _SlotsEmptyHoursCta(
          title: l10n.notWorkingOnThisDayTitle,
          message: l10n.notWorkingOnThisDayMessage,
          buttonLabel: isAdmin
              ? l10n.setClinicWorkingDays
              : l10n.updateWorkingHours,
          onPressed: _navigateToHoursPage,
        );
      }
      return Text(
        l10n.noAvailableSlotsForThisDate,
        style: TextStyle(
          fontSize: 11.5.sp,
          height: 1.4,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.of(context).textTertiary,
        ),
      );
    }

    // Desktop has the width a phone does not: every slot wraps into view at
    // once, so nothing is hidden behind a sideways scroll the mouse has no
    // obvious way to drive.
    if (Responsive.isDesktop(context)) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final slot in _availableSlots) _slotChip(slot),
        ],
      );
    }

    // A full working day is 30-odd slots. On one row that is a long scroll
    // whose far end is easy to miss, so they stack three deep and the strip
    // scrolls a third as far. Each column holds three consecutive times, so
    // the sequence still reads down-then-across in order.
    final columns = <List<String>>[];
    for (var i = 0; i < _availableSlots.length; i += _slotRows) {
      final end = (i + _slotRows).clamp(0, _availableSlots.length);
      columns.add(_availableSlots.sublist(i, end));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var col = 0; col < columns.length; col++) ...[
            if (col > 0) SizedBox(width: 8.w),
            // A short column - the last one, when the count is not a
            // multiple of three - keeps its chips the width of the rest.
            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var row = 0; row < columns[col].length; row++) ...[
                    if (row > 0) SizedBox(height: 8.h),
                    _slotChip(columns[col][row]),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReminderRow(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => setState(() => _sendReminder = !_sendReminder),
      child: Row(
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 16.w,
            color: ColorManager.of(context).textTertiary,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              l10n.sendReminderToPatient,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          Switch(
            value: _sendReminder,
            onChanged: (val) => setState(() => _sendReminder = val),
            activeThumbColor: ColorManager.white,
            activeTrackColor: ColorManager.primary,
          ),
        ],
      ),
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

  Widget _slotChip(String slot) => FormChip(
    label: slot,
    selected: _selectedSlot == slot,
    onTap: () {
      setState(() => _selectedSlot = slot);
      _revalidate();
    },
    radius: 10,
  );

  /// Same three-row strip as the real chips, so the block does not resize
  /// under the user when the slots land.
  Widget _buildSlotGridSkeleton() {
    final fill = ColorManager.of(context).shimmerBase;
    if (Responsive.isDesktop(context)) {
      return AppShimmer(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < 12; i++)
              Container(
                width: 64.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
          ],
        ),
      );
    }
    return AppShimmer(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var col = 0; col < 5; col++) ...[
              if (col > 0) SizedBox(width: 8.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var row = 0; row < _slotRows; row++) ...[
                    if (row > 0) SizedBox(height: 8.h),
                    Container(
                      width: 64.w,
                      height: 34.h,
                      decoration: BoxDecoration(
                        color: fill,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
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
                height: 34.h,
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

/// Empty-state block shown in place of the slot chips when the user has
/// no usable working hours for the picked date. Renders a title + body
/// + a primary button that routes to the user-hours page.
class _SlotsEmptyHoursCta extends StatelessWidget {
  const _SlotsEmptyHoursCta({
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: ColorManager.primary.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule_outlined,
                size: 16.w,
                color: ColorManager.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontFamily: fontFamily,
              color: c.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          FilledButton.icon(
            onPressed: onPressed,
            // Sized by its own padding rather than a fixed box, so a tall
            // Cairo line box grows the button instead of being clipped.
            style: FilledButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              minimumSize: Size(double.infinity, 42.h),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Icons.arrow_forward_rounded, size: 15.w),
            label: Text(
              buttonLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5.sp,
                height: 1.4,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The three choices this form cannot be submitted without. Compared by value
/// so a rebuild only happens when a message actually changes.
class _AppointmentErrors {
  const _AppointmentErrors({this.patient, this.doctor, this.slot});

  final String? patient;
  final String? doctor;
  final String? slot;

  static const _AppointmentErrors none = _AppointmentErrors();

  bool get hasAny => patient != null || doctor != null || slot != null;

  @override
  bool operator ==(Object other) =>
      other is _AppointmentErrors &&
      other.patient == patient &&
      other.doctor == doctor &&
      other.slot == slot;

  @override
  int get hashCode => Object.hash(patient, doctor, slot);
}
