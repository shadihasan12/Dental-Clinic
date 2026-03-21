import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
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
        create: (context) => getIt<AuthBloc>(),
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showValidationErrors = false;

  SpecialtyEntity? _selectedSpecialty;

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
    _firstNameController.dispose();
    _lastNameController.dispose();
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
      if (_selectedSpecialty == null) {
        AppSnackbar.showError(
          context,
          title: l10n.validationError,
          message: l10n.pleaseSelectSpecialization,
        );
        return;
      }

      final authBloc = context.read<AuthBloc>();
      context.pushNamed(
        AppRoutesNames.chooseClinicName,
        extra: authBloc,
      );
    }
  }

  String? _validateFirstName(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterFirstName;
    }
    if (!ValidationConstants.isValidName(value)) {
      return l10n.nameTooShort;
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterLastName;
    }
    if (!ValidationConstants.isValidName(value)) {
      return l10n.nameTooShort;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterYourEmail;
    }
    if (!ValidationConstants.isValidEmail(value)) {
      return l10n.pleaseEnterValidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterYourPassword;
    }
    if (!ValidationConstants.isValidPassword(value)) {
      return l10n.passwordTooShort;
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
      return l10n.passwordsDoNotMatch;
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
      backgroundColor: ColorManager.of(context).scaffoldBg,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: ColorManager.of(context).textSecondary,
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
                                color: ColorManager.of(context).textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              l10n.checkConnectionRetry,
                              style: TextStyle(
                                fontSize: FontSizesManager.s14,
                                fontFamily: fontFamily,
                                color: ColorManager.of(context).textSecondary,
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

                    Row(
                      children: [
                        Expanded(
                          child: AuthTextField(
                            label: l10n.firstNameRequired,
                            hint: l10n.firstNameHint,
                            controller: _firstNameController,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: _validateFirstName,
                            onChanged: (value) {
                              context.read<AuthBloc>().add(
                                AuthEvent.signupFirstNameChanged(value),
                              );
                              _validateForm();
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AuthTextField(
                            label: l10n.lastNameRequired,
                            hint: l10n.lastNameHint,
                            controller: _lastNameController,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: _validateLastName,
                            onChanged: (value) {
                              context.read<AuthBloc>().add(
                                AuthEvent.signupLastNameChanged(value),
                              );
                              _validateForm();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    AuthTextField(
                      label: l10n.emailRequired,
                      hint: l10n.emailHint,
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textDirection: TextDirection.ltr,
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

                    _buildSpecialtyPicker(l10n, fontFamily, state),
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
                          color: ColorManager.of(context).textTertiary,
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
                          color: ColorManager.of(context).textTertiary,
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

  Widget _buildSpecialtyPicker(AppLocalizations l10n, String fontFamily, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.specializationRequired,
          style: TextStyle(
            color: ColorManager.of(context).textPrimary,
            fontWeight: FontWeightManager.medium,
            fontFamily: fontFamily,
            fontSize: FontSizesManager.s12,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showSpecialtySheet(l10n, fontFamily, state),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: ColorManager.of(context).inputBg,
              borderRadius: BorderRadius.circular(12.r),
              border: _showValidationErrors && _selectedSpecialty == null
                  ? Border.all(color: ColorManager.error, width: 1)
                  : null,
            ),
            child: Row(
              children: [
                Icon(Icons.local_hospital_outlined, color: ColorManager.of(context).textTertiary, size: 20.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _selectedSpecialty?.name ?? l10n.selectYourSpecialization,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: FontSizesManager.s14,
                      color: _selectedSpecialty != null
                          ? ColorManager.of(context).textPrimary
                          : ColorManager.of(context).textTertiary,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: ColorManager.of(context).textTertiary),
              ],
            ),
          ),
        ),
        if (_showValidationErrors && _selectedSpecialty == null)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 12.w),
            child: Text(
              l10n.pleaseSelectSpecialty,
              style: TextStyle(
                fontSize: FontSizesManager.s12,
                fontFamily: fontFamily,
                color: ColorManager.error,
              ),
            ),
          ),
      ],
    );
  }

  void _showSpecialtySheet(AppLocalizations l10n, String fontFamily, AuthState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorManager.of(context).borderLight,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Text(
                  l10n.specialization,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
              ),
              ...state.specialties.map((spec) {
                final isSelected = _selectedSpecialty?.id == spec.id;
                return InkWell(
                  onTap: () {
                    setState(() => _selectedSpecialty = spec);
                    this.context.read<AuthBloc>().add(
                      AuthEvent.signupSpecialtyEntitySelected(spec),
                    );
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? ColorManager.primary
                                  : ColorManager.of(context).borderLight,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          spec.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: fontFamily,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: isSelected
                                ? ColorManager.primary
                                : ColorManager.of(context).textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
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
                color: ColorManager.of(context).cardBgSecondary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.of(context).textPrimary,
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
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.joinDentalCommunity,
            style: TextStyle(
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
              color: ColorManager.of(context).textSecondary,
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
            color: ColorManager.of(context).textSecondary,
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
