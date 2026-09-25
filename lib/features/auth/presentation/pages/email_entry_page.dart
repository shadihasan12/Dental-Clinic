import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_desktop_shell.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.showError(
        context,
        title: l10n.emailRequiredTitle,
        message: l10n.pleaseEnterEmailAddress,
      );
      return;
    }

    context.read<AuthBloc>().add(AuthEvent.signupEmailChanged(email));
    context.read<AuthBloc>().add(const AuthEvent.otpRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // primaryDarker is the on-white text tone; on a dark surface the base
    // primary is the one that reads.
    final accent = isDark ? ColorManager.primary : ColorManager.primaryDarker;

    return AuthDesktopShell(imageIndex: 1, child: Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.otpSecondsRemaining != current.otpSecondsRemaining,
            listener: (context, state) {
              if (state.otpSecondsRemaining > 0 && !state.isOtpLoading) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.otpSent,
                  message: l10n.verificationCodeSentTo(state.signupEmail),
                );

                context.pushNamed(
                  AppRoutesNames.emailVerification,
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
                  title: l10n.error,
                  message: state.otpError,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            return previous.isOtpLoading != current.isOtpLoading ||
                previous.signupEmail != current.signupEmail ||
                previous.isSignupEmailValid != current.isSignupEmailValid;
          },
          builder: (context, state) {
          if (_emailController.text != state.signupEmail) {
            _emailController.text = state.signupEmail;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),

                  // Back button
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: ColorManager.of(context).cardBgSecondary,
                        borderRadius: BorderRadius.circular(11.r),
                        border: Border.all(
                          color: ColorManager.of(context).borderLight,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorManager.of(context).textPrimary,
                        size: 16.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Title
                  Text(
                    l10n.createAccount,
                    style: TextStyle(
                      fontSize: FontSizesManager.s28,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: fontFamily,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.enterEmailToGetStarted,
                    style: TextStyle(
                      fontSize: FontSizesManager.s14,
                      fontFamily: fontFamily,
                      color: ColorManager.of(context).textSecondary,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Email icon. A rounded tile rather than a disc - the
                  // design language reserves circles for avatars.
                  Center(
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.email_outlined,
                        size: 28.w,
                        color: accent,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Info text
                  Center(
                    child: Text(
                      l10n.verificationCodeInfo,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                        height: FontHeightsManager.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Email field. Same shell as every other field in the
                  // app - label above, hairline at rest, primary on focus.
                  AuthTextField(
                    label: l10n.emailAddress,
                    hint: l10n.emailHint,
                    required: true,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    prefixIcon: Icons.email_outlined,
                    enabled: !state.isOtpLoading,
                    onChanged: (value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthEvent.signupEmailChanged(value));
                    },
                  ),

                  // Only complain once there is something to complain about;
                  // an untouched field is not an error.
                  if (state.signupEmail.isNotEmpty &&
                      !state.isSignupEmailValid)
                    FormErrorLine(message: l10n.pleaseEnterValidEmail),

                  SizedBox(height: 28.h),

                  // Send button
                  PrimaryButton(
                    text: l10n.sendVerificationCode,
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
                        l10n.alreadyHaveAccount,
                        style: TextStyle(
                          fontSize: FontSizesManager.s14,
                          fontFamily: fontFamily,
                          color: ColorManager.of(context).textSecondary,
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
                          l10n.logIn,
                          style: TextStyle(
                            fontSize: FontSizesManager.s14,
                            fontFamily: fontFamily,
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
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
