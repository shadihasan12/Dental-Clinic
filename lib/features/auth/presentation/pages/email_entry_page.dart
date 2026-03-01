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

    return Scaffold(
      backgroundColor: ColorManager.white,
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
                    l10n.createAccount,
                    style: TextStyle(
                      fontSize: FontSizesManager.s28,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: fontFamily,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.enterEmailToGetStarted,
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
                        Icons.email_outlined,
                        size: 36.w,
                        color: ColorManager.primary,
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
                        color: ColorManager.textSecondary,
                        height: FontHeightsManager.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Email field
                  CustomTextField(
                    controller: _emailController,
                    hintText: l10n.emailAddress,
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

                  if (state.signupEmail.isNotEmpty &&
                      !state.isSignupEmailValid)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      child: Text(
                        l10n.pleaseEnterValidEmail,
                        style: TextStyle(
                          fontSize: FontSizesManager.s12,
                          fontFamily: fontFamily,
                          color: ColorManager.error,
                        ),
                      ),
                    ),

                  SizedBox(height: 32.h),

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
    );
  }
}
