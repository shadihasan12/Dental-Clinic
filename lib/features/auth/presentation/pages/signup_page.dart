import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/constants/validation_constants.dart';
import 'package:dental_clinic_app/core/resources/button_styles.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';

/// Unified signup page for all dental professionals
/// Users can later create or join clinics from the dashboard
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const _SignupContent(),
    );
  }
}

class _SignupContent extends StatefulWidget {
  const _SignupContent();

  @override
  State<_SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<_SignupContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _licenseController = TextEditingController();
  final _specializationController = TextEditingController();
  bool _showValidationErrors = false;
  bool _showOptionalFields = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    setState(() => _showValidationErrors = true);

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(const AuthEvent.signupSubmitted());
    }
  }

  String? _validateName(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return ValidationConstants.nameRequired;
    }
    if (!ValidationConstants.isValidName(value)) {
      return ValidationConstants.nameTooShort;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return ValidationConstants.emailRequired;
    }
    if (!ValidationConstants.isValidEmail(value)) {
      return ValidationConstants.emailInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return ValidationConstants.passwordRequired;
    }
    if (!ValidationConstants.isValidPassword(value)) {
      return ValidationConstants.passwordTooShort;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return ValidationConstants.passwordsDoNotMatch;
    }
    return null;
  }

  void _validateForm() {
    if (_showValidationErrors) {
      _formKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.goNamed(AppRoutesNames.root);
          }
          if (state.signupError != null) {
            AppSnackbar.showError(
              context,
              title: 'Signup Failed',
              message: state.signupError,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Gradient Header
                GradientHeader(
                  title: 'Create Account',
                  subtitle: 'Join our dental community',
                  height: 180.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),

                // Signup Form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),

                        // Welcome message
                        _buildInfoBox(),

                        SizedBox(height: 24.h),

                        // Full Name Field
                        AuthTextField(
                          label: 'Full Name *',
                          hint: 'Dr. John Smith',
                          controller: _nameController,
                          prefixIcon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          validator: _validateName,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                                  AuthEvent.signupNameChanged(value),
                                );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Email Field
                        AuthTextField(
                          label: 'Email *',
                          hint: 'doctor@example.com',
                          controller: _emailController,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                                  AuthEvent.signupEmailChanged(value),
                                );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Password Field
                        AuthTextField(
                          label: 'Password *',
                          hint: 'Create a password',
                          controller: _passwordController,
                          prefixIcon: Icons.lock_outline,
                          obscureText: !state.isSignupPasswordVisible,
                          validator: _validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isSignupPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: ColorManager.textTertiary,
                              size: 20.w,
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    const AuthEvent.signupPasswordVisibilityToggled(),
                                  );
                            },
                          ),
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                                  AuthEvent.signupPasswordChanged(value),
                                );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Confirm Password Field
                        AuthTextField(
                          label: 'Confirm Password *',
                          hint: 'Confirm your password',
                          controller: _confirmPasswordController,
                          prefixIcon: Icons.lock_outline,
                          obscureText: !state.isSignupConfirmPasswordVisible,
                          validator: _validateConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isSignupConfirmPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: ColorManager.textTertiary,
                              size: 20.w,
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    const AuthEvent.signupConfirmPasswordVisibilityToggled(),
                                  );
                            },
                          ),
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                                  AuthEvent.signupConfirmPasswordChanged(value),
                                );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Optional Fields Toggle
                        _buildOptionalFieldsToggle(),

                        // Optional Fields
                        if (_showOptionalFields) ...[
                          SizedBox(height: 16.h),

                          AuthTextField(
                            label: 'License Number',
                            hint: 'DDS-12345',
                            controller: _licenseController,
                            prefixIcon: Icons.badge_outlined,
                            onChanged: (value) {
                              context.read<AuthBloc>().add(
                                    AuthEvent.signupLicenseNumberChanged(value),
                                  );
                            },
                          ),

                          SizedBox(height: 16.h),

                          AuthTextField(
                            label: 'Specialization',
                            hint: 'e.g., Orthodontics, General Dentistry',
                            controller: _specializationController,
                            prefixIcon: Icons.local_hospital_outlined,
                            onChanged: (value) {
                              context.read<AuthBloc>().add(
                                    AuthEvent.signupSpecializationChanged(value),
                                  );
                            },
                          ),
                        ],

                        SizedBox(height: 32.h),

                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: state.isSignupLoading ? null : _handleSignUp,
                            style: ButtonStyles.primaryLarge,
                            child: state.isSignupLoading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorManager.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Create Account',
                                    style: TextStyleManager.button.copyWith(
                                      color: ColorManager.white,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Login link
                        _buildLoginLink(),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.info.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.info.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: ColorManager.info,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Create your account, then set up or join a clinic from your dashboard.',
              style: TextStyleManager.bodySmall.copyWith(
                color: ColorManager.info,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionalFieldsToggle() {
    return GestureDetector(
      onTap: () {
        setState(() => _showOptionalFields = !_showOptionalFields);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.gray50,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showOptionalFields ? Icons.expand_less : Icons.expand_more,
              color: ColorManager.textSecondary,
              size: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              _showOptionalFields
                  ? 'Hide professional details'
                  : 'Add professional details (optional)',
              style: TextStyleManager.bodySmall.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyleManager.bodyMedium.copyWith(
            color: ColorManager.textSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.goNamed(AppRoutesNames.login),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Log In',
            style: TextStyleManager.bodyMedium.copyWith(
              color: ColorManager.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
