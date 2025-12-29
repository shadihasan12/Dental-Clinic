import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

/// Add new patient page with multi-step form
class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  int _currentStep = 1;
  final int _totalSteps = 3;
  bool _isRecording = false;

  // Step 1 controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _allergiesController = TextEditingController();
  String? _selectedGender;
  DateTime? _dateOfBirth;

  // Step 2 controllers
  final _caseTitleController = TextEditingController();

  // Step 3 data
  DateTime _visitDate = DateTime.now();
  final List<String> _selectedTreatmentTypes = [];
  final _visitSummaryController = TextEditingController();
  final Map<int, String> _toothTreatments = {};
  final List<String> _attachments = [];

  final List<String> _availableTreatmentTypes = [
    'Cleaning', 'Filling', 'Root Canal', 'Extraction',
    'Crown', 'Implant', 'Whitening', 'X-Ray',
  ];

  final List<String> _availableToothTreatments = [
    'Filling', 'Root Canal', 'Extraction', 'Crown', 'Veneer', 'Cleaning',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    _caseTitleController.dispose();
    _visitSummaryController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) setState(() => _currentStep++);
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  void _savePatient() {
    _showSuccessSnackbar();
    context.pop();
  }

  void _showSuccessSnackbar() {
    AppSnackbar.showSuccess(context, title: 'Success!', message: 'Patient saved successfully');
  }

  Future<void> _selectDate({required bool isDateOfBirth}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isDateOfBirth ? (_dateOfBirth ?? DateTime(1990)) : _visitDate,
      firstDate: isDateOfBirth ? DateTime(1900) : DateTime(2020),
      lastDate: isDateOfBirth ? DateTime.now() : DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Color(0xFF70B2B2))),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => isDateOfBirth ? _dateOfBirth = picked : _visitDate = picked);
    }
  }

  void _showToothTreatmentDialog(int toothNumber) {
    String? selectedTreatment = _toothTreatments[toothNumber];
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Treatment for Tooth $toothNumber'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          content: _buildTreatmentDropdown(selectedTreatment, (v) => setDialogState(() => selectedTreatment = v)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: selectedTreatment != null ? () { setState(() => _toothTreatments[toothNumber] = selectedTreatment!); Navigator.pop(context); } : null,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF70B2B2), foregroundColor: ColorManager.white),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentDropdown(String? value, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(color: ColorManager.gray50, borderRadius: BorderRadius.circular(12.r)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: const Text('Choose treatment type'),
          isExpanded: true,
          items: _availableToothTreatments.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          AddPatientHeader(currentStep: _currentStep, totalSteps: _totalSteps, onBackPressed: _previousStep),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Transform.translate(offset: Offset(0, -16.h), child: _buildCurrentStep()),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1:
        return PatientInfoForm(
          firstNameController: _firstNameController, lastNameController: _lastNameController,
          phoneController: _phoneController, emailController: _emailController,
          addressController: _addressController, medicalHistoryController: _medicalHistoryController,
          allergiesController: _allergiesController, selectedGender: _selectedGender,
          dateOfBirth: _dateOfBirth, onGenderChanged: (v) => setState(() => _selectedGender = v),
          onDateOfBirthTap: () => _selectDate(isDateOfBirth: true),
        );
      case 2:
        return CaseInfoForm(caseTitleController: _caseTitleController);
      case 3:
        return VisitInfoForm(
          visitDate: _visitDate, onVisitDateTap: () => _selectDate(isDateOfBirth: false),
          selectedTreatmentTypes: _selectedTreatmentTypes, availableTreatmentTypes: _availableTreatmentTypes,
          onTreatmentToggle: (t) => setState(() => _selectedTreatmentTypes.contains(t) ? _selectedTreatmentTypes.remove(t) : _selectedTreatmentTypes.add(t)),
          toothTreatments: _toothTreatments, onToothTap: _showToothTreatmentDialog,
          visitSummaryController: _visitSummaryController, isRecording: _isRecording,
          onRecordingToggle: () => setState(() => _isRecording = !_isRecording),
          attachments: _attachments, onUploadTap: () {}, onAttachmentRemove: (i) => setState(() => _attachments.removeAt(i)),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: ColorManager.white, boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 1) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(foregroundColor: ColorManager.textPrimary, side: BorderSide(color: ColorManager.gray200), padding: EdgeInsets.symmetric(vertical: 16.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                  child: Text('Back', style: TextStyleManager.button.copyWith(color: ColorManager.textPrimary)),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: ElevatedButton(
                onPressed: _currentStep == _totalSteps ? _savePatient : _nextStep,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF70B2B2), foregroundColor: ColorManager.white, elevation: 2, padding: EdgeInsets.symmetric(vertical: 16.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                child: Text(_currentStep == _totalSteps ? 'Save' : 'Next', style: TextStyleManager.button.copyWith(color: ColorManager.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
