import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/add_treatment_form.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_item_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_detail_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class CreateCasePage extends StatefulWidget {
  final String patientId;
  final String patientName;

  const CreateCasePage({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  State<CreateCasePage> createState() => _CreateCasePageState();
}

class _CreateCasePageState extends State<CreateCasePage> {
  final _titleController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  final List<TreatmentItem> _treatmentItems = [];
  bool _showAddTreatmentForm = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _totalCostController.dispose();
    super.dispose();
  }

  void _addTreatment(TreatmentItem item) {
    setState(() {
      _treatmentItems.add(item);
      _showAddTreatmentForm = false;
    });
  }

  void _removeTreatment(int index) {
    setState(() {
      _treatmentItems.removeAt(index);
    });
  }

  void _handleSave() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_treatmentItems.isEmpty) {
        _showErrorSnackbar('Please add at least one treatment');
        return;
      }

      setState(() => _isLoading = true);

      // Create the case object
      final newCase = DentalCase(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        patientId: widget.patientId,
        patientName: widget.patientName,
        title: _titleController.text.trim(),
        startDate: DateTime.now(),
        status: 'In Progress',
        totalCost: double.tryParse(_totalCostController.text) ?? 0,
        paidAmount: 0,
        treatmentItems: _treatmentItems,
      );

      // TODO: Save to repository/bloc
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay

      if (mounted) {
        setState(() => _isLoading = false);
        
        AppSnackbar.showSuccess(
          context,
          title: 'Success',
          message: 'Case created successfully!',
        );

        // Navigate back or to case details
        context.pop(newCase);
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorManager.error,
      ),
    );
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
              padding: PaddingManager.all16,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Case info card
                    _buildCaseInfoForm(),

                    SizedBox(height: 20.h),

                    // Treatments section
                    _buildTreatmentsSection(),

                    SizedBox(height: 100.h), // Space for bottom button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorManager.white),
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: Text(
                  'New Case',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48.w), // Balance the back button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaseInfoForm() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Icon(Icons.folder_outlined, color: ColorManager.primary, size: 20.w),
              SizedBox(width: 8.w),
              Text(
                'Case Information',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Patient field (disabled)
          _buildLabel('Patient'),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: ColorManager.gray100,
              borderRadius: BorderRadiusManager.lg,
              border: Border.all(color: ColorManager.gray200),
            ),
            child: Row(
              children: [
                Icon(Icons.person, size: 20.w, color: ColorManager.textSecondary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.patientName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ),
                Icon(Icons.lock_outline, size: 16.w, color: ColorManager.textTertiary),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Case title field
          _buildLabel('Case Title *'),
          SizedBox(height: 6.h),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'e.g., Root Canal Treatment, Braces Installation',
              hintStyle: TextStyle(
                color: ColorManager.textTertiary,
                fontFamily: FontFamily.geist,
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(Icons.title, color: ColorManager.textSecondary),
              filled: true,
              fillColor: ColorManager.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.gray200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.gray200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.primary),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a case title';
              }
              if (value.trim().length < 3) {
                return 'Title must be at least 3 characters';
              }
              return null;
            },
          ),

          SizedBox(height: 16.h),

          // Total cost field (optional)
          _buildLabel('Estimated Total Cost (Optional)'),
          SizedBox(height: 6.h),
          TextFormField(
            controller: _totalCostController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: '0.00',
              prefixText: '\$ ',
              hintStyle: TextStyle(
                color: ColorManager.textTertiary,
                fontFamily: FontFamily.geist,
              ),
              prefixIcon: Icon(Icons.attach_money, color: ColorManager.textSecondary),
              filled: true,
              fillColor: ColorManager.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.gray200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.gray200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadiusManager.lg,
                borderSide: BorderSide(color: ColorManager.primary),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Helper text
          Row(
            children: [
              Icon(Icons.info_outline, size: 14.w, color: ColorManager.textTertiary),
              SizedBox(width: 4.w),
              Text(
                'You can update the cost later as treatments progress',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services_outlined, color: ColorManager.primary, size: 20.w),
                SizedBox(width: 8.w),
                Text(
                  'Treatment Plan',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${_treatmentItems.length} item(s)',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Info banner
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorManager.info.withValues(alpha: 0.1),
            borderRadius: BorderRadiusManager.lg,
            border: Border.all(color: ColorManager.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 20.w, color: ColorManager.info),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Add treatments that the patient needs. All items will start as pending and can be marked as done during visits.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.geist,
                    color: ColorManager.info,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Treatment items list
        if (_treatmentItems.isNotEmpty) ...[
          ...List.generate(_treatmentItems.length, (index) {
            final item = _treatmentItems[index];
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _removeTreatment(index),
              background: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.error,
                  borderRadius: BorderRadiusManager.lg,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(Icons.delete_outline, color: ColorManager.white),
              ),
              child: TreatmentItemCard(
                item: item,
                index: index,
                showCheckbox: false,
                onTap: () => TreatmentDetailPopup.show(context, item, index),
              ),
            );
          }),
          SizedBox(height: 8.h),
        ],

        // Add treatment form or button
        if (_showAddTreatmentForm)
          AddTreatmentForm(
            patientName: widget.patientName,
            onSave: _addTreatment,
            onCancel: () => setState(() => _showAddTreatmentForm = false),
          )
        else
          _buildAddTreatmentButton(),
      ],
    );
  }

  Widget _buildAddTreatmentButton() {
    return GestureDetector(
      onTap: () => setState(() => _showAddTreatmentForm = true),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadiusManager.lg,
          border: Border.all(
            color: ColorManager.primary,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 20.w, color: ColorManager.primary),
            SizedBox(width: 8.w),
            Text(
              'Add Treatment',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w600,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary row
            if (_treatmentItems.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Treatments:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontFamily.geist,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    Text(
                      '${_treatmentItems.length} pending',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.warning,
                      ),
                    ),
                  ],
                ),
              ),
            PrimaryButton(
              text: 'Create Case',
              isLoading: _isLoading,
              isEnabled: _titleController.text.trim().isNotEmpty,
              onPressed: _handleSave,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.geist,
        fontWeight: FontWeight.w500,
        color: ColorManager.textPrimary,
      ),
    );
  }
}