import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'pages/treatment_dashboard_page.dart';

/// Step 1: Enter total cost & lab fees, then proceed to the treatment dashboard.
class TreatmentPrototypeHub extends StatefulWidget {
  const TreatmentPrototypeHub({super.key});

  @override
  State<TreatmentPrototypeHub> createState() => _TreatmentPrototypeHubState();
}

class _TreatmentPrototypeHubState extends State<TreatmentPrototypeHub> {
  final _totalCostController = TextEditingController();
  final _labFeesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  void _proceed() {
    if (!_formKey.currentState!.validate()) return;

    final totalCost = double.tryParse(_totalCostController.text) ?? 0;
    final labFees = double.tryParse(_labFeesController.text) ?? 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TreatmentDashboardPage(
          totalCost: totalCost,
          labFees: labFees,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          PageHeader(
            title: 'New Treatment Plan',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info banner
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorManager.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20.w,
                            color: ColorManager.primary,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'Enter the treatment cost details, then proceed to plan treatments.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.primary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Total Cost field
                    Text(
                      'Total Cost',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _totalCostController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w500,
                        color: ColorManager.textPrimary,
                      ),
                      decoration: _inputDecoration('0.00'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the total cost';
                        }
                        final parsed = double.tryParse(value);
                        if (parsed == null || parsed < 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Lab Fees field
                    Text(
                      'Lab Fees',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _labFeesController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w500,
                        color: ColorManager.textPrimary,
                      ),
                      decoration: _inputDecoration('0.00'),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final parsed = double.tryParse(value);
                          if (parsed == null || parsed < 0) {
                            return 'Enter a valid amount';
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),

                    // Proceed button
                    GestureDetector(
                      onTap: _proceed,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadiusManager.lg,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue to Plan',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.white,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 20.w,
                              color: ColorManager.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        color: ColorManager.textTertiary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      filled: true,
      fillColor: ColorManager.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.error),
      ),
    );
  }
}
