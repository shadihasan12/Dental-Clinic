import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

/// Add treatment page for a patient
class AddTreatmentPage extends StatefulWidget {
  const AddTreatmentPage({
    super.key,
    required this.dentalCase,
    this.isInitial = false,
  });

  final DentalCase dentalCase;
  final bool isInitial;

  @override
  State<AddTreatmentPage> createState() => _AddTreatmentPageState();
}

class _AddTreatmentPageState extends State<AddTreatmentPage> {
  DateTime _visitDate = DateTime.now();
  final List<String> _selectedTreatmentTypes = [];
  final _visitSummaryController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _labFeesController = TextEditingController();
  List<int> _selectedTeeth = [];
  final List<String> _attachments = [];

  final List<String> _availableTreatmentTypes = [
    'Cleaning',
    'Filling',
    'Root Canal',
    'Extraction',
    'Crown',
    'Implant',
    'Whitening',
    'Veneer',
  ];

  @override
  void dispose() {
    _visitSummaryController.dispose();
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  Future<void> _saveTreatment() async {
    AppLoadingDialog.show(context: context, message: 'Saving Treatment...');

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) AppLoadingDialog.dismiss(context);

    if (mounted) {
      AppSnackbar.showSuccess(
        context,
        title: 'Success!',
        message: 'Treatment saved successfully',
      );

      context.pop();
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _visitDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF70B2B2)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _visitDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildPageHeader(context),
      body: SingleChildScrollView(
        child: VisitInfoForm(
          isInitial: widget.isInitial,
          visitDate: _visitDate,
          onVisitDateTap: _selectDate,
          selectedTreatmentTypes: _selectedTreatmentTypes,
          availableTreatmentTypes: _availableTreatmentTypes,
          onTreatmentToggle: (t) => setState(
            () => _selectedTreatmentTypes.contains(t)
                ? _selectedTreatmentTypes.remove(t)
                : _selectedTreatmentTypes.add(t),
          ),
          selectedTeeth: _selectedTeeth,
          onTeethChanged: (teeth) {
            setState(() {
              _selectedTeeth = teeth;
            });
          },
          visitSummaryController: _visitSummaryController,
          totalCostController: _totalCostController,
          labFeesController: _labFeesController,
          attachments: _attachments,
          onUploadTap: () {},
          onAttachmentRemove: (i) => setState(() => _attachments.removeAt(i)),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBottomButton() {
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
          onPressed: _saveTreatment,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF70B2B2),
            foregroundColor: ColorManager.white,
            elevation: 2,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Save Treatment',
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

  AppBar _buildPageHeader(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xFF70B2B2),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorManager.white),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Add Treatment',
        style: TextStyle(
          color: ColorManager.white,
          fontSize: 18.sp,
          fontFamily: FontFamily.geist,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}