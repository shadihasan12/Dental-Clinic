import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/injection.dart';
import '../widgets/auth_desktop_shell.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatefulWidget {
  const _LoginPageContent();

  @override
  State<_LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showValidationErrors = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    FocusScope.of(context).unfocus();
    setState(() => _showValidationErrors = true);
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(const AuthEvent.loginSubmitted());
    }
  }

  String? _validateEmailOrPhone(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterEmailOrPhone;
    }
    final isEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    final isPhone = RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value.trim());
    if (!isEmail && !isPhone) {
      return l10n.pleaseEnterValidEmailOrPhone;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) return l10n.pleaseEnterPassword;
    if (value.length < 6) return l10n.passwordMinLength;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return AuthDesktopShell(
      child: Scaffold(
        backgroundColor: ColorManager.of(context).scaffoldBg,
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              (!previous.needsEmailVerification &&
                  current.needsEmailVerification) ||
              previous.loginError != current.loginError,
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              context.goNamed(AppRoutesNames.root);
            }
            if (state.needsEmailVerification) {
              context.pushNamed(
                AppRoutesNames.verifyEmailEntry,
                extra: context.read<AuthBloc>(),
              );
            }
            if (state.loginError != null) {
              AppSnackbar.showError(
                context,
                title: l10n.loginFailed,
                message: state.loginError,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),

                      // Logo
                      Center(
                        child: Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            color: ColorManager.primary10,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Icon(
                            Icons.medical_services_rounded,
                            color: ColorManager.primary,
                            size: 32.w,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Welcome text
                      Center(
                        child: Text(
                          l10n.welcomeBack,
                          style: TextStyle(
                            fontSize: FontSizesManager.s28,
                            fontWeight: FontWeightManager.bold,
                            fontFamily: fontFamily,
                            color: ColorManager.of(context).textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          l10n.signInToContinue,
                          style: TextStyle(
                            fontSize: FontSizesManager.s14,
                            fontFamily: fontFamily,
                            color: ColorManager.of(context).textSecondary,
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Fields
                      _buildEmailField(state, l10n),
                      SizedBox(height: 16.h),
                      _buildPasswordField(state, l10n),
                      SizedBox(height: 12.h),
                      _buildForgotPasswordLink(l10n, fontFamily),

                      SizedBox(height: 28.h),

                      // Sign in button
                      _buildSignInButton(state, l10n),

                      SizedBox(height: 40.h),

                      // Sign up link
                      _buildSignUpLink(l10n, fontFamily),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailField(AuthState state, AppLocalizations l10n) {
    return AuthTextField(
      label: l10n.emailOrPhone,
      hint: l10n.emailOrPhoneHint,
      controller: _emailController,
      prefixIcon: Icons.person_outline,
      keyboardType: TextInputType.text,
      textDirection: TextDirection.ltr,
      validator: _validateEmailOrPhone,
      onChanged: (value) {
        context.read<AuthBloc>().add(AuthEvent.loginEmailChanged(value));
        if (_showValidationErrors) _formKey.currentState?.validate();
      },
    );
  }

  Widget _buildPasswordField(AuthState state, AppLocalizations l10n) {
    return AuthTextField(
      label: l10n.password,
      hint: l10n.passwordHint,
      controller: _passwordController,
      prefixIcon: Icons.lock_outline,
      obscureText: !state.isLoginPasswordVisible,
      validator: _validatePassword,
      suffixIcon: GestureDetector(
        onTap: () => context.read<AuthBloc>().add(
          const AuthEvent.loginPasswordVisibilityToggled(),
        ),
        child: Icon(
          state.isLoginPasswordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: ColorManager.of(context).textTertiary,
          size: 20.w,
        ),
      ),
      onChanged: (value) {
        context.read<AuthBloc>().add(AuthEvent.loginPasswordChanged(value));
        if (_showValidationErrors) _formKey.currentState?.validate();
      },
    );
  }

  Widget _buildForgotPasswordLink(AppLocalizations l10n, String fontFamily) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () => context.pushNamed(AppRoutesNames.forgotPassword),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          l10n.forgotPasswordQuestion,
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeightManager.medium,
            fontFamily: fontFamily,
            fontSize: FontSizesManager.s12,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(AuthState state, AppLocalizations l10n) {
    return PrimaryButton(
      text: l10n.signIn,
      onPressed: state.isLoginLoading ? null : _handleSignIn,
      isLoading: state.isLoginLoading,
    );
  }

  Widget _buildDivider(AppLocalizations l10n, String fontFamily) {
    return Row(
      children: [
        Expanded(child: Divider(color: ColorManager.of(context).divider, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            l10n.orContinueWith,
            style: TextStyle(
              color: ColorManager.of(context).textTertiary,
              fontSize: FontSizesManager.s12,
              fontFamily: fontFamily,
            ),
          ),
        ),
        Expanded(child: Divider(color: ColorManager.of(context).divider, thickness: 1)),
      ],
    );
  }

  Widget _buildSignUpLink(AppLocalizations l10n, String fontFamily) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.dontHaveAccount,
          style: TextStyle(
            color: ColorManager.of(context).textSecondary,
            fontSize: FontSizesManager.s14,
            fontFamily: fontFamily,
          ),
        ),
        TextButton(
          onPressed: () => context.pushNamed(AppRoutesNames.emailEntry),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l10n.signUp,
            style: TextStyle(
              color: ColorManager.primary,
              fontWeight: FontWeightManager.semiBold,
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ],
    );
  }

}
