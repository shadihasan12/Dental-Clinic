import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  void _handleKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _otpControllers[index - 1].clear();
      _otpFocusNodes[index - 1].requestFocus();
      final otpCode = _otpControllers.map((c) => c.text).join();
      context.read<AuthBloc>().add(AuthEvent.otpCodeChanged(otpCode));
    }
  }

  Timer? _countdownTimer;
  final ValueNotifier<int> _secondsNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
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
    _secondsNotifier.dispose();
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
    _secondsNotifier.value = seconds;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value > 0) {
        _secondsNotifier.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        _otpFocusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }

    final otpCode = _otpControllers.map((c) => c.text).join();
    context.read<AuthBloc>().add(AuthEvent.otpCodeChanged(otpCode));

    final state = context.read<AuthBloc>().state;
    if (otpCode.length == 6 && !state.isOtpVerifying) {
      if (RegExp(r'^\d{6}$').hasMatch(otpCode)) {
        context.read<AuthBloc>().add(const AuthEvent.otpVerified());
      }
    }
  }

  void _handleResendOtp() {
    if (_secondsNotifier.value == 0) {
      for (var controller in _otpControllers) {
        controller.clear();
      }
      context.read<AuthBloc>().add(const AuthEvent.otpResendRequested());
    }
  }

  void _handleVerify() {
    final l10n = AppLocalizations.of(context)!;
    final otpCode = _otpControllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      context.read<AuthBloc>().add(const AuthEvent.otpVerified());
    } else {
      AppSnackbar.showError(
        context,
        title: l10n.invalidCode,
        message: l10n.pleaseEnterAllDigits,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          final bloc = context.read<AuthBloc>();
          if (bloc.state.emailVerificationForLogin) {
            bloc.add(const AuthEvent.emailVerificationCancelled());
          }
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpSecondsRemaining != current.otpSecondsRemaining,
            listener: (context, state) {
              if (state.otpSecondsRemaining > 0 && _secondsNotifier.value == 0) {
                _startCountdown(state.otpSecondsRemaining);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.sessionId != current.sessionId,
            listener: (context, state) {
              if (state.sessionId != null && state.sessionId!.isNotEmpty) {
                if (state.emailVerificationForLogin) {
                  // Login flow: mark authenticated and go to home
                  context.read<AuthBloc>().add(const AuthEvent.emailVerificationCompleted());
                } else {
                  // Signup flow: proceed to registration
                  AppSnackbar.showSuccess(
                    context,
                    title: l10n.emailVerified,
                    message: l10n.completeYourRegistration,
                  );
                  context.pushNamed(
                    AppRoutesNames.choosePlan,
                    extra: context.read<AuthBloc>(),
                  );
                }
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpError != current.otpError,
            listener: (context, state) {
              if (state.otpError != null && state.otpError!.isNotEmpty) {
                AppSnackbar.showError(
                  context,
                  title: l10n.verificationFailed,
                  message: state.otpError,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            return previous.isOtpLoading != current.isOtpLoading ||
                previous.isOtpVerifying != current.isOtpVerifying ||
                previous.signupEmail != current.signupEmail;
          },
          builder: (context, state) {
            return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // Back button
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

                  // Title
                  Text(
                    l10n.verifyYourEmail,
                    style: TextStyle(
                      fontSize: FontSizesManager.s24,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: fontFamily,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.enterCodeSentToEmail,
                    style: TextStyle(
                      fontSize: FontSizesManager.s14,
                      fontFamily: fontFamily,
                      color: ColorManager.textSecondary,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Email icon
                  Center(
                    child: Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary10,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mark_email_read_outlined,
                        size: 36.w,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Email address
                  Center(
                    child: Text(
                      state.signupEmail,
                      style: TextStyle(
                        fontSize: FontSizesManager.s16,
                        fontWeight: FontWeightManager.semiBold,
                        fontFamily: fontFamily,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Center(
                    child: Text(
                      l10n.sentVerificationCode,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // OTP Input Fields
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 48.w,
                        height: 56.h,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          onKeyEvent: (event) => _handleKeyEvent(index, event),
                          child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          enabled: !state.isOtpVerifying,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: FontSizesManager.s24,
                            fontWeight: FontWeightManager.bold,
                            fontFamily: fontFamily,
                            color: ColorManager.textPrimary,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
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
                            LengthLimitingTextInputFormatter(1),
                          ],
                          onChanged: (value) =>
                              _onOtpChanged(index, value),
                        ),
                        ),
                      );
                    }),
                  ),
                  ),

                  SizedBox(height: 28.h),

                  // Resend code section
                  if (state.isOtpLoading)
                    Center(
                      child: Row(
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
                            l10n.sendingCode,
                            style: TextStyle(
                              fontSize: FontSizesManager.s14,
                              fontFamily: fontFamily,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ValueListenableBuilder<int>(
                      valueListenable: _secondsNotifier,
                      builder: (context, secondsRemaining, _) {
                        if (secondsRemaining > 0) {
                          return Center(
                            child: Text(
                              l10n.resendCodeIn(secondsRemaining),
                              style: TextStyle(
                                fontSize: FontSizesManager.s14,
                                fontFamily: fontFamily,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          );
                        }
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.didntReceiveCode,
                                style: TextStyle(
                                  fontSize: FontSizesManager.s12,
                                  fontFamily: fontFamily,
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
                                  l10n.resend,
                                  style: TextStyle(
                                    fontSize: FontSizesManager.s12,
                                    fontFamily: fontFamily,
                                    color: ColorManager.primary,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  SizedBox(height: 32.h),

                  PrimaryButton(
                    text: l10n.verifyAndContinue,
                    onPressed: state.isOtpVerifying ? null : _handleVerify,
                    isLoading: state.isOtpVerifying,
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
        ),
      ),
      ),
    );
  }
}
