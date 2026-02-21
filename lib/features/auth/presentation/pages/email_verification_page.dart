import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _countdownTimer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    // Start countdown if OTP was already sent from previous page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state.otpSecondsRemaining > 0) {
        _startCountdown(state.otpSecondsRemaining);
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCountdown(int seconds) {
    _countdownTimer?.cancel();
    setState(() => _secondsRemaining = seconds);

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 5) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        // All fields filled, unfocus
        _otpFocusNodes[index].unfocus();
      }
    }

    // Combine all OTP digits
    final otpCode = _otpControllers.map((c) => c.text).join();
    context.read<AuthBloc>().add(AuthEvent.otpCodeChanged(otpCode));

    // Auto-verify when all 6 digits are entered and not already verifying
    final state = context.read<AuthBloc>().state;
    if (otpCode.length == 6 && !state.isOtpVerifying) {
      // Validate that all characters are digits
      if (RegExp(r'^\d{6}$').hasMatch(otpCode)) {
        context.read<AuthBloc>().add(const AuthEvent.otpVerified());
      }
    }
  }

  void _handleResendOtp() {
    if (_secondsRemaining == 0) {
      // Clear all OTP fields
      for (var controller in _otpControllers) {
        controller.clear();
      }
      context.read<AuthBloc>().add(const AuthEvent.otpResendRequested());
    }
  }

  void _handleVerify() {
    final otpCode = _otpControllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      context.read<AuthBloc>().add(const AuthEvent.otpVerified());
    } else {
      AppSnackbar.showError(
        context,
        title: 'Invalid Code',
        message: 'Please enter all 6 digits',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: MultiBlocListener(
        listeners: [
          // Listen only for countdown changes
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpSecondsRemaining != current.otpSecondsRemaining,
            listener: (context, state) {
              if (state.otpSecondsRemaining > 0 && _secondsRemaining == 0) {
                _startCountdown(state.otpSecondsRemaining);
              }
            },
          ),
          // Listen only for session ID changes (success)
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.sessionId != current.sessionId,
            listener: (context, state) {
              if (state.sessionId != null && state.sessionId!.isNotEmpty) {
                AppSnackbar.showSuccess(
                  context,
                  title: 'Email Verified',
                  message: 'Please complete your registration',
                );
                context.pushReplacementNamed(
                  AppRoutesNames.register,
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
                  title: 'Verification Failed',
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
                previous.isOtpVerifying != current.isOtpVerifying ||
                previous.signupEmail != current.signupEmail;
          },
          builder: (context, state) {
            return SafeArea(
            child: Column(
              children: [
                // Header
                GradientHeader(
                  title: 'Verify Your Email',
                  subtitle: 'Enter the code sent to your email',
                  height: 200.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
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

                        SizedBox(height: 24.h),

                        // Email address
                        Text(
                          state.signupEmail,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textPrimary,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          'We\'ve sent a 6-digit verification code',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 40.h),

                        // OTP Input Fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Container(
                              width: 48.w,
                              height: 56.h,
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              child: TextField(
                                controller: _otpControllers[index],
                                focusNode: _otpFocusNodes[index],
                                enabled: !state.isOtpVerifying,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  obscureText: true,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.geist,
                                    color: ColorManager.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: ColorManager.gray100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: ColorManager.gray300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: ColorManager.gray300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: ColorManager.primary,
                                        width: 2,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: ColorManager.gray300,
                                      ),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) =>
                                      _onOtpChanged(index, value),
                                ),
                            );
                          }),
                        ),

                        SizedBox(height: 32.h),

                        // Resend code section
                        if (state.isOtpLoading)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ColorManager.primary,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Sending code...',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.geist,
                                  color: ColorManager.textSecondary,
                                ),
                              ),
                            ],
                          )
                        else if (_secondsRemaining > 0)
                          Text(
                            'Resend code in ${_secondsRemaining}s',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontFamily.geist,
                              color: ColorManager.textSecondary,
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn\'t receive the code? ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.geist,
                                  color: ColorManager.textSecondary,
                                ),
                              ),
                              TextButton(
                                onPressed: _handleResendOtp,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Resend',
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

                        SizedBox(height: 32.h),

                        // Verify button
                        PrimaryButton(
                          text: 'Verify & Continue',
                          onPressed: state.isOtpVerifying ? null : _handleVerify,
                          isLoading: state.isOtpVerifying,
                        ),

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
      ),
    );
  }
}
