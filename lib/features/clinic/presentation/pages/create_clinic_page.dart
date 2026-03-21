import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/clinic_bloc.dart';

class CreateClinicPage extends StatelessWidget {
  const CreateClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClinicBloc(),
      child: const _CreateClinicContent(),
    );
  }
}

class _CreateClinicContent extends StatefulWidget {
  const _CreateClinicContent();

  @override
  State<_CreateClinicContent> createState() => _CreateClinicContentState();
}

class _CreateClinicContentState extends State<_CreateClinicContent> {
  final _formKey = GlobalKey<FormState>();
  final _clinicNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _showValidationErrors = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _clinicNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    setState(() {
      _showValidationErrors = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Replace with actual API call
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          AppSnackbar.showSuccess(
            context,
            title: 'Clinic Created',
            message: 'Your clinic has been created successfully',
          );
          context.pop();
        }
      });
    }
  }

  String? _validateClinicName(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return 'Please enter a clinic name';
    }
    if (value.length < 2) {
      return 'Clinic name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (!_showValidationErrors) return null;
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: GradientHeader(
              title: 'Create Clinic',
              subtitle: 'Set up your dental practice',
              height: 160.h,
              showBackButton: true,
              onBackPressed: () => context.pop(),
            ),
          ),

          // Form
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ColorManager.of(context).cardBg,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info Banner
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.info.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: ColorManager.info,
                              size: 24.w,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                'You will become the admin of this clinic and can invite other dentists and staff.',
                                style: TextStyleManager.bodySmall.copyWith(
                                  color: ColorManager.info,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Clinic Name
                      _buildLabel('Clinic Name *'),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _clinicNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: _validateClinicName,
                        onChanged: (_) {
                          if (_showValidationErrors) {
                            _formKey.currentState?.validate();
                          }
                        },
                        decoration: _buildInputDecoration(
                          hintText: 'My Dental Clinic',
                          prefixIcon: const Icon(Icons.business),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Address
                      _buildLabel('Address'),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _addressController,
                        textCapitalization: TextCapitalization.words,
                        decoration: _buildInputDecoration(
                          hintText: '123 Main Street, City (Optional)',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Phone
                      _buildLabel('Phone Number'),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: _buildInputDecoration(
                          hintText: '+1 234 567 8900 (Optional)',
                          prefixIcon: const Icon(Icons.phone_outlined),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Email
                      _buildLabel('Clinic Email'),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        onChanged: (_) {
                          if (_showValidationErrors) {
                            _formKey.currentState?.validate();
                          }
                        },
                        decoration: _buildInputDecoration(
                          hintText: 'contact@myclinic.com (Optional)',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Description
                      _buildLabel('Description'),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3,
                        decoration: _buildInputDecoration(
                          hintText: 'Tell patients about your clinic (Optional)',
                          prefixIcon: const Icon(Icons.description_outlined),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Create Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleCreate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Create Clinic',
                                  style: TextStyleManager.button.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyleManager.titleSmall.copyWith(
        color: ColorManager.of(context).textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required Widget prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.of(context).textTertiary,
      ),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: ColorManager.of(context).inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: 1.5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
    );
  }
}
