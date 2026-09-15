import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/delete_account_result.dart';
import 'package:dental_clinic_app/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// In-app account deletion.
///
/// A screen rather than a dialog on purpose. Both stores require the deletion
/// to be *initiated* from inside the app, and a dialog cannot carry the list
/// of what actually goes - which for a clinic owner includes their patients'
/// records, not only their own profile. The user is entitled to read that
/// before they agree to it.
///
/// The typed confirmation is the only gate. It is weak against someone
/// holding an unlocked phone, which is exactly why the backend keeps the
/// account recoverable for [AppConfig.accountDeletionGraceDays] days: signing
/// back in cancels the whole thing.
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _confirmController = TextEditingController();

  bool _submitting = false;

  /// Held as text because the only source that can explain a refusal is the
  /// backend's own sentence - "you are the last owner of Smile Clinic" is
  /// actionable in a way that a status code is not. Shown in place, not in a
  /// snackbar, because it asks the user to go and do something first.
  String? _error;

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  /// Case- and whitespace-insensitive: the user is agreeing to something, not
  /// passing a spelling test, and an Arabic keyboard has no shift key to
  /// match "DELETE" with anyway.
  bool _matches(String word) =>
      _confirmController.text.trim().toLowerCase() == word.trim().toLowerCase();

  Future<void> _submit() async {
    if (_submitting) return;
    setState(() {
      _submitting = true;
      _error = null;
    });

    final result = await getIt<DeleteAccountUseCase>()(NoParams());
    if (!mounted) return;

    result.fold((failure) {
      setState(() {
        _submitting = false;
        _error = NetworkExceptions.localizedMessage(context, failure);
      });
    }, _onScheduled);
  }

  /// The account is gone as far as this device is concerned, so the session
  /// is wiped on the same path a normal logout takes. The notice goes up
  /// first: [SessionManager] navigates on a post-frame callback, and the
  /// snackbar renders in the root overlay, so it survives the trip back to
  /// the login page and is the last thing the user reads.
  void _onScheduled(DeleteAccountResult scheduled) {
    final l10n = AppLocalizations.of(context)!;
    final purgeAt = scheduled.purgeAt;
    AppSnackbar.showSuccess(
      context,
      title: l10n.deleteAccountScheduled,
      message: purgeAt == null
          ? null
          : l10n.deleteAccountScheduledUntil(
              // Through AppDate like every other date the user reads, so the
              // month name is Arabic in Arabic. A raw DateFormat here was the
              // one place in the app that decided that for itself.
              AppDate.medium(context, purgeAt.toLocal()),
            ),
    );
    unawaited(getIt<SessionManager>().endSession());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final word = l10n.deleteAccountConfirmWord;
    final canSubmit = _matches(word) && !_submitting;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(
        title: l10n.deleteAccount,
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          14.w,
          14.h,
          14.w,
          24.h + MediaQuery.viewPaddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IntroCard(text: l10n.deleteAccountIntro),
            SizedBox(height: 12.h),

            _SectionCard(
              title: l10n.deleteAccountWhatGoes,
              children: [
                _Bullet(text: l10n.deleteAccountItemProfile),
                _Bullet(text: l10n.deleteAccountItemClinics),
                _Bullet(text: l10n.deleteAccountItemAccess),
              ],
            ),
            SizedBox(height: 12.h),

            // Stated before the field, not after a refusal: an owner who has
            // to transfer a clinic first should find that out before they
            // have typed the confirmation.
            _NoteCard(
              icon: Icons.info_outline,
              tone: ColorManager.info,
              text: l10n.deleteAccountOwnerNote,
            ),
            SizedBox(height: 12.h),
            _NoteCard(
              icon: Icons.history_toggle_off,
              tone: ColorManager.success,
              text: l10n.deleteAccountGrace(AppConfig.accountDeletionGraceDays),
            ),
            SizedBox(height: 18.h),

            Text(
              l10n.deleteAccountConfirmPrompt(word),
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _confirmController,
              enabled: !_submitting,
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [LengthLimitingTextInputFormatter(32)],
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: family,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: word,
                hintStyle: TextStyle(
                  fontFamily: family,
                  fontSize: 13.sp,
                  color: c.textSubtle,
                ),
                filled: true,
                fillColor: c.cardBg,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: c.border),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: c.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: ColorManager.destructive,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            if (_error != null) ...[
              SizedBox(height: 12.h),
              _NoteCard(
                icon: Icons.error_outline,
                tone: ColorManager.error,
                text: _error!,
              ),
            ],

            SizedBox(height: 18.h),
            _DestructiveButton(
              label: l10n.deleteAccountCta,
              isLoading: _submitting,
              onPressed: canSubmit ? _submit : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// The opening sentence, on the destructive tint so the screen reads as a
/// warning from the first line rather than as another settings page.
class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.errorBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.errorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorManager.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(
              Icons.delete_forever_outlined,
              size: 17.w,
              color: ColorManager.error,
            ),
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: family,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 9.h),
          ...children,
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: ColorManager.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
                height: 1.5,
                color: c.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A one-line explanation in its own hue: blue for a precondition, green for
/// the recovery window, red for a refusal the server sent back.
class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.icon, required this.tone, required this.text});

  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.w, color: tone),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: c.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The commit button. Disabled until the confirmation matches, and it looks
/// disabled - a red button the user cannot press yet would read as broken.
class _DestructiveButton extends StatelessWidget {
  const _DestructiveButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final enabled = onPressed != null;
    final radius = BorderRadius.circular(13.r);

    return Material(
      color: enabled ? ColorManager.destructive : c.cardBgSecondary,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: enabled ? null : Border.all(color: c.border),
          ),
          child: isLoading
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(ColorManager.white),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: enabled ? ColorManager.white : c.textSubtle,
                  ),
                ),
        ),
      ),
    );
  }
}
