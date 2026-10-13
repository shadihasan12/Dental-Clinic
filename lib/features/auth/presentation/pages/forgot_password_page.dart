import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/utils/account_rules.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_desktop_shell.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key, this.signedInEmail});

  /// Set when a signed-in user changes their password from the app: the
  /// flow runs on this address, which cannot be edited - only the owner of
  /// the account it is signed in to can receive the code.
  final String? signedInEmail;

  @override
  Widget build(BuildContext context) {
    final email = signedInEmail;
    return BlocProvider(
      create: (context) {
        final bloc = getIt<AuthBloc>();
        if (email != null) {
          bloc.add(AuthEvent.signedInPasswordChangeStarted(email));
        }
        return bloc;
      },
      child: _ForgotPasswordContent(signedInEmail: email),
    );
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent({this.signedInEmail});

  final String? signedInEmail;

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  late final _emailController =
      TextEditingController(text: widget.signedInEmail ?? '');

  bool get _isSignedIn => widget.signedInEmail != null;

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

    return AuthDesktopShell(imageIndex: 0, child: Scaffold(
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
              previous.isForgotPasswordEmailValid != current.isForgotPasswordEmailValid ||
              // The message names the character at fault, so it follows
              // every keystroke, not only the valid/invalid flip.
              previous.forgotPasswordEmail != current.forgotPasswordEmail,
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
                      _isSignedIn ? l10n.changePassword : l10n.forgotPassword,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _isSignedIn
                          ? l10n.changePasswordSubtitle
                          : l10n.forgotPasswordSubtitle,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Lock icon
                    AuthHeroGlyph(icon: Icons.lock_reset_outlined),

                    SizedBox(height: 32.h),

                    // Email field
                    AuthTextField(
                      label: l10n.emailAddress,
                      hint: l10n.emailHint,
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textDirection: TextDirection.ltr,
                      // The account's own address: fixed when signed in.
                      enabled: !_isSignedIn && !state.isForgotPasswordLoading,
                      onChanged: (value) {
                        context
                            .read<AuthBloc>()
                            .add(AuthEvent.forgotPasswordEmailChanged(value));
                      },
                    ),

                    if (state.forgotPasswordEmail.isNotEmpty &&
                        !state.isForgotPasswordEmailValid)
                      FormErrorLine(
                        message: EmailAddress.problem(
                              l10n,
                              state.forgotPasswordEmail,
                            ) ??
                            l10n.pleaseEnterValidEmail,
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

                    // Back to login link - there is no login to go back to
                    // when the flow was opened from inside the app.
                    if (!_isSignedIn)
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
    ),);
  }
}
