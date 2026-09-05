import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/manager/user_hours_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/cupertino_picker_sheet.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/day_toggle.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/shift_count_control.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/time_picker_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class UserHoursPage extends StatelessWidget {
  final String userId;
  final String? userName;

  const UserHoursPage({super.key, required this.userId, this.userName});

  /// Who may change a schedule: the clinic owner, or anyone holding the admin
  /// role. A member cannot edit their own hours - they open this same screen
  /// from the menu to *see* what has been set for them.
  ///
  /// Decided here rather than by each caller, so a new entry point cannot
  /// forget the rule and hand a member an editable form the API will refuse.
  bool get _canEdit => getIt<UserStorage>().isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserHoursBloc>(param1: userId)
        ..add(const UserHoursEvent.load()),
      child: _UserHoursContent(
        userName: userName,
        readOnly: !_canEdit,
        isSelf: getIt<TokenStorage>().getUserId() == userId,
      ),
    );
  }
}

class _UserHoursContent extends StatefulWidget {
  final String? userName;
  final bool readOnly;
  final bool isSelf;
  const _UserHoursContent({
    this.userName,
    this.readOnly = false,
    this.isSelf = false,
  });

  @override
  State<_UserHoursContent> createState() => _UserHoursContentState();
}

class _UserDay {
  final String? id;
  final String clinicWorkingDayId;
  final int dayOfWeek;
  bool isWorking;
  bool isFullTime;
  List<WorkingShift> shifts;

  /// Whether [shifts] came back from the server, as opposed to the default
  /// the form falls back to when a day has no stored ranges. A read-only view
  /// must not present a placeholder as though it were the real schedule.
  final bool hasStoredRanges;

  _UserDay({
    this.id,
    required this.clinicWorkingDayId,
    required this.dayOfWeek,
    required this.isWorking,
    required this.isFullTime,
    required this.shifts,
    this.hasStoredRanges = false,
  });

  static const _dayLabelsEn = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _dayLabelsAr = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  String get labelEn => _dayLabelsEn[(dayOfWeek - 1).clamp(0, 6)];
  String get labelAr => _dayLabelsAr[(dayOfWeek - 1).clamp(0, 6)];
}

class WorkingShift {
  TimeOfDay from;
  TimeOfDay to;
  WorkingShift({required this.from, required this.to});
}

class _UserHoursContentState extends State<_UserHoursContent> {
  String? _expandedKey;
  List<_UserDay> _days = [];
  bool _populated = false;

  List<_DaySnapshot> _initialSnapshot = [];

  /// The clinic's own schedule, keyed by the working-day id the user rows
  /// point at. Drives three things: the ranges a full-time day is saved with,
  /// the times a new shift starts from, and the bounds an edit is checked
  /// against. Empty when the schedule could not be read.
  Map<String, WorkingDayApiModel> _clinicById = {};
  Map<int, WorkingDayApiModel> _clinicByDow = {};

  /// Per-day validation messages, keyed the same way the rows are. Populated
  /// on save and cleared as the user edits.
  Map<int, String> _dayErrors = {};

  static const int _maxShifts = 3;

  List<_DaySnapshot> _snapshot(List<_UserDay> days) {
    return days
        .map(
          (d) => _DaySnapshot(
            d.dayOfWeek,
            d.isWorking,
            d.isFullTime,
            d.shifts
                .map(
                  (s) => _ShiftSnapshot(
                    s.from.hour,
                    s.from.minute,
                    s.to.hour,
                    s.to.minute,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  bool get _hasChanges {
    final current = _snapshot(_days);
    if (current.length != _initialSnapshot.length) return true;
    for (int i = 0; i < current.length; i++) {
      if (current[i] != _initialSnapshot[i]) return true;
    }
    return false;
  }

  void _populateFromApi(
    List<UserWorkingDayApiModel> apiDays, {
    bool isSeed = false,
  }) {
    final sorted = [...apiDays]
      ..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));
    _days = sorted.map((d) {
      return _UserDay(
        id: d.id,
        clinicWorkingDayId: d.clinicWorkingDayId,
        dayOfWeek: d.dayOfWeek,
        isWorking: d.isWorking,
        isFullTime: d.isFullTime,
        hasStoredRanges: d.ranges.isNotEmpty,
        shifts: d.ranges.isEmpty
            ? [
                WorkingShift(
                  from: const TimeOfDay(hour: 9, minute: 0),
                  to: const TimeOfDay(hour: 17, minute: 0),
                ),
              ]
            : d.ranges.map((r) {
                final fromParts = r.startTime.split(':');
                final toParts = r.endTime.split(':');
                return WorkingShift(
                  from: TimeOfDay(
                    hour: int.parse(fromParts[0]),
                    minute: int.parse(fromParts[1]),
                  ),
                  to: TimeOfDay(
                    hour: int.parse(toParts[0]),
                    minute: int.parse(toParts[1]),
                  ),
                );
              }).toList(),
      );
    }).toList();
    _populated = true;
    // For a seeded form (no hours on the server yet), leave the
    // baseline empty so `_hasChanges` is true from the start — the
    // user hasn't edited anything, but committing the defaults *is*
    // the change. After a successful save the [saved] listener
    // replaces this with the current snapshot.
    _initialSnapshot = isSeed ? const [] : _snapshot(_days);
  }

  void _indexClinicDays(List<WorkingDayApiModel> clinicDays) {
    _clinicById = {for (final d in clinicDays) d.id: d};
    _clinicByDow = {for (final d in clinicDays) d.dayOfWeek: d};
  }

  /// The clinic row a user row belongs to. Matched on the working-day id the
  /// server anchors each user row to, falling back to the weekday for a row
  /// seeded before those ids existed.
  WorkingDayApiModel? _clinicDayFor(_UserDay day) =>
      _clinicById[day.clinicWorkingDayId] ?? _clinicByDow[day.dayOfWeek];

  static int _minutes(TimeOfDay t) => t.hour * 60 + t.minute;

  static int _minutesOfApi(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Everything wrong with the form, by weekday. Empty means it is safe to
  /// send.
  ///
  /// The server enforces all of this too, but it answers with one error for
  /// the whole request and no clue which day it meant. Checking here means the
  /// user is told which row to fix, before anything is sent.
  Map<int, String> _validate(AppLocalizations l10n) {
    final errors = <int, String>{};

    for (final day in _days) {
      if (!day.isWorking) continue;

      final clinic = _clinicDayFor(day);
      // The clinic schedule is admin-only, so a non-admin form has nothing to
      // check against - leave those days to the server.
      if (clinic == null) continue;

      if (!clinic.isOpen) {
        errors[day.dayOfWeek] = l10n.dayClinicClosed;
        continue;
      }
      // A full-time day is saved with the clinic's own ranges, so it is inside
      // them by construction.
      if (day.isFullTime) continue;

      final shifts = [...day.shifts]
        ..sort((a, b) => _minutes(a.from).compareTo(_minutes(b.from)));

      String? error;
      for (var i = 0; i < shifts.length; i++) {
        final from = _minutes(shifts[i].from);
        final to = _minutes(shifts[i].to);

        if (to <= from) {
          error = l10n.dayEndBeforeStart;
          break;
        }
        // Sorted by start, so an overlap can only be with the one before it.
        if (i > 0 && from < _minutes(shifts[i - 1].to)) {
          error = l10n.dayShiftsOverlap;
          break;
        }
        final insideClinic = clinic.ranges.any(
          (r) =>
              from >= _minutesOfApi(r.startTime) &&
              to <= _minutesOfApi(r.endTime),
        );
        if (!insideClinic) {
          error = l10n.dayOutsideClinicHours;
          break;
        }
      }

      if (error != null) errors[day.dayOfWeek] = error;
    }

    return errors;
  }

  /// A shift to start from when a day is switched on or a shift is added.
  /// The clinic's first range where we know it - 9-to-5 was a guess that
  /// often fell outside the clinic's own hours and was rejected on save.
  WorkingShift _defaultShift(_UserDay day) {
    final clinic = _clinicDayFor(day);
    if (clinic != null && clinic.ranges.isNotEmpty) {
      final r = clinic.ranges.first;
      return WorkingShift(
          from: _timeOfApi(r.startTime), to: _timeOfApi(r.endTime));
    }
    return WorkingShift(
      from: const TimeOfDay(hour: 9, minute: 0),
      to: const TimeOfDay(hour: 17, minute: 0),
    );
  }

  static TimeOfDay _timeOfApi(String hhmm) {
    final parts = hhmm.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  List<UserWorkingDayApiModel> _buildPayload() {
    return _days.map((d) {
      return UserWorkingDayApiModel(
        id: d.id,
        clinicWorkingDayId: d.clinicWorkingDayId,
        dayOfWeek: d.dayOfWeek,
        isWorking: d.isWorking,
        isFullTime: d.isFullTime,
        // A full-time day is not just a flag: the API stores the times too,
        // and sending the toggle with an empty list saved a working day with
        // no hours in it. Send the clinic's own ranges for that day.
        ranges: !d.isWorking
            ? const []
            : d.isFullTime
                ? (_clinicDayFor(d)?.ranges ?? const [])
                : d.shifts
                    .map(
                      (s) => TimeRangeModel(
                        startTime: _apiTime(s.from),
                        endTime: _apiTime(s.to),
                      ),
                    )
                    .toList(),
      );
    }).toList();
  }

  /// Wire format for the working-hours payload — NOT for display. Times shown
  /// to the user go through `AppDate`, which localises them.
  static String _apiTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  String _dayLabel(_UserDay day) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? day.labelAr : day.labelEn;
  }

  String _daySummary(_UserDay day, AppLocalizations l10n) {
    if (!day.isWorking) return l10n.closed;
    if (day.isFullTime) return l10n.fullClinicHours;
    if (day.shifts.length == 1) {
      return '${AppDate.time12Of(context, day.shifts[0].from)} – '
          '${AppDate.time12Of(context, day.shifts[0].to)}';
    }
    return '${day.shifts.length} ${l10n.shifts}';
  }

  Future<void> _pickShiftTime(
    _UserDay day,
    int shiftIndex, {
    required bool isFrom,
  }) async {
    final shift = day.shifts[shiftIndex];
    final initial = isFrom ? shift.from : shift.to;
    final l10n = AppLocalizations.of(context)!;
    TimeOfDay selected = initial;

    await showCupertinoPickerSheet(
      context: context,
      cancelLabel: l10n.cancel,
      doneLabel: l10n.save,
      onDone: () => setState(() {
        if (isFrom) {
          shift.from = selected;
        } else {
          shift.to = selected;
        }
        // The row is being worked on; drop the stale complaint rather than
        // leaving it under a value the user has just changed.
        _dayErrors.remove(day.dayOfWeek);
      }),
      picker: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        initialDateTime: DateTime(2000, 1, 1, initial.hour, initial.minute),
        onDateTimeChanged: (dt) =>
            selected = TimeOfDay(hour: dt.hour, minute: dt.minute),
      ),
    );
  }

  void _addShift(_UserDay day) {
    if (day.shifts.length >= _maxShifts) return;
    setState(() {
      day.shifts.add(_defaultShift(day));
      _dayErrors.remove(day.dayOfWeek);
    });
  }

  void _removeShift(_UserDay day) {
    if (day.shifts.length <= 1) return;
    setState(() {
      day.shifts.removeLast();
      _dayErrors.remove(day.dayOfWeek);
    });
  }

  void _onSave() {
    final l10n = AppLocalizations.of(context)!;
    final errors = _validate(l10n);

    setState(() => _dayErrors = errors);
    if (errors.isNotEmpty) {
      // Every offending row is marked inline; the snackbar names the first so
      // the user knows to go looking without having to scan the list.
      final firstDay = _days.firstWhere(
        (d) => errors.containsKey(d.dayOfWeek),
      );
      AppSnackbar.showError(
        context,
        title: l10n.workingHoursInvalidTitle,
        message: '${_dayLabel(firstDay)}: ${errors[firstDay.dayOfWeek]}',
      );
      return;
    }

    context.read<UserHoursBloc>().add(UserHoursEvent.save(_buildPayload()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<UserHoursBloc, UserHoursState>(
      // Rebuild for every state the builder can render. Listing only
      // loading/loaded here left the shimmer on screen forever when the bloc
      // answered `needsClinicHours` or `error`, because the builder was never
      // called again. `saving`/`saved` are the exceptions: the listener owns
      // those, and rebuilding on them would flash the form.
      buildWhen: (prev, curr) => curr.maybeMap(
        saving: (_) => false,
        saved: (_) => false,
        // The listener owns this one too; rebuilding would drop the form back
        // to the state the bloc last emitted and lose the edits.
        saveFailed: (_) => false,
        orElse: () => true,
      ),
      listenWhen: (prev, curr) => curr.maybeMap(
        saving: (_) => true,
        saved: (_) => true,
        saveFailed: (_) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          saving: () {
            AppLoadingDialog.show(context: context, message: l10n.save);
          },
          saved: () {
            AppLoadingDialog.dismiss(context);
            setState(() => _initialSnapshot = _snapshot(_days));
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.saveChanges,
            );
          },
          // A rejected save reports itself in one place and leaves the form
          // alone. It used to also flip the body to the load-failure card,
          // which threw away the user's edits and told them the wrong thing -
          // "could not load working hours" - for a save that failed.
          saveFailed: (message) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showError(
              context,
              title: l10n.workingHoursSaveFailed,
              message: message,
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        // Hide the bottom save bar on the "no clinic hours yet" empty
        // state — the CTA inside the body is the only action there.
        final showSaveBar = !widget.readOnly &&
            _days.isNotEmpty &&
            state.maybeWhen(needsClinicHours: (_) => false, orElse: () => true);
        return Scaffold(
          backgroundColor: c.scaffoldBg,
          bottomNavigationBar: showSaveBar ? _buildSaveButton(l10n) : null,
          body: Column(
            children: [
              PageHeader(
                title: widget.userName != null && widget.userName!.isNotEmpty
                    ? '${l10n.workingHours} · ${widget.userName!}'
                    : widget.isSelf
                        ? l10n.myWorkingHours
                        : l10n.workingHours,
                onBack: () => context.pop(),
              ),
              Expanded(
                child: state.maybeWhen(
                  loading: () => const _UserHoursSkeleton(),
                  error: (msg) => _buildError(msg, l10n),
                  needsClinicHours: (isAdmin) =>
                      _buildNeedsClinicHours(isAdmin, l10n),
                  loaded: (days, isSeed, clinicDays) {
                    if (!_populated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _indexClinicDays(clinicDays);
                          _populateFromApi(days, isSeed: isSeed);
                        });
                      });
                      return const _UserHoursSkeleton();
                    }
                    return _buildForm(l10n);
                  },
                  orElse: () =>
                      _populated ? _buildForm(l10n) : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Empty state shown when the clinic itself has no working days yet.
  /// Admins get a CTA that routes to the clinic-working-days page —
  /// non-admins get a "ask your admin" message because the user-hours
  /// upsert requires `clinic_working_day_id`s only the admin can
  /// create.
  /// The clinic has no schedule yet, so per-user hours cannot be set. An
  /// admin gets the fix as a button; everyone else gets told who to ask.
  Widget _buildNeedsClinicHours(bool isAdmin, AppLocalizations l10n) {
    return DentaRefresh(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
        child: StateCard(
          icon: Icons.schedule_outlined,
          title: l10n.clinicWorkingDaysMissingTitle,
          message: isAdmin
              ? l10n.clinicWorkingDaysMissingAdminMessage
              : l10n.clinicWorkingDaysMissingNonAdminMessage,
          actionLabel: isAdmin ? l10n.setClinicWorkingDays : null,
          onAction: isAdmin
              ? () => context.pushNamed(AppRoutesNames.workingDays)
              : null,
        ),
      ),
    );
  }

  Widget _buildError(String message, AppLocalizations l10n) {
    return DentaRefresh(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
        child: StateCard(
          icon: Icons.cloud_off_rounded,
          tone: ColorManager.error,
          title: l10n.workingHoursLoadFailed,
          message: message,
          actionLabel: l10n.retry,
          onAction: () =>
              context.read<UserHoursBloc>().add(const UserHoursEvent.load()),
        ),
      ),
    );
  }

  /// Pull-to-refresh is offered on the two states with nothing to lose - the
  /// failure card and the "clinic has no schedule yet" card. Once the form is
  /// populated it may hold unsaved edits a refetch would throw away.
  Future<void> _refresh() async {
    final bloc = context.read<UserHoursBloc>();
    bloc.add(const UserHoursEvent.load());
    await bloc.stream.settled(
      (state) => state.maybeWhen(loading: () => false, orElse: () => true),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    if (_days.isEmpty) {
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
        child: StateCard(icon: Icons.schedule_outlined, title: l10n.noData),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // A member sees this screen without a save bar or a live control on
          // it; say why, or it just looks broken.
          if (widget.readOnly) ...[
            _ReadOnlyNote(message: l10n.workingHoursReadOnlyNote),
            SizedBox(height: 10.h),
          ],
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.workingHours,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                ..._days.asMap().entries.map(
                      (e) => _buildDayRow(
                        e.value,
                        isLast: e.key == _days.length - 1,
                        l10n: l10n,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Docked primary action on its own surface, in the thumb arc.
  Widget _buildSaveButton(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: scaffoldBottomInset(context)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          child: DentaButton(
            label: l10n.save,
            expand: true,
            onTap: _hasChanges ? _onSave : null,
          ),
        ),
      ),
    );
  }

  /// One day, as a line of text: whether it is worked, and the hours if so.
  ///
  /// No expander either - everything the row has to say fits on it, so there
  /// is nothing behind a disclosure to go looking for.
  Widget _buildReadOnlyDayRow(
    _UserDay day, {
    required bool isLast,
    required AppLocalizations l10n,
  }) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final working = day.isWorking;

    // Full-time days follow the clinic, so show the clinic's own ranges
    // rather than the placeholder shifts the form keeps for editing.
    final clinic = _clinicDayFor(day);
    final List<String> lines;
    if (!working) {
      lines = [l10n.closed];
    } else if (day.isFullTime) {
      // The member's own record already carries the times, and reading the
      // clinic schedule is admin-only - so their row is the source here, with
      // the clinic's as a fallback for an admin looking at a legacy row that
      // was saved before full-time days stored any ranges.
      final ranges = day.hasStoredRanges
          ? day.shifts
              .map((sh) => '${AppDate.time12Of(context, sh.from)} - '
                  '${AppDate.time12Of(context, sh.to)}')
              .toList()
          : (clinic?.ranges ?? const [])
              .map(
                (r) =>
                    '${AppDate.time12Of(context, _timeOfApi(r.startTime))} - '
                    '${AppDate.time12Of(context, _timeOfApi(r.endTime))}',
              )
              .toList();
      lines = ranges.isEmpty ? [l10n.fullClinicHours] : ranges;
    } else {
      lines = day.shifts
          .map(
            (sh) => '${AppDate.time12Of(context, sh.from)} - '
                '${AppDate.time12Of(context, sh.to)}',
          )
          .toList();
    }

    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A filled dot for a working day, a hollow one for a day off - the
          // state a toggle used to carry, without pretending to be one.
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: working ? ColorManager.success : Colors.transparent,
                border: working
                    ? null
                    : Border.all(color: c.textSubtle, width: 1.5),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              _dayLabel(day),
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: working ? c.textPrimary : c.textTertiary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < lines.length; i++) ...[
                if (i > 0) SizedBox(height: 3.h),
                Text(
                  lines[i],
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontFamily: family,
                    color: working ? c.textSecondary : c.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayRow(
    _UserDay day, {
    required bool isLast,
    required AppLocalizations l10n,
  }) {
    // A member gets a different row, not the editable one with its controls
    // switched off. A greyed toggle still reads as a toggle - it invites a tap
    // and then ignores it. This one has nothing to press.
    if (widget.readOnly) {
      return _buildReadOnlyDayRow(day, isLast: isLast, l10n: l10n);
    }

    final key = day.clinicWorkingDayId.isNotEmpty
        ? day.clinicWorkingDayId
        : 'd${day.dayOfWeek}';
    final isExpanded = _expandedKey == key;
    final c = ColorManager.of(context);

    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: day.isWorking
                ? () => setState(() => _expandedKey = isExpanded ? null : key)
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.readOnly
                        ? null
                        : () => setState(() {
                              day.isWorking = !day.isWorking;
                              if (!day.isWorking && _expandedKey == key) {
                                _expandedKey = null;
                              }
                              _dayErrors.remove(day.dayOfWeek);
                            }),
                    child: DayToggle(enabled: day.isWorking),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _dayLabel(day),
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                        color: day.isWorking ? c.textPrimary : c.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    _daySummary(day, l10n),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: day.isWorking ? c.textSecondary : c.textTertiary,
                    ),
                  ),
                  if (day.isWorking) ...[
                    SizedBox(width: 6.w),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20.w,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Sits outside the expander on purpose: a row can fail validation
          // while collapsed, and an error the user has to open a panel to see
          // is an error they will not find.
          if (_dayErrors.containsKey(day.dayOfWeek))
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 14.w,
                    color: ColorManager.error,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      _dayErrors[day.dayOfWeek]!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.4,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildPanel(day, l10n),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(_UserDay day, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full clinic hours toggle
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.fullClinicHours,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: c.textSecondary,
                  ),
                ),
              ),
              Switch.adaptive(
                value: day.isFullTime,
                onChanged: widget.readOnly
                    ? null
                    : (val) => setState(() {
                          day.isFullTime = val;
                          _dayErrors.remove(day.dayOfWeek);
                        }),
                activeThumbColor: ColorManager.primary,
                activeTrackColor: ColorManager.primary.withValues(alpha: 0.4),
              ),
            ],
          ),
          if (!day.isFullTime) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  l10n.shifts,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: c.textSecondary,
                  ),
                ),
                const Spacer(),
                if (!widget.readOnly)
                  ShiftCountControl(
                    count: day.shifts.length,
                    canDecrement: day.shifts.length > 1,
                    canIncrement: day.shifts.length < _maxShifts,
                    onDecrement: () => _removeShift(day),
                    onIncrement: () => _addShift(day),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            for (int i = 0; i < day.shifts.length; i++) ...[
              if (day.shifts.length > 1) ...[
                Text(
                  l10n.shiftNumber(i + 1),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
                SizedBox(height: 6.h),
              ],
              Row(
                children: [
                  Expanded(
                    child: TimePickerField(
                      label: l10n.from,
                      time: day.shifts[i].from,
                      onTap: widget.readOnly
                          ? () {}
                          : () => _pickShiftTime(day, i, isFrom: true),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      '–',
                      style: TextStyle(fontSize: 16.sp, color: c.textTertiary),
                    ),
                  ),
                  Expanded(
                    child: TimePickerField(
                      label: l10n.to,
                      time: day.shifts[i].to,
                      onTap: widget.readOnly
                          ? () {}
                          : () => _pickShiftTime(day, i, isFrom: false),
                    ),
                  ),
                ],
              ),
              if (i < day.shifts.length - 1) SizedBox(height: 12.h),
            ],
          ],
        ],
      ),
    );
  }
}

// ─── Snapshot classes for dirty-checking ────────────────────────────────

class _ShiftSnapshot {
  final int fromH, fromM, toH, toM;
  const _ShiftSnapshot(this.fromH, this.fromM, this.toH, this.toM);

  @override
  bool operator ==(Object other) =>
      other is _ShiftSnapshot &&
      fromH == other.fromH &&
      fromM == other.fromM &&
      toH == other.toH &&
      toM == other.toM;

  @override
  int get hashCode => Object.hash(fromH, fromM, toH, toM);
}

class _DaySnapshot {
  final int dayOfWeek;
  final bool isWorking;
  final bool isFullTime;
  final List<_ShiftSnapshot> shifts;
  const _DaySnapshot(
    this.dayOfWeek,
    this.isWorking,
    this.isFullTime,
    this.shifts,
  );

  @override
  bool operator ==(Object other) {
    if (other is! _DaySnapshot) return false;
    if (dayOfWeek != other.dayOfWeek ||
        isWorking != other.isWorking ||
        isFullTime != other.isFullTime) {
      return false;
    }
    if (shifts.length != other.shifts.length) return false;
    for (int i = 0; i < shifts.length; i++) {
      if (shifts[i] != other.shifts[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      Object.hash(dayOfWeek, isWorking, isFullTime, Object.hashAll(shifts));
}

/// Holds the hours card at full height while the schedule loads.
/// Quiet explanation shown to a member: the screen has no controls because
/// only the clinic's admin may change a schedule.
class _ReadOnlyNote extends StatelessWidget {
  const _ReadOnlyNote({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, size: 16.w, color: c.textTertiary),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11.5.sp,
                height: 1.4,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHoursSkeleton extends StatelessWidget {
  const _UserHoursSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return AppShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        children: [
          Container(
            height: 380.h,
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: c.borderLight),
            ),
          ),
        ],
      ),
    );
  }
}
