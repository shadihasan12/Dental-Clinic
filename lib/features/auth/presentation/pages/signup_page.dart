import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_drop_down.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
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
    final providedBloc = context.read<AuthBloc?>();

    if (providedBloc != null) {
      return const _SignupContent();
    } else {
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

      if (state.signupEmail.isNotEmpty) {
        _emailController.text = state.signupEmail;
      }

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
    final l10n = AppLocalizations.of(context)!;

    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedSpecialtyName == null) {
        AppSnackbar.showError(
          context,
          title: l10n.validationError,
          message: l10n.pleaseSelectSpecialization,
        );
        return;
      }

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
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseConfirmPassword;
    }
    if (value != _passwordController.text) {
      return ValidationConstants.passwordsDoNotMatch;
    }
    return null;
  }

  String? _validateMobileNumber(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.mobileRequired;
    }
    if (value.length < 8) {
      return l10n.mobileTooShort;
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
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

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
              title: l10n.signupFailed,
              message: state.signupError,
            );
          }
        },
        builder: (context, state) {
          if (state.isLoadingSpecialties || state.isLoadingPlans) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _buildTopBar(l10n, fontFamily),
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
                              l10n.loading,
                              style: TextStyle(
                                fontSize: FontSizesManager.s16,
                                fontFamily: fontFamily,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final hasLoadingError = (state.specialties.isEmpty && !state.isLoadingSpecialties) ||
              (state.plans.isEmpty && !state.isLoadingPlans);

          if (hasLoadingError) {
            return SafeArea(
              child: Column(
                children: [
                  _buildTopBar(l10n, fontFamily),
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
                              l10n.failedToLoadData,
                              style: TextStyle(
                                fontSize: FontSizesManager.s18,
                                fontWeight: FontWeightManager.semiBold,
                                fontFamily: fontFamily,
                                color: ColorManager.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              l10n.checkConnectionRetry,
                              style: TextStyle(
                                fontSize: FontSizesManager.s14,
                                fontFamily: fontFamily,
                                color: ColorManager.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32.h),
                            PrimaryButton(
                              text: l10n.retry,
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
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(l10n, fontFamily),
                    SizedBox(height: 8.h),
                    _buildInfoBox(l10n, fontFamily),
                    SizedBox(height: 24.h),

                    AuthTextField(
                      label: l10n.fullNameRequired,
                      hint: l10n.fullNameHint,
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

                    AuthTextField(
                      label: l10n.emailRequired,
                      hint: l10n.emailHint,
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

                    AuthTextField(
                      label: l10n.mobileNumber,
                      hint: l10n.mobileHint,
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

                    AuthDropdownField(
                      label: l10n.specializationRequired,
                      hint: l10n.selectYourSpecialization,
                      value: _selectedSpecialtyName,
                      items: state.specialties.map((s) => s.name).toList(),
                      prefixIcon: Icons.local_hospital_outlined,
                      onChanged: (value) {
                        final selectedSpecialty = state.specialties
                            .firstWhere((s) => s.name == value);
                        setState(() => _selectedSpecialtyName = value);
                        context.read<AuthBloc>().add(
                          AuthEvent.signupSpecialtyEntitySelected(selectedSpecialty),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),

                    AuthTextField(
                      label: l10n.passwordRequired,
                      hint: l10n.createPassword,
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

                    AuthTextField(
                      label: l10n.confirmPassword,
                      hint: l10n.confirmPasswordHint,
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
                    SizedBox(height: 40.h),

                    PrimaryButton(
                      text: l10n.next,
                      onPressed: state.isSignupLoading ? null : _handleNext,
                      isLoading: state.isSignupLoading,
                    ),
                    SizedBox(height: 24.h),

                    _buildLoginLink(l10n, fontFamily),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopBar(AppLocalizations l10n, String fontFamily) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: ColorManager.gray100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.textPrimary,
                size: 18.w,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            l10n.createAccount,
            style: TextStyle(
              fontSize: FontSizesManager.s28,
              fontWeight: FontWeightManager.bold,
              fontFamily: fontFamily,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.joinDentalCommunity,
            style: TextStyle(
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(AppLocalizations l10n, String fontFamily) {
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
          Icon(Icons.info_outline, color: ColorManager.infoExtraLight, size: 20.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              l10n.signupInfoBox,
              style: TextStyle(
                color: ColorManager.infoExtraLight,
                fontSize: FontSizesManager.s14,
                fontFamily: fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink(AppLocalizations l10n, String fontFamily) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.alreadyHaveAccount,
          style: TextStyle(
            fontSize: FontSizesManager.s14,
            fontFamily: fontFamily,
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
            l10n.logIn,
            style: TextStyle(
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
              color: ColorManager.primary,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
