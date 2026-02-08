import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/injection.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(getIt()),
      child: const _ForgotPasswordPageContent(),
    );
  }
}

class _ForgotPasswordPageContent extends StatelessWidget {
  const _ForgotPasswordPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.forgotPasswordError != null) {
            AppSnackbar.showError(context, title: 'Error', message: state.forgotPasswordError);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Gradient Header
                GradientHeader(
                  title: 'Forgot Password',
                  subtitle: "Enter your email and we'll send you a reset link",
                  height: 240.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),

                // Content
                Padding(
                  padding: PaddingManager.horizontalPadding,
                  child: state.isForgotPasswordSuccess
                      ? _buildSuccessContent(context)
                      : _buildFormContent(context, state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormContent(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32.h),

        // Email illustration
        Center(
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: ColorManager.primary10,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline,
              size: 48.w,
              color: ColorManager.primary,
            ),
          ),
        ),

        SizedBox(height: 32.h),

        // Email Field
        Text(
          'Email Address',
          style: TextStyleManager.labelLarge.copyWith(
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: 'Enter your registered email',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: ColorManager.textSecondary,
          ),
          onChanged: (value) {
            context
                .read<AuthBloc>()
                .add(AuthEvent.forgotPasswordEmailChanged(value));
          },
        ),

        SizedBox(height: 32.h),

        // Submit Button
        PrimaryButton(
          text: 'Send Reset Link',
          isLoading: state.isForgotPasswordLoading,
          isEnabled: state.isForgotPasswordEmailValid,
          onPressed: () {
            context
                .read<AuthBloc>()
                .add(const AuthEvent.forgotPasswordSubmitted());
          },
        ),

        SizedBox(height: 24.h),

        // Back to Login
        Center(
          child: CustomTextButton(
            text: 'Back to Sign In',
            onPressed: () => context.pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48.h),

        // Success illustration
        Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: ColorManager.successBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            size: 64.w,
            color: ColorManager.success,
          ),
        ),

        SizedBox(height: 32.h),

        // Success message
        Text(
          'Email Sent!',
          style: TextStyleManager.headlineLarge.copyWith(
            color: ColorManager.textPrimary,
          ),
        ),

        SizedBox(height: 12.h),

        Text(
          'We have sent a password reset link to your email address. Please check your inbox and follow the instructions.',
          textAlign: TextAlign.center,
          style: TextStyleManager.bodyMedium.copyWith(
            color: ColorManager.textSecondary,
          ),
        ),

        SizedBox(height: 40.h),

        // Back to Login Button
        PrimaryButton(
          text: 'Back to Sign In',
          onPressed: () => context.pop(),
        ),

        SizedBox(height: 16.h),

        // Resend Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the email? ",
              style: TextStyleManager.bodyMedium.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
            CustomTextButton(
              text: 'Resend',
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEvent.forgotPasswordReset());
              },
            ),
          ],
        ),
      ],
    );
  }
}
