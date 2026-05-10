import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/manager/user_hours_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/cupertino_picker_sheet.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/day_toggle.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/helpers.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/shift_count_control.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/time_picker_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserHoursPage extends StatelessWidget {
  final String userId;
  final String? userName;

  const UserHoursPage({super.key, required this.userId, this.userName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserHoursBloc>(param1: userId)
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
        .map((d) => _DaySnapshot(
              d.dayOfWeek,
              d.isWorking,
              d.isFullTime,
              d.shifts
                  .map((s) =>
                      _ShiftSnapshot(s.from.hour, s.from.minute, s.to.hour, s.to.minute))
                  .toList(),
            ))
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

  void _populateFromApi(List<UserWorkingDayApiModel> apiDays) {
    final sorted = [...apiDays]..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));
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
    _initialSnapshot = _snapshot(_days);
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
                .map((s) => TimeRangeModel(
                      startTime: _formatTime(s.from),
                      endTime: _formatTime(s.to),
                    ))
                .toList()
            : [],
      );
    }).toList();
  }

  static String _formatTime(TimeOfDay t) {
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
      return '${formatTime(day.shifts[0].from)} – ${formatTime(day.shifts[0].to)}';
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
    setState(() => day.shifts.add(
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ));
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
      buildWhen: (prev, curr) => curr.maybeMap(
        loading: (_) => true,
        loaded: (_) => true,
        orElse: () => false,
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
            AppSnackbar.showError(
              context,
              title: l10n.error,
              message: message,
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        return Scaffold(
          backgroundColor: c.scaffoldBg,
          bottomNavigationBar: _days.isNotEmpty ? _buildSaveButton(l10n) : null,
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
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (msg) => _buildError(msg, l10n),
                  loaded: (days) {
                    if (!_populated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() => _populateFromApi(days));
                      });
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return _buildForm(l10n);
                  },
                  orElse: () => _populated
                      ? _buildForm(l10n)
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildError(String message, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 40.w, color: ColorManager.of(context).textTertiary),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => context
                  .read<UserHoursBloc>()
                  .add(const UserHoursEvent.load()),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    if (_days.isEmpty) {
      return Center(
        child: Text(
          l10n.noData,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textTertiary,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.workingHours,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
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

  Widget _buildSaveButton(AppLocalizations l10n) {
    final enabled = _hasChanges;
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GestureDetector(
        onTap: enabled ? _onSave : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: enabled
                ? ColorManager.primary
                : ColorManager.primary.withValues(alpha: 0.35),
            borderRadius: BorderRadiusManager.lg,
          ),
          child: Text(
            l10n.save,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
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
                ? () => setState(
                      () => _expandedKey = isExpanded ? null : key,
                    )
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
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: day.isWorking ? c.textPrimary : c.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    _daySummary(day, l10n),
                    style: TextStyle(
                      fontSize: 12.sp,
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
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: c.textTertiary,
                      ),
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
      this.dayOfWeek, this.isWorking, this.isFullTime, this.shifts);

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
