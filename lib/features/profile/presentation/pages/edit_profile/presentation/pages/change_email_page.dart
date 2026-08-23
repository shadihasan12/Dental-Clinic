import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/utils/error_helper.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
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
          // The resend on the next screen re-posts to the same endpoint,
          // which validates the password again.
          'currentPassword': password,
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
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Scaffold(
      // Was hardcoded white, which left the page unreadable in the dark
      // theme while every control on it switched.
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.changeEmail, onBack: () => context.pop()),
      // The one primary action docks in the thumb arc rather than sitting at
      // the end of the scroll.
      bottomNavigationBar: FormActionBar(
        label: l10n.sendVerificationCode,
        busy: _isLoading,
        onPressed: _requestOtp,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // What is being changed, stated before the fields that change it.
            AppCard(
              child: Row(
                children: [
                  const IconTile(icon: Icons.alternate_email_rounded),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.currentEmail,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                            height: 1.3,
                            fontFamily: family,
                            color: c.textTertiary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.currentEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: family,
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
              title: l10n.changeEmail,
              children: [
                Text(
                  l10n.changeEmailDescription,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.5,
                    fontFamily: family,
                    color: c.textSecondary,
                  ),
                ),
                FormTextField(
                  label: l10n.newEmail,
                  required: true,
                  controller: _emailController,
                  hintText: 'email@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.ltr,
                ),
                FormTextField(
                  label: l10n.currentPassword,
                  required: true,
                  controller: _passwordController,
                  hintText: '........',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: _requestOtp,
                  suffix: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18.w,
                      color: c.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
