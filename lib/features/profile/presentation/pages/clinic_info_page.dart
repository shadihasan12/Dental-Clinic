import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WorkingDay {
  final String key;
  final String labelEn;
  final String labelAr;
  bool enabled;
  TimeOfDay from;
  TimeOfDay to;

  WorkingDay({
    required this.key,
    required this.labelEn,
    required this.labelAr,
    required this.enabled,
    required this.from,
    required this.to,
  });
}

class ClinicInfoPage extends StatefulWidget {
  const ClinicInfoPage({super.key});

  @override
  State<ClinicInfoPage> createState() => _ClinicInfoPageState();
}

class _ClinicInfoPageState extends State<ClinicInfoPage> {
  late final TextEditingController _clinicNameController;
  String? _expandedDay;

  late final List<WorkingDay> _workingDays;

  @override
  void initState() {
    super.initState();
    _clinicNameController = TextEditingController(text: 'Bright Smile Dental');

    _workingDays = [
      WorkingDay(key: 'mon', labelEn: 'Monday', labelAr: 'الإثنين', enabled: true, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
      WorkingDay(key: 'tue', labelEn: 'Tuesday', labelAr: 'الثلاثاء', enabled: true, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
      WorkingDay(key: 'wed', labelEn: 'Wednesday', labelAr: 'الأربعاء', enabled: true, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
      WorkingDay(key: 'thu', labelEn: 'Thursday', labelAr: 'الخميس', enabled: true, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
      WorkingDay(key: 'fri', labelEn: 'Friday', labelAr: 'الجمعة', enabled: false, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
      WorkingDay(key: 'sat', labelEn: 'Saturday', labelAr: 'السبت', enabled: true, from: const TimeOfDay(hour: 10, minute: 0), to: const TimeOfDay(hour: 14, minute: 0)),
      WorkingDay(key: 'sun', labelEn: 'Sunday', labelAr: 'الأحد', enabled: false, from: const TimeOfDay(hour: 9, minute: 0), to: const TimeOfDay(hour: 17, minute: 0)),
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

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _pickTime(WorkingDay day, {required bool isFrom}) async {
    final initial = isFrom ? day.from : day.to;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
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
    if (picked != null) {
      setState(() {
        if (isFrom) {
          day.from = picked;
        } else {
          day.to = picked;
        }
      });
    }
  }

  void _onSave() {
    // TODO: Implement save logic
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: ColorManager.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorManager.textPrimary,
                        size: 20.w,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    Text(
                      l10n.clinicInformation,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Divider(height: 1, color: ColorManager.borderLight),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Clinic Name card
                  CustomCard(
                    child: _buildClinicNameField(),
                  ),

                  SizedBox(height: 16.h),

                  // Working Hours card
                  CustomCard(
                    child: Column(
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
                        ..._workingDays.asMap().entries.map((entry) {
                          final index = entry.key;
                          final day = entry.value;
                          final isLast = index == _workingDays.length - 1;
                          return _buildDayRow(day, isLast: isLast);
                        }),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Save button
                  GestureDetector(
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

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicNameField() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(Icons.business_outlined, size: 18.w, color: ColorManager.textTertiary),
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
                  fontWeight: FontWeight.w400,
                  color: ColorManager.textTertiary,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: _clinicNameController,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w400,
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

  Widget _buildDayRow(WorkingDay day, {bool isLast = false}) {
    final isExpanded = _expandedDay == day.key;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 60.h,
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.borderLight, width: 1),
              ),
            ),
      child: Column(
        children: [
          // Main row
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: day.enabled
                ? () => setState(() {
                      _expandedDay = isExpanded ? null : day.key;
                    })
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  // Toggle switch
                  GestureDetector(
                    onTap: () => setState(() {
                      day.enabled = !day.enabled;
                      if (!day.enabled && _expandedDay == day.key) {
                        _expandedDay = null;
                      }
                    }),
                    child: _buildToggle(day.enabled),
                  ),
                  SizedBox(width: 12.w),

                  // Day name
                  Expanded(
                    child: Text(
                      _dayLabel(day),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w400,
                        color: day.enabled
                            ? ColorManager.textPrimary
                            : ColorManager.textTertiary,
                      ),
                    ),
                  ),

                  // Hours summary or "Closed"
                  if (day.enabled)
                    Text(
                      '${_formatTime(day.from)} – ${_formatTime(day.to)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w400,
                        color: ColorManager.textSecondary,
                      ),
                    )
                  else
                    Text(
                      l10n.closed,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w400,
                        color: ColorManager.textTertiary,
                      ),
                    ),

                  // Chevron for enabled days
                  if (day.enabled) ...[
                    SizedBox(width: 8.w),
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

          // Expanded time pickers
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  SizedBox(width: 52.w), // align with text after toggle
                  // From
                  Expanded(
                    child: _buildTimePicker(
                      label: l10n.from,
                      time: day.from,
                      onTap: () => _pickTime(day, isFrom: true),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      '–',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorManager.textTertiary,
                      ),
                    ),
                  ),
                  // To
                  Expanded(
                    child: _buildTimePicker(
                      label: l10n.to,
                      time: day.to,
                      onTap: () => _pickTime(day, isFrom: false),
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(bool enabled) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: enabled ? ColorManager.primary : ColorManager.gray100,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(2.w),
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w400,
              color: ColorManager.textTertiary,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.gray50,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorManager.borderLight),
            ),
            child: Text(
              _formatTime(time),
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}