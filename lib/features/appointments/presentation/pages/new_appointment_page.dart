import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({super.key});

  @override
  State<NewAppointmentPage> createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  // Form state
  String? _selectedPatient;
  final List<String> _selectedTreatments = [];
  DateTime _selectedDate = DateTime.now();
  int _duration = 30;
  String? _selectedSlot;
  final _notesController = TextEditingController();
  bool _sendReminder = true;

  // Sample data
  final List<String> _patients = [
    'Sarah Johnson',
    'Michael Brown',
    'Emma Wilson',
    'James Davis',
    'Lisa Anderson',
    'Robert Taylor',
  ];

  final List<String> _treatmentTypes = [
    'Checkup',
    'Cleaning',
    'Filling',
    'Root Canal',
    'Extraction',
    'Crown',
    'Whitening',
    'Consultation',
    'X-Ray',
  ];

  final List<int> _durations = [15, 30, 45, 60];

  // Mock available slots (would come from backend based on date & duration)
  List<String> _availableSlots = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableSlots();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _loadAvailableSlots() {
    // Simulating backend response based on selected date and duration
    // In real app: await api.getAvailableSlots(date, duration)
    setState(() {
      _availableSlots = [
        '9:00 - 9:30',
        '10:00 - 10:30',
        '11:30 - 12:00',
        '14:00 - 14:30',
        '15:00 - 15:30',
        '16:30 - 17:00',
      ];
      _selectedSlot = null; // Reset selection when slots change
    });
  }

  void _onDateChanged() {
    _loadAvailableSlots();
  }

  void _onDurationChanged(int duration) {
    setState(() {
      _duration = duration;
    });
    _loadAvailableSlots();
  }

  void _saveAppointment() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedPatient == null) {
        AppSnackbar.showWarning(
          context,
          title: 'Missing Patient',
          message: 'Please select a patient',
        );
        return;
      }

      if (_selectedTreatments.isEmpty) {
        AppSnackbar.showWarning(
          context,
          title: 'Missing Treatment',
          message: 'Please select at least one treatment type',
        );
        return;
      }

      if (_selectedSlot == null) {
        AppSnackbar.showWarning(
          context,
          title: 'Missing Time Slot',
          message: 'Please select an available time slot',
        );
        return;
      }

      AppSnackbar.showSuccess(
        context,
        title: 'Appointment Scheduled',
        message: 'Successfully added to calendar',
      );
      context.pop();
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF70B2B2)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _onDateChanged();
    }
  }

  void _addNewPatient() {
    // TODO: Navigate to add patient page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPatientSection(),
              SizedBox(height: 16.h),
              _buildTreatmentSection(),
              SizedBox(height: 16.h),
              _buildNotesSection(),
              SizedBox(height: 16.h),
              _buildScheduleSection(),
              SizedBox(height: 16.h),
              _buildReminderSection(),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xFF70B2B2),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorManager.white),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'New Appointment',
        style: TextStyle(
          color: ColorManager.white,
          fontSize: 18.sp,
          fontFamily: FontFamily.geist,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPatientSection() {
    return SectionCard(
      title: 'Patient',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient dropdown
          Container(
            decoration: BoxDecoration(
              color: ColorManager.gray50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorManager.gray200),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedPatient,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                hintText: 'Select patient...',
                hintStyle: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.textTertiary,
                ),
              ),
              items: _patients
                  .map((patient) => DropdownMenuItem(
                        value: patient,
                        child: Text(
                          patient,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedPatient = v),
              dropdownColor: ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),

          SizedBox(height: 12.h),

          // Add new patient button (text only)
          GestureDetector(
            onTap: _addNewPatient,
            child: Text(
              'Add New Patient',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentSection() {
    return SectionCard(
      title: 'Treatment Type',
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: _treatmentTypes.map((treatment) {
          final isSelected = _selectedTreatments.contains(treatment);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedTreatments.remove(treatment);
                } else {
                  _selectedTreatments.add(treatment);
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF70B2B2)
                    : ColorManager.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF70B2B2)
                      : ColorManager.gray300,
                ),
              ),
              child: Text(
                treatment,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotesSection() {
    return SectionCard(
      title: 'Notes',
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.gray50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.gray200),
        ),
        child: TextField(
          controller: _notesController,
          maxLines: 3,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Any special notes or instructions...',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textTertiary,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleSection() {
    return SectionCard(
      title: 'Schedule',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Duration selection
          Text(
            'Duration',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            children: _durations.map((duration) {
              final isSelected = _duration == duration;
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () => _onDurationChanged(duration),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF70B2B2)
                          : ColorManager.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF70B2B2)
                            : ColorManager.gray300,
                      ),
                    ),
                    child: Text(
                      '$duration min',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? ColorManager.white
                            : ColorManager.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20.h),

          // Date selection
          Text(
            'Date',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.gray200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: const Color(0xFF70B2B2),
                    size: 20.w,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    _formatDate(_selectedDate),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: ColorManager.textTertiary,
                    size: 20.w,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Available slots
          Text(
            'Available Slots',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),

          if (_availableSlots.isEmpty)
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadiusManager.lg,
              ),
              child: Center(
                child: Text(
                  'No available slots for this date',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontFamily.geist,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _availableSlots.map((slot) {
                final isSelected = _selectedSlot == slot;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSlot = slot),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF70B2B2)
                          : ColorManager.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF70B2B2)
                            : ColorManager.gray300,
                      ),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? ColorManager.white
                            : ColorManager.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildReminderSection() {
    return GestureDetector(
      onTap: () => setState(() => _sendReminder = !_sendReminder),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.gray200),
        ),
        child: Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              color: const Color(0xFF70B2B2),
              size: 22.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Send reminder to patient',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary,
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: _sendReminder
                    ? const Color(0xFF70B2B2)
                    : ColorManager.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: _sendReminder
                      ? const Color(0xFF70B2B2)
                      : ColorManager.gray300,
                  width: 2,
                ),
              ),
              child: _sendReminder
                  ? Icon(
                      Icons.check,
                      size: 16.w,
                      color: ColorManager.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _saveAppointment,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF70B2B2),
            foregroundColor: ColorManager.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Schedule Appointment',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}