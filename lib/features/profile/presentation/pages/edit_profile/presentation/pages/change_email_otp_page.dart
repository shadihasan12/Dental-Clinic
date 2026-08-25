import 'dart:async';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/utils/error_helper.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
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

  /// Carried through from the request screen because the backend has no
  /// dedicated resend route: a resend is another POST to
  /// `change-email/request-otp`, which validates `current_password` every
  /// time. Held in memory for the length of the flow only, never stored.
  final String currentPassword;

  const ChangeEmailOtpPage({
    super.key,
    required this.newEmail,
    this.sessionId,
    this.secondsRemaining = 60,
    this.currentPassword = '',
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
        body: {'email': widget.newEmail, 'otp': otpCode},
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

    // No password means this screen was reached without going through the
    // request form. The endpoint would reject the resend, so say what to do
    // rather than surfacing a raw validation error.
    if (widget.currentPassword.isEmpty) {
      AppSnackbar.showError(
        context,
        title: l10n.error,
        message: l10n.resendNeedsPassword,
      );
      return;
    }

    setState(() => _isResending = true);

    try {
      final response = await getIt<ApiConsumer>().post(
        AuthEndpoints.changeEmailRequestOtp,
        body: {
          'new_email': widget.newEmail,
          'current_password': widget.currentPassword,
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
    final c = ColorManager.of(context);

    return Scaffold(
      // Was hardcoded white, which left the page unreadable in the dark theme.
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(
        title: l10n.verifyNewEmail,
        onBack: () => context.pop(),
      ),
      bottomNavigationBar: FormActionBar(
        label: l10n.confirmChangeEmail,
        busy: _isVerifying,
        onPressed: _handleVerify,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Where the code went, stated before the boxes that take it.
            AppCard(
              child: Row(
                children: [
                  const IconTile(icon: Icons.mark_email_read_outlined),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.newEmail,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                            height: 1.3,
                            fontFamily: fontFamily,
                            color: c.textTertiary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.newEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: fontFamily,
                            color: c.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            FormSectionCard(
              title: l10n.verifyNewEmail,
              children: [
                Text(
                  l10n.changeEmailOtpDescription,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.5,
                    fontFamily: fontFamily,
                    color: c.textSecondary,
                  ),
                ),
                // Digits are ltr in every locale, so the boxes never mirror.
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      for (var index = 0; index < 6; index++) ...[
                        if (index > 0) SizedBox(width: 6.w),
                        Expanded(
                          child: _OtpBox(
                            controller: _otpControllers[index],
                            focusNode: _otpFocusNodes[index],
                            enabled: !_isVerifying,
                            onChanged: (value) => _onOtpChanged(index, value),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (_isResending)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 14.w,
                        height: 14.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            ColorManager.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        l10n.sendingCode,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontFamily: fontFamily,
                          color: c.textSecondary,
                        ),
                      ),
                    ],
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
                              fontSize: 11.5.sp,
                              fontFamily: fontFamily,
                              color: c.textTertiary,
                            ),
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.didntReceiveCode,
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontFamily: fontFamily,
                              color: c.textSecondary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _resendOtp,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Text(
                                l10n.resend,
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontFamily: fontFamily,
                                  color: ColorManager.primaryDarker,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// One digit of the code. Same input surface as every other field: hairline
/// at rest, 1.5px primary on focus.
class _OtpBox extends StatefulWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      decoration: formInputDecoration(
        context,
        focused: widget.focusNode.hasFocus,
        hasError: false,
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          fontFamily: FontHelper.fontFamily(context),
          color: c.textPrimary,
        ),
        decoration: bareInputDecoration().copyWith(
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: widget.onChanged,
      ),
    );
  }
}
