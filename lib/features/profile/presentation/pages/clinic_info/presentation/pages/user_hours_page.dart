import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<UserHoursBloc>(param1: userId)
            ..add(const UserHoursEvent.load()),
      child: _UserHoursContent(userName: userName),
    );
  }
}

class _UserHoursContent extends StatefulWidget {
  final String? userName;
  const _UserHoursContent({this.userName});

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

  _UserDay({
    this.id,
    required this.clinicWorkingDayId,
    required this.dayOfWeek,
    required this.isWorking,
    required this.isFullTime,
    required this.shifts,
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

  List<UserWorkingDayApiModel> _buildPayload() {
    return _days.map((d) {
      return UserWorkingDayApiModel(
        id: d.id,
        clinicWorkingDayId: d.clinicWorkingDayId,
        dayOfWeek: d.dayOfWeek,
        isWorking: d.isWorking,
        isFullTime: d.isFullTime,
        ranges: (d.isWorking && !d.isFullTime)
            ? d.shifts
                  .map(
                    (s) => TimeRangeModel(
                      startTime: _apiTime(s.from),
                      endTime: _apiTime(s.to),
                    ),
                  )
                  .toList()
            : [],
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
    setState(
      () => day.shifts.add(
        WorkingShift(
          from: const TimeOfDay(hour: 9, minute: 0),
          to: const TimeOfDay(hour: 17, minute: 0),
        ),
      ),
    );
  }

  void _removeShift(_UserDay day) {
    if (day.shifts.length <= 1) return;
    setState(() => day.shifts.removeLast());
  }

  void _onSave() {
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
        orElse: () => true,
      ),
      listenWhen: (prev, curr) => curr.maybeMap(
        saving: (_) => true,
        saved: (_) => true,
        error: (_) => true,
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
          error: (message) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showError(context, title: l10n.error, message: message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        // Hide the bottom save bar on the "no clinic hours yet" empty
        // state — the CTA inside the body is the only action there.
        final showSaveBar =
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
                    : l10n.workingHours,
                onBack: () => context.pop(),
              ),
              Expanded(
                child: state.maybeWhen(
                  loading: () => const _UserHoursSkeleton(),
                  error: (msg) => _buildError(msg, l10n),
                  needsClinicHours: (isAdmin) =>
                      _buildNeedsClinicHours(isAdmin, l10n),
                  loaded: (days, isSeed) {
                    if (!_populated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() => _populateFromApi(days, isSeed: isSeed));
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
      child: CustomCard(
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

  Widget _buildDayRow(
    _UserDay day, {
    required bool isLast,
    required AppLocalizations l10n,
  }) {
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
                    onTap: () => setState(() {
                      day.isWorking = !day.isWorking;
                      if (!day.isWorking && _expandedKey == key) {
                        _expandedKey = null;
                      }
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
                onChanged: (val) => setState(() => day.isFullTime = val),
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
                      onTap: () => _pickShiftTime(day, i, isFrom: true),
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
                      onTap: () => _pickShiftTime(day, i, isFrom: false),
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
