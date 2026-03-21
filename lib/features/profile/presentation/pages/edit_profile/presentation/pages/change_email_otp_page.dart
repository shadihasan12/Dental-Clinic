import 'dart:async';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/utils/error_helper.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailOtpPage extends StatefulWidget {
  final String newEmail;
  final String? sessionId;
  final int secondsRemaining;

  const ChangeEmailOtpPage({
    super.key,
    required this.newEmail,
    this.sessionId,
    this.secondsRemaining = 60,
  });

  @override
  State<ChangeEmailOtpPage> createState() => _ChangeEmailOtpPageState();
}

class _ChangeEmailOtpPageState extends State<ChangeEmailOtpPage> {
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
  bool _isVerifying = false;
  bool _isResending = false;
  String? _sessionId;

  @override
  void initState() {
    super.initState();
    _sessionId = widget.sessionId;
    if (widget.secondsRemaining > 0) {
      _startCountdown(widget.secondsRemaining);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _secondsNotifier.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var n in _otpFocusNodes) {
      n.dispose();
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
    if (otpCode.length == 6 && RegExp(r'^\d{6}$').hasMatch(otpCode)) {
      _verifyOtpAndChangeEmail(otpCode);
    }
  }

  Future<void> _verifyOtpAndChangeEmail(String otpCode) async {
    if (_isVerifying) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() => _isVerifying = true);

    try {
      // Step 1: Verify OTP to get session_id
      final verifyResponse = await getIt<ApiConsumer>().post(
        AuthEndpoints.verifyOtp,
        body: {
          'email': widget.newEmail,
          'otp': otpCode,
        },
      );

      final meta = verifyResponse['meta'] as Map<String, dynamic>?;
      final sessionId = meta?['session'] as String? ?? _sessionId;

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception(l10n.somethingWentWrong);
      }

      // Step 2: Confirm email change with session_id
      await getIt<ApiConsumer>().post(
        AuthEndpoints.changeEmail,
        body: {'session_id': sessionId},
      );

      if (!mounted) return;

      // Step 3: Logout and redirect to login
      await getIt<TokenStorage>().clearAuthData();
      await getIt<UserStorage>().clear();

      if (!mounted) return;

      AppSnackbar.showSuccess(
        context,
        title: l10n.success,
        message: l10n.emailChangedSuccess,
      );

      // Navigate to login, clearing the entire stack
      context.goNamed(AppRoutesNames.login);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isVerifying = false);

      final message = ErrorHelper.getErrorMessage(e);
      AppSnackbar.showError(context, title: l10n.error, message: message);
    }
  }

  Future<void> _resendOtp() async {
    if (_secondsNotifier.value > 0 || _isResending) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() => _isResending = true);

    try {
      final response = await getIt<ApiConsumer>().post(
        AuthEndpoints.changeEmailRequestOtp,
        body: {
          'new_email': widget.newEmail,
          'current_password': '', // Not needed for resend in most APIs
        },
      );

      if (!mounted) return;
      setState(() => _isResending = false);

      final meta = response['meta'] as Map<String, dynamic>?;
      final seconds = meta?['seconds_remaining'] as int? ?? 60;
      _sessionId = meta?['session'] as String? ?? _sessionId;
      _startCountdown(seconds);

      for (var c in _otpControllers) {
        c.clear();
      }

      AppSnackbar.showSuccess(
        context,
        title: l10n.success,
        message: l10n.sentVerificationCode,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isResending = false);

      final message = ErrorHelper.getErrorMessage(e);
      AppSnackbar.showError(context, title: l10n.error, message: message);
    }
  }

  void _handleVerify() {
    final l10n = AppLocalizations.of(context)!;
    final otpCode = _otpControllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      _verifyOtpAndChangeEmail(otpCode);
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

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: l10n.verifyNewEmail,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Icon
                    Center(
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          size: 36.w,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // New email
                    Center(
                      child: Text(
                        widget.newEmail,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Center(
                      child: Text(
                        l10n.changeEmailOtpDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: fontFamily,
                          color: ColorManager.of(context).textSecondary,
                        ),
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
                              enabled: !_isVerifying,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily,
                                color: ColorManager.of(context).textPrimary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 14.h),
                                filled: true,
                                fillColor: ColorManager.of(context).cardBgSecondary,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide:
                                      BorderSide(color: ColorManager.of(context).border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide:
                                      BorderSide(color: ColorManager.of(context).border),
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
                                  borderSide:
                                      BorderSide(color: ColorManager.of(context).border),
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

                    // Resend section
                    if (_isResending)
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
                                fontSize: 14.sp,
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
                                  fontSize: 14.sp,
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
                                    fontSize: 12.sp,
                                    fontFamily: fontFamily,
                                    color: ColorManager.of(context).textSecondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _resendOtp,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    l10n.resend,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: fontFamily,
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                    SizedBox(height: 32.h),

                    // Verify button
                    GestureDetector(
                      onTap: _isVerifying ? null : _handleVerify,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: _isVerifying
                              ? ColorManager.primary.withValues(alpha: 0.5)
                              : ColorManager.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: _isVerifying
                            ? Center(
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                l10n.confirmChangeEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.white,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
