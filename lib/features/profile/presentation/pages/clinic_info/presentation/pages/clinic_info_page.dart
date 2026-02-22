import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/add_holiday_sheet.dart';
import '../widgets/clinic_info_models.dart';
import '../widgets/clinic_info_widgets.dart';
import '../widgets/cupertino_picker_sheet.dart';

class ClinicInfoPage extends StatefulWidget {
  const ClinicInfoPage({super.key});

  @override
  State<ClinicInfoPage> createState() => _ClinicInfoPageState();
}

class _ClinicInfoPageState extends State<ClinicInfoPage> {
  late final TextEditingController _clinicNameController;
  String? _expandedDay;
  late final List<WorkingDay> _workingDays;
  final List<HolidayEntry> _holidays = [];

  static const int _maxShifts = 3;

  @override
  void initState() {
    super.initState();
    _clinicNameController = TextEditingController(text: 'Bright Smile Dental');
    _workingDays = [
      WorkingDay(
        key: 'mon',
        labelEn: 'Monday',
        labelAr: 'الإثنين',
        enabled: true,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'tue',
        labelEn: 'Tuesday',
        labelAr: 'الثلاثاء',
        enabled: true,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'wed',
        labelEn: 'Wednesday',
        labelAr: 'الأربعاء',
        enabled: true,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'thu',
        labelEn: 'Thursday',
        labelAr: 'الخميس',
        enabled: true,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'fri',
        labelEn: 'Friday',
        labelAr: 'الجمعة',
        enabled: false,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'sat',
        labelEn: 'Saturday',
        labelAr: 'السبت',
        enabled: true,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 10, minute: 0),
            to: const TimeOfDay(hour: 14, minute: 0),
          ),
        ],
      ),
      WorkingDay(
        key: 'sun',
        labelEn: 'Sunday',
        labelAr: 'الأحد',
        enabled: false,
        shifts: [
          WorkingShift(
            from: const TimeOfDay(hour: 9, minute: 0),
            to: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _clinicNameController.dispose();
    super.dispose();
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
      doneLabel: l10n.done,
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
    // TODO: Implement save logic
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      bottomNavigationBar: saveButton(l10n, context),
      body: Column(
        children: [
          PageHeader(
            title: l10n.clinicInformation,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  CustomCard(child: _buildClinicNameField()),
                  SizedBox(height: 16.h),
                  CustomCard(child: _buildWorkingHoursSection()),
                  SizedBox(height: 16.h),
                  _buildHolidaysSection(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton(AppLocalizations l10n, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GestureDetector(
        onTap: _onSave,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: ColorManager.primary,
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

  Widget _buildClinicNameField() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(
          Icons.business_outlined,
          size: 18.w,
          color: ColorManager.textTertiary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.clinicName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: _clinicNameController,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textPrimary,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.workingHours,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        ..._workingDays.asMap().entries.map(
          (e) =>
              _buildDayRow(e.value, isLast: e.key == _workingDays.length - 1),
        ),
      ],
    );
  }

  Widget _buildDayRow(WorkingDay day, {bool isLast = false}) {
    final isExpanded = _expandedDay == day.key;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.borderLight, width: 1),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: day.enabled
                ? () =>
                      setState(() => _expandedDay = isExpanded ? null : day.key)
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      day.enabled = !day.enabled;
                      if (!day.enabled && _expandedDay == day.key)
                        _expandedDay = null;
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
                            ? ColorManager.textPrimary
                            : ColorManager.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    day.enabled ? _daySummary(day) : l10n.closed,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: day.enabled
                          ? ColorManager.textSecondary
                          : ColorManager.textTertiary,
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
                        color: ColorManager.textTertiary,
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
                  color: ColorManager.textSecondary,
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
                      color: ColorManager.textTertiary,
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
                  color: ColorManager.textPrimary,
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
                  color: ColorManager.textTertiary,
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
                onDelete: () => setState(() => _holidays.removeAt(e.key)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
