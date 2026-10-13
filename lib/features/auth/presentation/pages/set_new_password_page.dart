import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/account_rules.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_desktop_shell.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    setState(() => _showValidationErrors = true);
    // After the frame, so the validators just switched on are the ones run.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_formKey.currentState?.validate() ?? false) {
        context.read<AuthBloc>().add(const AuthEvent.resetPasswordSubmitted());
      }
    });
  }

  void _validateForm() {
    if (_showValidationErrors) _formKey.currentState?.validate();
  }

  /// The session this reset rides on is used up or has run out, so no
  /// password typed here can be saved. Says so and goes back to the email
  /// step - still filled in - for a new code.
  void _onSessionExpired() {
    final l10n = AppLocalizations.of(context)!;
    final router = GoRouter.of(context);
    AppSnackbar.showError(
      context,
      title: l10n.sessionExpired,
      message: l10n.resetSessionExpiredMessage,
    );
    // This page, then the code screen under it.
    router.pop();
    if (router.canPop()) router.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return AuthDesktopShell(imageIndex: 2, child: Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.isResetPasswordSuccess != current.isResetPasswordSuccess,
            listener: (context, state) {
              if (state.isResetPasswordSuccess &&
                  state.isSignedInPasswordChange) {
                // Opened from inside the app: back to the page that started
                // it - this one, the code screen and the email step.
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.passwordChangedTitle,
                  message: l10n.passwordChangedMessage,
                );
                Navigator.of(context).popUntil((route) {
                  final name = route.settings.name;
                  return name != AppRoutesNames.setNewPassword &&
                      name != AppRoutesNames.forgotPasswordVerifyOtp &&
                      name != AppRoutesNames.forgotPassword;
                });
              } else if (state.isResetPasswordSuccess) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.passwordResetSuccess,
                  message: l10n.passwordResetSuccessMessage,
                );
                context.goNamed(AppRoutesNames.login);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                !previous.resetSessionExpired && current.resetSessionExpired,
            listener: (context, state) => _onSessionExpired(),
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.resetPasswordError != current.resetPasswordError,
            listener: (context, state) {
              if (state.resetPasswordError != null &&
                  state.resetPasswordError!.isNotEmpty) {
                AppSnackbar.showError(
                  context,
                  title: l10n.error,
                  message: state.resetPasswordError,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.isResetPasswordLoading != current.isResetPasswordLoading ||
              previous.isResetPasswordVisible != current.isResetPasswordVisible ||
              previous.isResetPasswordConfirmVisible !=
                  current.isResetPasswordConfirmVisible,
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Back button
                    AuthBackButton(onTap: () => context.pop()),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      l10n.setNewPassword,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.enterNewPasswordBelow,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Lock icon
                    AuthHeroGlyph(icon: Icons.lock_outline),

                    SizedBox(height: 32.h),

                    // New password field
                    AuthTextField(
                      label: l10n.newPassword,
                      hint: l10n.createPassword,
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !state.isResetPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isResetPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: ColorManager.of(context).textTertiary,
                          size: 20.w,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEvent
                                    .resetPasswordVisibilityToggled(),
                              );
                        },
                      ),
                      validator: _showValidationErrors
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterYourPassword;
                              }
                              return PasswordRules.problem(l10n, value);
                            }
                          : null,
                      onChanged: (value) {
                        context.read<AuthBloc>().add(
                              AuthEvent.resetPasswordNewChanged(value),
                            );
                        // A password wiped to start over takes its
                        // confirmation with it.
                        if (value.isEmpty &&
                            _confirmPasswordController.text.isNotEmpty) {
                          _confirmPasswordController.clear();
                          context.read<AuthBloc>().add(
                                const AuthEvent.resetPasswordConfirmChanged(''),
                              );
                        }
                        _validateForm();
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Confirm password field
                    AuthTextField(
                      label: l10n.confirmPassword,
                      hint: l10n.confirmPasswordHint,
                      controller: _confirmPasswordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !state.isResetPasswordConfirmVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isResetPasswordConfirmVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: ColorManager.of(context).textTertiary,
                          size: 20.w,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEvent
                                    .resetPasswordConfirmVisibilityToggled(),
                              );
                        },
                      ),
                      validator: _showValidationErrors
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseConfirmPassword;
                              }
                              if (value != _passwordController.text) {
                                return l10n.passwordsDoNotMatch;
                              }
                              return null;
                            }
                          : null,
                      onChanged: (value) {
                        context.read<AuthBloc>().add(
                              AuthEvent.resetPasswordConfirmChanged(value),
                            );
                        _validateForm();
                      },
                    ),

                    SizedBox(height: 40.h),

                    // Reset password button
                    PrimaryButton(
                      text: l10n.resetPasswordButton,
                      isLoading: state.isResetPasswordLoading,
                      onPressed:
                          state.isResetPasswordLoading ? null : _handleResetPassword,
                    ),

                    SizedBox(height: 32.h),
                  ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),);
  }
}
