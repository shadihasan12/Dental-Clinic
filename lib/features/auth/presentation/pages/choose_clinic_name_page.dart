import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class ChooseClinicNamePage extends StatefulWidget {
  final int? planId;
  final bool isYearly;

  const ChooseClinicNamePage({super.key, this.planId, this.isYearly = false});

  @override
  State<ChooseClinicNamePage> createState() => _ChooseClinicNamePageState();
}

class _ChooseClinicNamePageState extends State<ChooseClinicNamePage> {
  final _clinicNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _clinicNameController.dispose();
    super.dispose();
  }

  String? _validateClinicName(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your clinic name';
    }
    if (value.trim().length < 3) {
      return 'Clinic name must be at least 3 characters';
    }
    if (value.trim().length > 100) {
      return 'Clinic name must be less than 100 characters';
    }
    return null;
  }

  void _handleCreate() async {
    setState(() => _showValidationErrors = true);

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2)); // Simulated delay

      if (mounted) {
        setState(() => _isLoading = false);

        AppSnackbar.showSuccess(
          context,
          title: 'Success',
          message: 'Your clinic has been created!',
        );

        context.read<AuthBloc>().add(
          AuthEvent.signupNameChanged(_clinicNameController.text),
        );

        // Navigate to root page
        context.goNamed(AppRoutesNames.root);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          // Gradient Header
          GradientHeader(
            title: 'Name Your Clinic',
            subtitle: 'Choose a name that represents your practice',
            height: 200.h,
            showBackButton: true,
            onBackPressed: () => context.pop(),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: PaddingManager.horizontalPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),

                    // Clinic illustration
                    Center(
                      child: Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: ColorManager.primary10,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_hospital_outlined,
                          size: 56.w,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Info text
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: ColorManager.infoLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorManager.infoLight.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20.w,
                            color: ColorManager.infoExtraLight,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'This name will be displayed for you and your team members inside the app. You can change it later in settings.',
                              style: TextStyle(
                                color: ColorManager.infoExtraLight,
                                fontFamily: FontFamily.geist,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Clinic Name Field
                    AuthTextField(
                      label: 'Clinic Name',
                      hint: 'e.g., Bright Smile Dental Clinic',
                      controller: _clinicNameController,
                      prefixIcon: Icons.business_outlined,
                      keyboardType: TextInputType.text,
                      validator: _validateClinicName,
                      onChanged: (value) {
                        setState(() {
                          if (_showValidationErrors) {
                            _formKey.currentState?.validate();
                          }
                        });
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Character counter
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_clinicNameController.text.length}/100',
                        style: TextStyleManager.bodySmall.copyWith(
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
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
        child: PrimaryButton(
          text: 'Create',
          isLoading: _isLoading,
          isEnabled: _clinicNameController.text.trim().isNotEmpty,
          onPressed: _handleCreate,
        ),
      ),
    );
  }
}
