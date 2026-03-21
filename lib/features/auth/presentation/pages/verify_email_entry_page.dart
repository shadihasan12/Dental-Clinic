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

class VerifyEmailEntryPage extends StatelessWidget {
  const VerifyEmailEntryPage({super.key});

  void _cancel(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEvent.emailVerificationCancelled());
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _cancel(context);
      },
      child: Scaffold(
        backgroundColor: ColorManager.of(context).scaffoldBg,
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              // Only navigate to OTP when seconds go from 0 → positive (fresh send)
              listenWhen: (previous, current) =>
                  previous.otpSecondsRemaining == 0 &&
                  current.otpSecondsRemaining > 0,
              listener: (context, state) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.otpSent,
                  message: l10n.verificationCodeSentTo(state.signupEmail),
                );
                // Replace this page so pressing back from OTP goes to Login
                context.pushReplacementNamed(
                  AppRoutesNames.emailVerification,
                  extra: context.read<AuthBloc>(),
                );
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
            buildWhen: (previous, current) =>
                previous.isOtpLoading != current.isOtpLoading ||
                previous.signupEmail != current.signupEmail,
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
                        onTap: () => _cancel(context),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: ColorManager.of(context).cardBgSecondary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorManager.of(context).textPrimary,
                            size: 18.w,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Text(
                        l10n.verifyYourAccount,
                        style: TextStyle(
                          fontSize: FontSizesManager.s28,
                          fontWeight: FontWeightManager.bold,
                          fontFamily: fontFamily,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.verifyAccountSubtitle,
                        style: TextStyle(
                          fontSize: FontSizesManager.s14,
                          fontFamily: fontFamily,
                          color: ColorManager.of(context).textSecondary,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      Center(
                        child: Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            color: ColorManager.primary10,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mark_email_unread_outlined,
                            size: 36.w,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Center(
                        child: Text(
                          state.signupEmail,
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

                      SizedBox(height: 40.h),

                      PrimaryButton(
                        text: l10n.sendVerificationCode,
                        onPressed: state.isOtpLoading
                            ? null
                            : () => context
                                .read<AuthBloc>()
                                .add(const AuthEvent.verifyEmailOtpRequested()),
                        isLoading: state.isOtpLoading,
                      ),

                      SizedBox(height: 24.h),
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
