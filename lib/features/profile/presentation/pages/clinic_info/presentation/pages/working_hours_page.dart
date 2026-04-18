import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/manager/working_hours_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/day_toggle.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/holiday_item.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/shift_count_control.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/time_picker_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/add_holiday_sheet.dart';
import '../widgets/clinic_info_models.dart';
import '../widgets/helpers.dart';
import '../widgets/cupertino_picker_sheet.dart';

class WorkingHoursPage extends StatelessWidget {
  const WorkingHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<WorkingHoursBloc>()..add(const WorkingHoursEvent.load()),
      child: const _WorkingHoursContent(),
    );
  }
}

class _WorkingHoursContent extends StatefulWidget {
  const _WorkingHoursContent();

  @override
  State<_WorkingHoursContent> createState() => _WorkingHoursContentState();
}

class _WorkingHoursContentState extends State<_WorkingHoursContent> {
  String? _expandedDay;
  List<WorkingDay> _workingDays = [];
  final List<HolidayEntry> _holidays = [];
  bool _populated = false;

  // Snapshot of initial state for dirty-checking
  List<_DaySnapshot> _initialDays = [];
  List<_HolidaySnapshot> _initialHolidays = [];

  static const int _maxShifts = 3;

  List<_DaySnapshot> _snapshotDays(List<WorkingDay> days) {
    return days
        .map((d) => _DaySnapshot(
              d.dayOfWeek,
              d.enabled,
              d.shifts
                  .map((s) =>
                      _ShiftSnapshot(s.from.hour, s.from.minute, s.to.hour, s.to.minute))
                  .toList(),
            ))
        .toList();
  }

  List<_HolidaySnapshot> _snapshotHolidays(List<HolidayEntry> holidays) {
    return holidays
        .map((h) => _HolidaySnapshot(
              h.id, h.name, h.date.year, h.date.month, h.date.day, h.recurring))
        .toList();
  }

  bool get _hasChanges {
    final currentDays = _snapshotDays(_workingDays);
    final currentHolidays = _snapshotHolidays(_holidays);
    if (currentDays.length != _initialDays.length) return true;
    for (int i = 0; i < currentDays.length; i++) {
      if (currentDays[i] != _initialDays[i]) return true;
    }
    if (currentHolidays.length != _initialHolidays.length) return true;
    for (int i = 0; i < currentHolidays.length; i++) {
      if (currentHolidays[i] != _initialHolidays[i]) return true;
    }
    return false;
  }

  List<WorkingDay> _buildDefaultWorkingDays() {
    return List.generate(7, (i) {
      final dayOfWeek = i + 1; // 1=Monday ... 7=Sunday
      final isWeekend = dayOfWeek == 6 || dayOfWeek == 7;
      return WorkingDay(
        id: '',
        dayOfWeek: dayOfWeek,
        enabled: !isWeekend,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      );
    });
  }

  void _populateFromApi(
    List<WorkingDayApiModel> apiDays,
    List<HolidayApiModel> apiHolidays,
  ) {
    if (apiDays.isEmpty) {
      _workingDays = _buildDefaultWorkingDays();
    } else {
      _workingDays = apiDays.map((day) {
        return WorkingDay(
          id: day.id,
          dayOfWeek: day.dayOfWeek,
          enabled: day.isOpen,
          shifts: day.ranges.isEmpty
              ? [
                  WorkingShift(
                    from: const TimeOfDay(hour: 9, minute: 0),
                    to: const TimeOfDay(hour: 17, minute: 0),
                  ),
                ]
              : day.ranges.map((r) {
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
    }

    _holidays
      ..clear()
      ..addAll(apiHolidays.map((h) {
        return HolidayEntry(
          id: h.id,
          name: h.name,
          date: DateTime.parse(h.date),
          recurring: h.isRecurring,
        );
      }));

    _populated = true;

    // Take snapshot for dirty-checking
    _initialDays = _snapshotDays(_workingDays);
    _initialHolidays = _snapshotHolidays(_holidays);
  }

  List<WorkingDayApiModel> _buildWorkingDaysPayload() {
    return _workingDays.map((day) {
      return WorkingDayApiModel(
        id: day.id,
        dayOfWeek: day.dayOfWeek,
        isOpen: day.enabled,
        ranges: day.enabled
            ? day.shifts.map((s) {
                return TimeRangeModel(
                  startTime: _formatTime(s.from),
                  endTime: _formatTime(s.to),
                );
              }).toList()
            : [],
      );
    }).toList();
  }

  List<HolidayApiModel> _buildHolidaysPayload() {
    return _holidays.map((h) {
      return HolidayApiModel(
        id: h.id,
        name: h.name,
        date:
            '${h.date.year}-${h.date.month.toString().padLeft(2, '0')}-${h.date.day.toString().padLeft(2, '0')}',
        isRecurring: h.recurring,
      );
    }).toList();
  }

  static String _formatTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  String _dayLabel(WorkingDay day) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? day.labelAr : day.labelEn;
  }

  String _daySummary(WorkingDay day) {
    if (day.shifts.length == 1) {
      return '${formatTime(day.shifts[0].from)} – ${formatTime(day.shifts[0].to)}';
    }
    return '${day.shifts.length} ${AppLocalizations.of(context)!.shifts}';
  }

  Future<void> _pickShiftTime(
    WorkingDay day,
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

  void _addShift(WorkingDay day) {
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

  void _removeShift(WorkingDay day) {
    if (day.shifts.length <= 1) return;
    setState(() => day.shifts.removeLast());
  }

  void _onSave() {
    context.read<WorkingHoursBloc>().add(
          WorkingHoursEvent.saveAll(
            workingDays: _buildWorkingDaysPayload(),
            holidays: _buildHolidaysPayload(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<WorkingHoursBloc, WorkingHoursState>(
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
            AppLoadingDialog.show(
              context: context,
              message: l10n.save,
            );
          },
          saved: () {
            AppLoadingDialog.dismiss(context);
            setState(() {
              _initialDays = _snapshotDays(_workingDays);
              _initialHolidays = _snapshotHolidays(_holidays);
            });
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
        final isDesktop = Responsive.isDesktop(context);

        final content = state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          loaded: (workingDays, holidays) {
            if (!_populated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() => _populateFromApi(workingDays, holidays));
              });
              return const Center(child: CircularProgressIndicator());
            }
            return _buildForm(l10n, isDesktop);
          },
          orElse: () {
            if (!_populated) {
              return const SizedBox.shrink();
            }
            return _buildForm(l10n, isDesktop);
          },
        );

        if (isDesktop) {
          return DesktopShell(
            title: l10n.workingHoursAndHolidays,
            body: Scaffold(
              backgroundColor: c.scaffoldBg,
              bottomNavigationBar: _workingDays.isNotEmpty
                  ? _buildSaveButton(l10n, isDesktop)
                  : null,
              body: content,
            ),
          );
        }

        return Scaffold(
          backgroundColor: c.scaffoldBg,
          bottomNavigationBar: _workingDays.isNotEmpty
              ? _buildSaveButton(l10n, isDesktop)
              : null,
          body: Column(
            children: [
              PageHeader(
                title: l10n.workingHoursAndHolidays,
                onBack: () => context.pop(),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isDesktop) {
    if (isDesktop) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CustomCard(child: _buildWorkingHoursSection()),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _buildHolidaysSection(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          CustomCard(child: _buildWorkingHoursSection()),
          SizedBox(height: 16.h),
          _buildHolidaysSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n, bool isDesktop) {
    final enabled = _hasChanges;
    final button = GestureDetector(
      onTap: enabled ? _onSave : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: isDesktop ? 14 : 14.h),
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
            fontSize: isDesktop ? 15 : 15.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
        ),
      ),
    );

    if (isDesktop) {
      return Container(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 20),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
          border: Border(
            top: BorderSide(color: ColorManager.of(context).borderLight),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: button,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: button,
    );
  }

  Widget _buildWorkingHoursSection() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.workingHours,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        ..._workingDays.asMap().entries.map(
              (e) => _buildDayRow(e.value,
                  isLast: e.key == _workingDays.length - 1),
            ),
      ],
    );
  }

  Widget _buildDayRow(WorkingDay day, {bool isLast = false}) {
    final isExpanded = _expandedDay == day.id;
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: day.enabled
                ? () => setState(
                    () => _expandedDay = isExpanded ? null : day.id)
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      day.enabled = !day.enabled;
                      if (!day.enabled && _expandedDay == day.id) {
                        _expandedDay = null;
                      }
                    }),
                    child: DayToggle(enabled: day.enabled),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _dayLabel(day),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: day.enabled
                            ? c.textPrimary
                            : c.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    day.enabled ? _daySummary(day) : l10n.closed,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: day.enabled
                          ? c.textSecondary
                          : c.textTertiary,
                    ),
                  ),
                  if (day.enabled) ...[
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
            secondChild: _buildShiftsPanel(day),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftsPanel(WorkingDay day) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      ),
    );
  }

  Widget _buildHolidaysSection() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.holidays,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: c.textPrimary,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => showAddHolidaySheet(
                  context,
                  onSave: (entry, _) => setState(() => _holidays.add(entry)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14.w, color: ColorManager.primary),
                      SizedBox(width: 4.w),
                      Text(
                        l10n.addHoliday,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_holidays.isEmpty) ...[
            SizedBox(height: 20.h),
            Center(
              child: Text(
                l10n.noHolidays,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: c.textTertiary,
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ] else ...[
            SizedBox(height: 8.h),
            ..._holidays.asMap().entries.map(
                  (e) => HolidayItem(
                    holiday: e.value,
                    isLast: e.key == _holidays.length - 1,
                    onEdit: () => showAddHolidaySheet(
                      context,
                      existing: e.value,
                      index: e.key,
                      onSave: (entry, idx) =>
                          setState(() => _holidays[idx!] = entry),
                    ),
                    onDelete: () =>
                        setState(() => _holidays.removeAt(e.key)),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

// ─── Lightweight snapshot classes for dirty-checking ─────────────────

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
  final bool enabled;
  final List<_ShiftSnapshot> shifts;
  const _DaySnapshot(this.dayOfWeek, this.enabled, this.shifts);

  @override
  bool operator ==(Object other) {
    if (other is! _DaySnapshot) return false;
    if (dayOfWeek != other.dayOfWeek || enabled != other.enabled) return false;
    if (shifts.length != other.shifts.length) return false;
    for (int i = 0; i < shifts.length; i++) {
      if (shifts[i] != other.shifts[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(dayOfWeek, enabled, Object.hashAll(shifts));
}

class _HolidaySnapshot {
  final String? id;
  final String name;
  final int year, month, day;
  final bool recurring;
  const _HolidaySnapshot(
      this.id, this.name, this.year, this.month, this.day, this.recurring);

  @override
  bool operator ==(Object other) =>
      other is _HolidaySnapshot &&
      id == other.id &&
      name == other.name &&
      year == other.year &&
      month == other.month &&
      day == other.day &&
      recurring == other.recurring;

  @override
  int get hashCode => Object.hash(id, name, year, month, day, recurring);
}
