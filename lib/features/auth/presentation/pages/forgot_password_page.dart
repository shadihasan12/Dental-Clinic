import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const _ForgotPasswordContent(),
    );
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent();

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    context.read<AuthBloc>().add(const AuthEvent.forgotPasswordSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.isForgotPasswordSuccess != current.isForgotPasswordSuccess,
            listener: (context, state) {
              if (state.isForgotPasswordSuccess) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.otpSent,
                  message: l10n.verificationCodeSentTo(state.forgotPasswordEmail),
                );
                context.pushNamed(
                  AppRoutesNames.forgotPasswordVerifyOtp,
                  extra: context.read<AuthBloc>(),
                );
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.forgotPasswordError != current.forgotPasswordError,
            listener: (context, state) {
              if (state.forgotPasswordError != null &&
                  state.forgotPasswordError!.isNotEmpty) {
                AppSnackbar.showError(
                  context,
                  title: l10n.error,
                  message: state.forgotPasswordError,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.isForgotPasswordLoading != current.isForgotPasswordLoading ||
              previous.isForgotPasswordEmailValid != current.isForgotPasswordEmailValid,
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

                    // Title
                    Text(
                      l10n.forgotPassword,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.forgotPasswordSubtitle,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Lock icon
                    Center(
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primary10,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_reset_outlined,
                          size: 36.w,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

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

                    // Email field
                    AuthTextField(
                      label: l10n.emailAddress,
                      hint: l10n.enterRegisteredEmail,
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textDirection: TextDirection.ltr,
                      enabled: !state.isForgotPasswordLoading,
                      onChanged: (value) {
                        context
                            .read<AuthBloc>()
                            .add(AuthEvent.forgotPasswordEmailChanged(value));
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Send OTP button
                    PrimaryButton(
                      text: l10n.sendVerificationCode,
                      isLoading: state.isForgotPasswordLoading,
                      onPressed: state.isForgotPasswordLoading ||
                              !state.isForgotPasswordEmailValid
                          ? null
                          : _handleSendOtp,
                    ),

                    SizedBox(height: 24.h),

                    // Back to login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.rememberPassword,
                          style: TextStyle(
                            fontSize: FontSizesManager.s14,
                            fontFamily: fontFamily,
                            color: ColorManager.of(context).textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
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
