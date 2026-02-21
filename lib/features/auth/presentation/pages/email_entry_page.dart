import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class EmailEntryPage extends StatefulWidget {
  const EmailEntryPage({super.key});

  @override
  State<EmailEntryPage> createState() => _EmailEntryPageState();
}

class _EmailEntryPageState extends State<EmailEntryPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.showError(
        context,
        title: 'Email Required',
        message: 'Please enter your email address',
      );
      return;
    }

    // Update email in bloc
    context.read<AuthBloc>().add(AuthEvent.signupEmailChanged(email));

    // Request OTP
    context.read<AuthBloc>().add(const AuthEvent.otpRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: MultiBlocListener(
        listeners: [
          // Listen only for OTP success (countdown changes)
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpSecondsRemaining != current.otpSecondsRemaining,
            listener: (context, state) {
              if (state.otpSecondsRemaining > 0 && !state.isOtpLoading) {
                AppSnackbar.showSuccess(
                  context,
                  title: 'OTP Sent',
                  message: 'Verification code sent to ${state.signupEmail}',
                );

                // Navigate to OTP verification page
                context.pushNamed(
                  AppRoutesNames.emailVerification,
                  extra: context.read<AuthBloc>(),
                );
              }
            },
          ),
          // Listen only for error changes
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpError != current.otpError,
            listener: (context, state) {
              if (state.otpError != null && state.otpError!.isNotEmpty) {
                AppSnackbar.showError(
                  context,
                  title: 'Error',
                  message: state.otpError,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            // Only rebuild when UI-relevant fields change
            return previous.isOtpLoading != current.isOtpLoading ||
                previous.signupEmail != current.signupEmail ||
                previous.isSignupEmailValid != current.isSignupEmailValid;
          },
          builder: (context, state) {
          // Update email controller if bloc email changes
          if (_emailController.text != state.signupEmail) {
            _emailController.text = state.signupEmail;
          }

          return SafeArea(
            child: Column(
              children: [
                // Header
                GradientHeader(
                  title: 'Create Account',
                  subtitle: 'Enter your email to get started',
                  height: 200.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 32.h),

                        // Email icon
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: ColorManager.primary10,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.email_outlined,
                            size: 40.w,
                            color: ColorManager.primary,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Info text
                        Text(
                          'We\'ll send you a verification code to confirm your email address.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 32.h),

                        // Email input
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: ColorManager.textTertiary,
                          ),
                          enabled: !state.isOtpLoading,
                          onChanged: (value) {
                            context
                                .read<AuthBloc>()
                                .add(AuthEvent.signupEmailChanged(value));
                          },
                        ),

                        SizedBox(height: 8.h),

                        // Email validation message
                        if (state.signupEmail.isNotEmpty &&
                            !state.isSignupEmailValid)
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              'Please enter a valid email address',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontFamily.geist,
                                color: ColorManager.error,
                              ),
                            ),
                          ),

                        SizedBox(height: 32.h),

                        // Send OTP button
                        PrimaryButton(
                          text: 'Send Verification Code',
                          onPressed: state.isOtpLoading ||
                                  !state.isSignupEmailValid
                              ? null
                              : _handleSendOtp,
                          isLoading: state.isOtpLoading,
                        ),

                        SizedBox(height: 24.h),

                        // Login link
                        Row(
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
                              onPressed: () =>
                                  context.goNamed(AppRoutesNames.login),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.geist,
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}
