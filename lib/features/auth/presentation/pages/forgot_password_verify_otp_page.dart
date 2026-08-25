import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_desktop_shell.dart';

class ForgotPasswordVerifyOtpPage extends StatefulWidget {
  const ForgotPasswordVerifyOtpPage({super.key});

  @override
  State<ForgotPasswordVerifyOtpPage> createState() =>
      _ForgotPasswordVerifyOtpPageState();
}

class _ForgotPasswordVerifyOtpPageState
    extends State<ForgotPasswordVerifyOtpPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

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
        context
            .read<AuthBloc>()
            .add(const AuthEvent.resetPasswordOtpVerified());
      }
    }
  }

  void _handleResendOtp() {
    if (_secondsNotifier.value == 0) {
      for (var controller in _otpControllers) {
        controller.clear();
      }
      context
          .read<AuthBloc>()
          .add(const AuthEvent.resetPasswordOtpResendRequested());
    }
  }

  void _handleVerify() {
    final l10n = AppLocalizations.of(context)!;
    final otpCode = _otpControllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      context
          .read<AuthBloc>()
          .add(const AuthEvent.resetPasswordOtpVerified());
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

    return AuthDesktopShell(imageIndex: 0, child: Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpSecondsRemaining != current.otpSecondsRemaining,
            listener: (context, state) {
              if (state.otpSecondsRemaining > 0 &&
                  _secondsNotifier.value == 0) {
                _startCountdown(state.otpSecondsRemaining);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.resetPasswordSessionId !=
                current.resetPasswordSessionId,
            listener: (context, state) {
              if (state.resetPasswordSessionId != null &&
                  state.resetPasswordSessionId!.isNotEmpty) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.emailVerified,
                  message: l10n.setNewPassword,
                );
                context.pushNamed(
                  AppRoutesNames.setNewPassword,
                  extra: context.read<AuthBloc>(),
                );
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
                previous.forgotPasswordEmail != current.forgotPasswordEmail;
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
                    AuthBackButton(onTap: () => context.pop()),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      l10n.verifyYourEmail,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.enterCodeSentToEmail,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Email icon
                    AuthHeroGlyph(icon: Icons.mark_email_read_outlined),

                    SizedBox(height: 20.h),

                    // Email address
                    Center(
                      child: Text(
                        state.forgotPasswordEmail,
                        style: TextStyle(
                          fontSize: FontSizesManager.s16,
                          fontWeight: FontWeightManager.semiBold,
                          fontFamily: fontFamily,
                          color: ColorManager.of(context).textPrimary,
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
                          color: ColorManager.of(context).textSecondary,
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
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _otpFocusNodes[index],
                              enabled: !state.isOtpVerifying,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: FontSizesManager.s28,
                                fontWeight: FontWeightManager.bold,
                                fontFamily: fontFamily,
                                color: ColorManager.of(context).textPrimary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 14.h),
                                filled: true,
                                fillColor: ColorManager.of(context).inputBg,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: ColorManager.of(context).borderLight,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: ColorManager.of(context).borderLight,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: ColorManager.primary,
                                    width: 1.5,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: ColorManager.of(context).borderLight,
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
                                color: ColorManager.of(context).textSecondary,
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
                                  color: ColorManager.of(context).textSecondary,
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
                                    color: ColorManager.of(context).textSecondary,
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
    ),);
  }
}
