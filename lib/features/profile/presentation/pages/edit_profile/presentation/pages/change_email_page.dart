import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/utils/error_helper.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailPage extends StatefulWidget {
  final String currentEmail;

  const ChangeEmailPage({super.key, required this.currentEmail});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }

  Future<void> _requestOtp() async {
    final l10n = AppLocalizations.of(context)!;
    final newEmail = _emailController.text.trim();
    final password = _passwordController.text;

    if (newEmail.isEmpty) {
      AppSnackbar.showError(context,
          title: l10n.error, message: l10n.pleaseEnterNewEmail);
      return;
    }
    if (!_isValidEmail(newEmail)) {
      AppSnackbar.showError(context,
          title: l10n.error, message: l10n.pleaseEnterValidEmail);
      return;
    }
    if (password.isEmpty) {
      AppSnackbar.showError(context,
          title: l10n.error, message: l10n.pleaseEnterCurrentPassword);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await getIt<ApiConsumer>().post(
        AuthEndpoints.changeEmailRequestOtp,
        body: {
          'new_email': newEmail,
          'current_password': password,
        },
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      final meta = response['meta'] as Map<String, dynamic>?;
      final sessionId = meta?['session'] as String?;
      final secondsRemaining = meta?['seconds_remaining'] as int? ?? 60;

      if (!mounted) return;
      context.pushNamed(
        AppRoutesNames.changeEmailOtpPage,
        extra: {
          'newEmail': newEmail,
          'sessionId': sessionId,
          'secondsRemaining': secondsRemaining,
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);

      final message = ErrorHelper.getErrorMessage(e);
      AppSnackbar.showError(context, title: l10n.error, message: message);
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
              title: l10n.changeEmail,
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
                          Icons.email_outlined,
                          size: 36.w,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Current email
                    Center(
                      child: Text(
                        widget.currentEmail,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Center(
                      child: Text(
                        l10n.changeEmailDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: fontFamily,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // New email field
                    Text(
                      l10n.newEmail,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: fontFamily,
                        color: ColorManager.textPrimary,
                      ),
                      decoration: _inputDecoration(
                        hint: 'email@example.com',
                        icon: Icons.email_outlined,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Current password field
                    Text(
                      l10n.currentPassword,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _requestOtp(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: fontFamily,
                        color: ColorManager.textPrimary,
                      ),
                      decoration: _inputDecoration(
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.w,
                            color: ColorManager.textTertiary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Send button
                    GestureDetector(
                      onTap: _isLoading ? null : _requestOtp,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? ColorManager.primary.withValues(alpha: 0.5)
                              : ColorManager.primary,
                          borderRadius: BorderRadiusManager.lg,
                        ),
                        child: _isLoading
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
                                l10n.sendVerificationCode,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 15.sp,
        color: ColorManager.textTertiary,
      ),
      prefixIcon: Icon(icon, size: 20.w, color: ColorManager.textTertiary),
      suffixIcon: suffix,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      filled: true,
      fillColor: ColorManager.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }
}
