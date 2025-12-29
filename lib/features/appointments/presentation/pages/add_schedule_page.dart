import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

/// Add new appointment/schedule page
class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  String? _selectedPatient;
  String? _selectedTreatment;
  String? _selectedDoctor;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  int _duration = 30;
  final _notesController = TextEditingController();
  bool _sendReminder = true;

  // Sample data
  final List<String> _patients = [
    'Sarah Johnson', 'Michael Brown', 'Emma Wilson',
    'James Davis', 'Lisa Anderson', 'Robert Taylor',
  ];

  final List<String> _treatments = [
    'Regular Checkup', 'Teeth Cleaning', 'Cavity Filling',
    'Root Canal', 'Tooth Extraction', 'Dental Crown',
    'Teeth Whitening', 'Consultation', 'X-Ray',
  ];

  final List<String> _doctors = [
    'Dr. Sarah Johnson', 'Dr. Michael Chen', 'Dr. Emily Davis',
  ];

  final List<int> _durations = [15, 30, 45, 60, 90, 120];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveAppointment() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedPatient == null || _selectedTreatment == null || _selectedDoctor == null) {
        AppSnackbar.showWarning(context, title: 'Missing Information', message: 'Please fill all required fields');
        return;
      }
      AppSnackbar.showSuccess(context, title: 'Appointment Scheduled', message: 'Successfully added to calendar');
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
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF70B2B2)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildPatientSection(),
                    SizedBox(height: 16.h),
                    _buildAppointmentDetails(),
                    SizedBox(height: 16.h),
                    _buildDateTimeSection(),
                    SizedBox(height: 16.h),
                    _buildNotesSection(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomButtons(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF70B2B2), Color(0xFF5A9999), Color(0xFF4A8888)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 12.h, 16.w, 20.h),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: ColorManager.white, size: 24.w),
                onPressed: () => context.pop(),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Appointment', style: TextStyleManager.headlineSmall.copyWith(color: ColorManager.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.h),
                    Text('Schedule a new visit', style: TextStyleManager.bodySmall.copyWith(color: ColorManager.white.withValues(alpha: 0.8))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientSection() {
    return SectionCard(
      title: 'Patient',
      child: Column(
        children: [
          _buildDropdown(
            label: 'Select Patient',
            value: _selectedPatient,
            items: _patients,
            icon: Icons.person_outline,
            onChanged: (v) => setState(() => _selectedPatient = v),
          ),
          SizedBox(height: 12.h),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.person_add_outlined, size: 18.w),
            label: const Text('Add New Patient'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF70B2B2),
              side: const BorderSide(color: Color(0xFF70B2B2)),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return SectionCard(
      title: 'Appointment Details',
      child: Column(
        children: [
          _buildDropdown(
            label: 'Treatment Type',
            value: _selectedTreatment,
            items: _treatments,
            icon: Icons.medical_services_outlined,
            onChanged: (v) => setState(() => _selectedTreatment = v),
          ),
          SizedBox(height: 16.h),
          _buildDropdown(
            label: 'Doctor',
            value: _selectedDoctor,
            items: _doctors,
            icon: Icons.badge_outlined,
            onChanged: (v) => setState(() => _selectedDoctor = v),
          ),
          SizedBox(height: 16.h),
          _buildDurationSelector(),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return SectionCard(
      title: 'Date & Time',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDatePicker()),
              SizedBox(width: 12.w),
              Expanded(child: _buildTimePicker()),
            ],
          ),
          SizedBox(height: 16.h),
          _buildReminderToggle(),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return SectionCard(
      title: 'Additional Notes',
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.gray50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.gray200),
        ),
        child: TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any special notes or instructions...',
            hintStyle: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textTertiary),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyleManager.titleSmall.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w500)),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.gray50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorManager.gray200),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: ColorManager.textTertiary, size: 20.w),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            hint: Text('Select...', style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textTertiary)),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: onChanged,
            dropdownColor: ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Duration', style: TextStyleManager.titleSmall.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w500)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _durations.map((duration) {
            final isSelected = _duration == duration;
            return GestureDetector(
              onTap: () => setState(() => _duration = duration),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF70B2B2) : ColorManager.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: isSelected ? const Color(0xFF70B2B2) : ColorManager.gray300),
                ),
                child: Text(
                  '$duration min',
                  style: TextStyleManager.bodySmall.copyWith(
                    color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
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
            Icon(Icons.calendar_today_outlined, color: const Color(0xFF70B2B2), size: 20.w),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date', style: TextStyleManager.labelSmall.copyWith(color: ColorManager.textTertiary)),
                  SizedBox(height: 2.h),
                  Text(_formatDate(_selectedDate), style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: ColorManager.gray50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.gray200),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: const Color(0xFF70B2B2), size: 20.w),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time', style: TextStyleManager.labelSmall.copyWith(color: ColorManager.textTertiary)),
                  SizedBox(height: 2.h),
                  Text(_selectedTime.format(context), style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF70B2B2).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications_outlined, color: const Color(0xFF70B2B2), size: 22.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Reminder', style: TextStyleManager.titleSmall.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w500)),
                Text('Notify patient before appointment', style: TextStyleManager.bodySmall.copyWith(color: ColorManager.textSecondary)),
              ],
            ),
          ),
          Switch(
            value: _sendReminder,
            onChanged: (v) => setState(() => _sendReminder = v),
            activeTrackColor: const Color(0xFF70B2B2),
            activeThumbColor: ColorManager.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: const BorderSide(color: Color(0xFF70B2B2)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Cancel', style: TextStyleManager.button.copyWith(color: const Color(0xFF70B2B2))),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _saveAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF70B2B2),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Schedule', style: TextStyleManager.button.copyWith(color: ColorManager.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
