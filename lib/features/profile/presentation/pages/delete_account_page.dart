import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/account_deletion_preview.dart';
import 'package:dental_clinic_app/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:dental_clinic_app/features/auth/domain/use_cases/get_account_deletion_preview_use_case.dart';
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
/// records and their colleagues' access, not only their own profile. The user
/// is entitled to read that before they agree to it.
///
/// The numbers are not written here. They come from the server's preview,
/// every time the screen opens, because "3 appointments will be cancelled" is
/// a claim about a clinic other people are still working in and a stale one
/// would understate what is about to happen.
///
/// The password is the only gate. There is no recovery window and no
/// ownership transfer: on success the account and every clinic it owns are
/// gone, so the thing standing between a borrowed phone and that outcome has
/// to be something only the account holder knows. A typed word was not.
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  AccountDeletionPreview? _preview;
  bool _loadingPreview = true;

  /// Why the preview could not be read. Distinct from [_error]: one blocks the
  /// screen and offers a retry, the other sits above a form the user can fix.
  String? _previewError;

  String? _selectedReason;
  bool _submitting = false;
  bool _obscurePassword = true;

  /// The server's own sentence about a refused attempt - almost always the
  /// password being wrong. Shown in place rather than in a snackbar, because
  /// it asks the user to correct the field right below it.
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadPreview() async {
    setState(() {
      _loadingPreview = true;
      _previewError = null;
    });

    final result = await getIt<GetAccountDeletionPreviewUseCase>()(NoParams());
    if (!mounted) return;

    setState(() {
      _loadingPreview = false;
      result.fold(
        (failure) => _previewError = NetworkExceptions.localizedMessage(
          context,
          failure,
        ),
        (preview) {
          _preview = preview;
          // Nothing is preselected. The reason is a question, and a form that
          // answers it on the user's behalf collects noise.
          _selectedReason = null;
        },
      );
    });
  }

  AccountDeletionReason? get _reason {
    final reasons = _preview?.reasons ?? const <AccountDeletionReason>[];
    for (final r in reasons) {
      if (r.value == _selectedReason) return r;
    }
    return null;
  }

  bool get _canSubmit =>
      !_submitting &&
      _selectedReason != null &&
      _passwordController.text.isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() {
      _submitting = true;
      _error = null;
    });

    final result = await getIt<DeleteAccountUseCase>()(
      DeleteAccountParams(
        password: _passwordController.text,
        reason: _selectedReason!,
        reasonNote: _noteController.text,
      ),
    );
    if (!mounted) return;

    result.fold((failure) {
      // A 401 means the token is already dead - a double tap whose first
      // request succeeded, or another device that got there first. The
      // account is gone either way, so this is the success path, not an
      // error to argue with.
      final gone = failure.maybeWhen(
        unauthorizedRequest: (_) => true,
        orElse: () => false,
      );
      if (gone) {
        _onDeleted();
        return;
      }
      setState(() {
        _submitting = false;
        _error = NetworkExceptions.localizedMessage(context, failure);
      });
    }, (_) => _onDeleted());
  }

  /// The account is gone, and this token with it. The session is wiped
  /// locally - deliberately *not* through the logout endpoint, which would
  /// answer 401 for an account that no longer exists.
  ///
  /// The notice goes up first: [SessionManager] navigates on a post-frame
  /// callback and the snackbar renders in the root overlay, so it survives
  /// the trip back to the login page and is the last thing the user reads.
  void _onDeleted() {
    AppSnackbar.showSuccess(
      context,
      title: AppLocalizations.of(context)!.deleteAccountDone,
    );
    unawaited(getIt<SessionManager>().endSession());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.deleteAccount, onBack: () => context.pop()),
      body: _body(context, l10n, c),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l10n, AppColors c) {
    if (_loadingPreview) {
      return const Center(child: CircularProgressIndicator());
    }

    final padding = EdgeInsets.fromLTRB(
      14.w,
      14.h,
      14.w,
      24.h + MediaQuery.viewPaddingOf(context).bottom,
    );

    if (_previewError != null) {
      return SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NoteCard(
              icon: Icons.error_outline,
              tone: ColorManager.error,
              text: '${l10n.deleteAccountPreviewFailed}\n$_previewError',
            ),
            SizedBox(height: 14.h),
            OutlinedButton(onPressed: _loadPreview, child: Text(l10n.retry)),
          ],
        ),
      );
    }

    final preview = _preview;
    if (preview == null || !preview.canDelete) {
      return Padding(
        padding: padding,
        child: _NoteCard(
          icon: Icons.info_outline,
          tone: ColorManager.info,
          text: l10n.deleteAccountUnavailable,
        ),
      );
    }

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IntroCard(text: l10n.deleteAccountIntro),
          SizedBox(height: 12.h),

          _SectionCard(
            title: l10n.deleteAccountWhatGoes,
            children: [
              for (final line in _consequences(l10n, preview))
                _Bullet(text: line),
            ],
          ),
          SizedBox(height: 12.h),

          // Stated as its own note rather than a bullet: what survives a
          // deletion is the half users are least likely to expect, and a
          // clinician who assumed their records vanished with them would be
          // wrong about something that matters.
          _SectionCard(
            title: l10n.deleteAccountWhatStays,
            children: [_Bullet(text: l10n.deleteAccountItemRecordsKept)],
          ),

          // Only an owner needs telling, and they need telling *before* they
          // start filling the form - it is the one fact that might make them
          // stop.
          if (preview.closesClinics) ...[
            SizedBox(height: 12.h),
            _NoteCard(
              icon: Icons.info_outline,
              tone: ColorManager.info,
              text: l10n.deleteAccountNoTransfer,
            ),
          ],

          SizedBox(height: 18.h),
          _FieldLabel(text: l10n.deleteAccountReasonLabel),
          SizedBox(height: 8.h),
          _ReasonPicker(
            reasons: preview.reasons,
            selected: _selectedReason,
            enabled: !_submitting,
            onChanged: (value) => setState(() => _selectedReason = value),
          ),

          // Revealed by the reason rather than always present: it is a
          // follow-up question, and an empty box under every answer invites
          // the user to think it is required.
          if (_reason?.needsNote ?? false) ...[
            SizedBox(height: 14.h),
            _FieldLabel(text: l10n.deleteAccountNoteLabel),
            SizedBox(height: 8.h),
            TextField(
              controller: _noteController,
              enabled: !_submitting,
              maxLines: 3,
              maxLength: 1000,
              textInputAction: TextInputAction.newline,
              style: _inputStyle(context),
              decoration: _inputDecoration(
                context,
                hint: l10n.deleteAccountNoteHint,
              ),
            ),
          ],

          SizedBox(height: 14.h),
          _FieldLabel(text: l10n.deleteAccountPasswordLabel),
          SizedBox(height: 8.h),
          TextField(
            controller: _passwordController,
            enabled: !_submitting,
            obscureText: _obscurePassword,
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done,
            inputFormatters: [LengthLimitingTextInputFormatter(128)],
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _canSubmit ? _submit() : null,
            style: _inputStyle(context),
            decoration: _inputDecoration(
              context,
              hint: l10n.deleteAccountPasswordHint,
              suffix: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18.w,
                  color: c.textSubtle,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
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
            label: _ctaLabel(l10n, preview),
            isLoading: _submitting,
            onPressed: _canSubmit ? _submit : null,
          ),
        ],
      ),
    );
  }

  /// What this particular account loses, in the order it matters.
  ///
  /// Built from the preview rather than from a fixed list: a secretary in
  /// somebody else's clinic and the owner of a staffed centre are agreeing to
  /// very different things, and one set of bullets cannot be honest to both.
  List<String> _consequences(
    AppLocalizations l10n,
    AccountDeletionPreview preview,
  ) {
    final lines = <String>[];
    final owned = preview.primaryOwnedClinic;

    if (owned == null) {
      lines.add(l10n.deleteAccountMemberIntro);
    } else if (owned.isCenter && owned.otherMembers > 0) {
      lines.add(
        l10n.deleteAccountClosesCenter(owned.name, owned.otherMembers),
      );
    } else {
      lines.add(l10n.deleteAccountClosesClinic(owned.name));
    }

    lines.add(l10n.deleteAccountItemProfile);
    lines.add(
      l10n.deleteAccountImpact(
        preview.cancelledAppointments,
        preview.archivedCases,
      ),
    );

    if (preview.cancelledSentInvitations > 0) {
      lines.add(
        l10n.deleteAccountInvitationsWithdrawn(
          preview.cancelledSentInvitations,
        ),
      );
    }

    if (preview.clinicsToLeave.isNotEmpty) {
      lines.add(
        l10n.deleteAccountAlsoLeave(
          preview.clinicsToLeave.map((c) => c.name).join('، '),
        ),
      );
    }

    return lines;
  }

  /// The button says what it does. "Delete my account" is a lie on a screen
  /// that also closes a centre and removes four colleagues from it.
  String _ctaLabel(AppLocalizations l10n, AccountDeletionPreview preview) {
    final owned = preview.primaryOwnedClinic;
    if (owned == null) return l10n.deleteAccountCta;
    return owned.isCenter
        ? l10n.deleteAccountCtaCloseCentre
        : l10n.deleteAccountCtaCloseClinic;
  }

  TextStyle _inputStyle(BuildContext context) => TextStyle(
    fontFamily: FontHelper.fontFamily(context),
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.of(context).textPrimary,
  );

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    Widget? suffix,
  }) {
    final c = ColorManager.of(context);
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: color, width: width),
        );

    return InputDecoration(
      hintText: hint,
      counterText: '',
      hintStyle: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 13.sp,
        color: c.textSubtle,
      ),
      filled: true,
      fillColor: c.cardBg,
      suffixIcon: suffix,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      enabledBorder: border(c.border),
      disabledBorder: border(c.border),
      focusedBorder: border(ColorManager.destructive, 1.5),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontFamily: FontHelper.fontFamily(context),
      fontSize: 12.5.sp,
      fontWeight: FontWeight.w600,
      color: ColorManager.of(context).textPrimary,
    ),
  );
}

/// The reason picker.
///
/// Rows rather than a dropdown: there are seven, they are short, and a
/// dropdown would hide the one thing this screen asks the user to think about
/// behind another tap. The labels are the server's - they arrive already
/// translated, and a local copy would drift the first time one is reworded.
class _ReasonPicker extends StatelessWidget {
  const _ReasonPicker({
    required this.reasons,
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  final List<AccountDeletionReason> reasons;
  final String? selected;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Column(
      children: [
        for (final reason in reasons) ...[
          if (reason != reasons.first) SizedBox(height: 8.h),
          Material(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: enabled ? () => onChanged(reason.value) : null,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 11.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: reason.value == selected
                        ? ColorManager.destructive
                        : c.border,
                    width: reason.value == selected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      reason.value == selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 18.w,
                      color: reason.value == selected
                          ? ColorManager.destructive
                          : c.textSubtle,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        reason.label,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 12.5.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
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
