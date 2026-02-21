import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/constants/validation_constants.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';
import 'package:dental_clinic_app/injection.dart';

/// Unified signup page for all dental professionals
/// Users can later create or join clinics from the dashboard
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if AuthBloc was provided via route (from OTP verification)
    // If not provided, create a new one for direct access
    final providedBloc = context.read<AuthBloc?>();

    if (providedBloc != null) {
      // Use the provided bloc (from OTP verification)
      return const _SignupContent();
    } else {
      // Create new bloc for direct access
      return BlocProvider(
        create: (context) => AuthBloc(getIt(), getIt()),
        child: const _SignupContent(),
      );
    }
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
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showValidationErrors = false;

  String? _selectedSpecialtyName;

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<AuthBloc>();
      final state = bloc.state;

      // If email is already set (from OTP verification), populate the field
      if (state.signupEmail.isNotEmpty) {
        _emailController.text = state.signupEmail;
      }

      // Fetch all required data only if not already loaded
      // This allows users to complete signup without internet after initial load
      if (state.specialties.isEmpty && !state.isLoadingSpecialties) {
        bloc.add(const AuthEvent.specialtiesRequested());
      }
      if (state.plans.isEmpty && !state.isLoadingPlans) {
        bloc.add(const AuthEvent.plansRequested());
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleNext() {
    setState(() => _showValidationErrors = true);

    if (_formKey.currentState?.validate() ?? false) {
      // Validate specialty is selected
      if (_selectedSpecialtyName == null) {
        AppSnackbar.showError(
          context,
          title: 'Validation Error',
          message: 'Please select a specialization',
        );
        return;
      }

      // Pass the AuthBloc instance to the next route
      final authBloc = context.read<AuthBloc>();
      context.pushNamed(
        AppRoutesNames.choosePlan,
        extra: authBloc,
      );
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

  String? _validateMobileNumber(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length < 8) {
      return 'Mobile number is too short';
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
          // Show loading screen while data is being loaded
          if (state.isLoadingSpecialties || state.isLoadingPlans) {
            return Column(
              children: [
                GradientHeader(
                  title: 'Create Account',
                  subtitle: 'Join our dental community',
                  height: 180.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          // Show error screen with retry button if loading failed
          final hasLoadingError = (state.specialties.isEmpty && !state.isLoadingSpecialties) ||
              (state.plans.isEmpty && !state.isLoadingPlans);

          if (hasLoadingError) {
            return Column(
              children: [
                GradientHeader(
                  title: 'Create Account',
                  subtitle: 'Join our dental community',
                  height: 180.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.w,
                            color: ColorManager.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Failed to load required data',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.geist,
                              color: ColorManager.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Please check your connection and try again',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontFamily.geist,
                              color: ColorManager.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32.h),
                          PrimaryButton(
                            text: 'Retry',
                            onPressed: () {
                              final bloc = context.read<AuthBloc>();
                              bloc.add(const AuthEvent.specialtiesRequested());
                              bloc.add(const AuthEvent.plansRequested());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Show signup form when specializations are loaded
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

                        // Email Field (read-only if verified via OTP)
                        AuthTextField(
                          label: 'Email *',
                          hint: 'doctor@example.com',
                          controller: _emailController,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          enabled: state.sessionId == null || state.sessionId!.isEmpty,
                          suffixIcon: state.sessionId != null && state.sessionId!.isNotEmpty
                              ? Icon(Icons.verified, color: ColorManager.success)
                              : null,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                              AuthEvent.signupEmailChanged(value),
                            );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Mobile Number Field
                        AuthTextField(
                          label: 'Mobile Number *',
                          hint: '091234567',
                          controller: _mobileController,
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: _validateMobileNumber,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(
                              AuthEvent.signupMobileNumberChanged(value),
                            );
                            _validateForm();
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Specialization Field (using API data)
                        AuthDropdownField(
                          label: 'Specialization *',
                          hint: 'Select your specialization',
                          value: _selectedSpecialtyName,
                          items: state.specialties
                              .map((s) => s.name)
                              .toList(),
                          prefixIcon: Icons.local_hospital_outlined,
                          onChanged: (value) {
                            // Find the specialty entity with matching name
                            final selectedSpecialty = state.specialties
                                .firstWhere((s) => s.name == value);
                            setState(() => _selectedSpecialtyName = value);
                            context.read<AuthBloc>().add(
                              AuthEvent.signupSpecialtyEntitySelected(selectedSpecialty),
                            );
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

                        SizedBox(height: 32.h),

                        // Sign Up Button
                        PrimaryButton(
                          text: 'Next',
                          onPressed: state.isSignupLoading ? null : _handleNext,
                          isLoading: state.isSignupLoading,
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
        color: ColorManager.infoLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.infoLight.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: ColorManager.infoExtraLight,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Create your account, then set up or join a clinic from your dashboard.',
              style: TextStyle(
                color: ColorManager.infoExtraLight,
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontFamily.geist,
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
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
