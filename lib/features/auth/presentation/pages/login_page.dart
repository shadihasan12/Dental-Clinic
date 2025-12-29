import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
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
    setState(() => _showValidationErrors = true);
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(const AuthEvent.loginSubmitted());
    }
  }

  String? _validateEmail(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_showValidationErrors) return null;
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
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
          if (state.loginError != null) {
            AppSnackbar.showError(context, title: 'Login Failed', message: state.loginError);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AuthHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),
                        _buildEmailField(state),
                        SizedBox(height: 20.h),
                        _buildPasswordField(state),
                        SizedBox(height: 12.h),
                        _buildForgotPasswordLink(),
                        SizedBox(height: 24.h),
                        _buildSignInButton(state),
                        SizedBox(height: 24.h),
                        _buildDivider(),
                        SizedBox(height: 24.h),
                        SocialLoginButtons(onGooglePressed: () {}, onFacebookPressed: () {}),
                        SizedBox(height: 32.h),
                        _buildSignUpLink(),
                        SizedBox(height: 32.h),
                        _buildFooter(),
                        SizedBox(height: 24.h),
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

  Widget _buildEmailField(AuthState state) {
    return AuthTextField(
      label: 'Email Address',
      hint: 'Enter your email',
      controller: _emailController,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
      onChanged: (value) {
        context.read<AuthBloc>().add(AuthEvent.loginEmailChanged(value));
        if (_showValidationErrors) _formKey.currentState?.validate();
      },
    );
  }

  Widget _buildPasswordField(AuthState state) {
    return AuthTextField(
      label: 'Password',
      hint: 'Enter your password',
      controller: _passwordController,
      prefixIcon: Icons.lock_outline,
      obscureText: !state.isLoginPasswordVisible,
      validator: _validatePassword,
      suffixIcon: IconButton(
        icon: Icon(state.isLoginPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: ColorManager.textTertiary, size: 20.w),
        onPressed: () => context.read<AuthBloc>().add(const AuthEvent.loginPasswordVisibilityToggled()),
      ),
      onChanged: (value) {
        context.read<AuthBloc>().add(AuthEvent.loginPasswordChanged(value));
        if (_showValidationErrors) _formKey.currentState?.validate();
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.pushNamed(AppRoutesNames.forgotPassword),
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text('Forgot Password?', style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.primary, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildSignInButton(AuthState state) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: state.isLoginLoading ? null : _handleSignIn,
        style: ElevatedButton.styleFrom(backgroundColor: ColorManager.primary, foregroundColor: ColorManager.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
        child: state.isLoginLoading
            ? SizedBox(width: 24.w, height: 24.h, child: const CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white)))
            : Text('Sign In', style: TextStyleManager.button.copyWith(color: ColorManager.white, fontSize: 16.sp)),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: ColorManager.gray200, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('Or continue with', style: TextStyleManager.bodySmall.copyWith(color: ColorManager.textTertiary)),
        ),
        Expanded(child: Divider(color: ColorManager.gray200, thickness: 1)),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textSecondary)),
        TextButton(
          onPressed: () => context.pushNamed(AppRoutesNames.register),
          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text('Sign Up', style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Center(child: Text('\u00A9 2024 DentalCare Pro. All rights reserved.', style: TextStyleManager.bodySmall.copyWith(color: ColorManager.textTertiary)));
  }
}
