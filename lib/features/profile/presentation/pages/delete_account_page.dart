import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/account_deletion_preview.dart';
import 'package:dental_clinic_app/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:dental_clinic_app/features/auth/domain/use_cases/get_account_deletion_preview_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'dart:async';

import 'package:flutter/material.dart';
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
    final preview = _preview;
    final showForm = !_loadingPreview &&
        _previewError == null &&
        preview != null &&
        preview.canDelete;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar:
          PageHeader(title: l10n.deleteAccount, onBack: () => context.pop()),
      // Rule 4: the commit docks in the thumb arc rather than sitting at the
      // end of a long scroll the user has to reach the bottom of twice.
      bottomNavigationBar: showForm
          ? FormActionBar(
              label: _ctaLabel(l10n, preview),
              tone: ColorManager.destructive,
              busy: _submitting,
              onPressed: _canSubmit ? _submit : null,
            )
          : null,
      body: _body(context, l10n),
    );
  }

  EdgeInsets get _pagePadding =>
      EdgeInsets.fromLTRB(dentaGutter, 14.h, dentaGutter, 28.h);

  Widget _body(BuildContext context, AppLocalizations l10n) {
    if (_loadingPreview) return const _DeleteAccountSkeleton();

    if (_previewError != null) {
      return SingleChildScrollView(
        padding: _pagePadding,
        child: StateCard(
          icon: Icons.cloud_off_rounded,
          tone: ColorManager.error,
          title: l10n.deleteAccountPreviewFailed,
          message: _previewError,
          actionLabel: l10n.retry,
          onAction: _loadPreview,
        ),
      );
    }

    final preview = _preview;
    if (preview == null || !preview.canDelete) {
      return SingleChildScrollView(
        padding: _pagePadding,
        child: StateCard(
          icon: Icons.info_outline_rounded,
          title: l10n.deleteAccountUnavailable,
        ),
      );
    }

    return SingleChildScrollView(
      // Dragging the form dismisses the keyboard, which is what puts the
      // docked Save back within reach. A number pad has no Done key to
      // close it with, so the scroll gesture the user already makes on
      // the way to the button has to be the thing that does it.
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: _pagePadding,
      // Rule 10 in the small: on a wide window the column is capped and
      // centred rather than stretched, so a line of consequence text does not
      // run the width of a monitor.
      child: _CenteredColumn(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rule 2: the numbers the user came for, before anything they
            // have to read. A count is the honest form of "are you sure".
            _ImpactTiles(preview: preview, l10n: l10n),
            SizedBox(height: 10.h),

            // Rule 3 in spirit: the consequence is never collapsed. It is a
            // persistent strip in its own hue, not a sentence in a paragraph.
            _AlertStrip(
              icon: Icons.delete_forever_outlined,
              tone: ColorManager.error,
              text: l10n.deleteAccountIntro,
            ),
            SizedBox(height: 16.h),

            SectionLabel(l10n.deleteAccountWhatGoes),
            SizedBox(height: 10.h),
            AppCard(
              tone: ColorManager.error,
              padding: EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in _consequences(l10n, preview))
                    _Bullet(text: line, tone: ColorManager.error),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Stated on its own rather than as one more red bullet: what
            // survives is the half users least expect, and a clinician who
            // assumed their records left with them would be wrong about
            // something that matters.
            SectionLabel(l10n.deleteAccountWhatStays),
            SizedBox(height: 10.h),
            AppCard(
              padding: EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 5.h),
              child: _Bullet(
                text: l10n.deleteAccountItemRecordsKept,
                tone: ColorManager.success,
              ),
            ),

            // Only an owner needs telling, and they need telling before they
            // start filling the form - it is the one fact that might make
            // them stop.
            if (preview.closesClinics) ...[
              SizedBox(height: 10.h),
              _AlertStrip(
                icon: Icons.info_outline_rounded,
                tone: ColorManager.info,
                text: l10n.deleteAccountNoTransfer,
              ),
            ],

            SizedBox(height: 18.h),
            SectionLabel(l10n.deleteAccountReasonLabel),
            SizedBox(height: 10.h),
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
              FormTextField(
                label: l10n.deleteAccountNoteLabel,
                controller: _noteController,
                hintText: l10n.deleteAccountNoteHint,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
              ),
            ],

            SizedBox(height: 14.h),
            FormTextField(
              label: l10n.deleteAccountPasswordLabel,
              controller: _passwordController,
              hintText: l10n.deleteAccountPasswordHint,
              obscureText: _obscurePassword,
              required: true,
              textInputAction: TextInputAction.done,
              onChanged: () => setState(() {}),
              onSubmitted: () => _canSubmit ? _submit() : null,
              suffix: _RevealToggle(
                obscured: _obscurePassword,
                onTap: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),

            if (_error != null) ...[
              SizedBox(height: 12.h),
              _AlertStrip(
                icon: Icons.error_outline_rounded,
                tone: ColorManager.error,
                text: _error!,
              ),
            ],
          ],
        ),
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
}

/// The two numbers this screen exists to state, as labelled tiles.
///
/// A third appears only for an owner whose clinic has staff - "members
/// removed" is not a fact every account has, and a zero tile would read as
/// reassurance.
class _ImpactTiles extends StatelessWidget {
  const _ImpactTiles({required this.preview, required this.l10n});

  final AccountDeletionPreview preview;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final owned = preview.primaryOwnedClinic;
    final members = owned?.otherMembers ?? 0;

    final tiles = <Widget>[
      ValueTile(
        label: l10n.deleteAccountAppointmentsLabel,
        value: '${preview.cancelledAppointments}',
        tone: preview.cancelledAppointments > 0 ? ColorManager.error : null,
      ),
      ValueTile(
        label: l10n.deleteAccountCasesLabel,
        value: '${preview.archivedCases}',
        tone: preview.archivedCases > 0 ? ColorManager.error : null,
      ),
      if (members > 0)
        ValueTile(
          label: l10n.deleteAccountMembersLabel,
          value: '$members',
          tone: ColorManager.error,
        ),
    ];

    // Labels may wrap to two lines, so the tiles are stretched to the
    // tallest one; IntrinsicHeight is what makes `stretch` legal in a Row.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < tiles.length; i++) ...[
            if (i > 0) SizedBox(width: 8.w),
            Expanded(child: tiles[i]),
          ],
        ],
      ),
    );
  }
}

/// A single fact in its own hue, held open rather than folded into prose.
class _AlertStrip extends StatelessWidget {
  const _AlertStrip({
    required this.icon,
    required this.tone,
    required this.text,
  });

  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
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
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 11.5.sp,
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

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.tone});

  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
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

/// Show/hide control for the password field, shaped for [FormTextField.suffix].
class _RevealToggle extends StatelessWidget {
  const _RevealToggle({required this.obscured, required this.onTap});

  final bool obscured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 18.w,
        color: ColorManager.of(context).textSubtle,
      ),
    );
  }
}

/// The reason picker.
///
/// Rows rather than a dropdown: there are seven, they are short, and a
/// dropdown would hide the one thing this screen asks the user to think about
/// behind another tap. The labels are the server's - they arrive already
/// translated, and a local copy would drift the first time one is reworded.
///
/// Selection is carried the way the style carries state everywhere else: a
/// 3px strip on the leading edge, in the destructive hue.
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
        for (var i = 0; i < reasons.length; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          Builder(
            builder: (context) {
              final reason = reasons[i];
              final isSelected = reason.value == selected;
              return AppCard(
                onTap: enabled ? () => onChanged(reason.value) : null,
                tone: isSelected ? ColorManager.destructive : null,
                statusTone: isSelected ? ColorManager.destructive : null,
                padding: EdgeInsetsDirectional.fromSTEB(13.w, 11.h, 12.w, 11.h),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 18.w,
                      color:
                          isSelected ? ColorManager.destructive : c.textSubtle,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        reason.label,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 12.5.sp,
                          height: 1.4,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

/// Holds the slots the loaded screen fills - tiles, strip, two sections, the
/// reason rows - so nothing jumps when the preview lands.
class _DeleteAccountSkeleton extends StatelessWidget {
  const _DeleteAccountSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(dentaGutter, 14.h, dentaGutter, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: ShimmerBox(height: 52.h)),
              SizedBox(width: 8.w),
              Expanded(child: ShimmerBox(height: 52.h)),
            ],
          ),
          SizedBox(height: 10.h),
          ShimmerBox(height: 58.h),
          SizedBox(height: 16.h),
          ShimmerBox(width: 120.w, height: 13.h),
          SizedBox(height: 10.h),
          ShimmerBox(height: 132.h),
          SizedBox(height: 16.h),
          ShimmerBox(width: 90.w, height: 13.h),
          SizedBox(height: 10.h),
          ShimmerBox(height: 74.h),
          SizedBox(height: 18.h),
          ShimmerBox(width: 140.w, height: 13.h),
          SizedBox(height: 10.h),
          for (var i = 0; i < 4; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            ShimmerBox(height: 44.h),
          ],
        ],
      ),
    );
  }
}

/// Caps and centres the content column once there is more width than a line
/// of text should use. A no-op on a phone.
class _CenteredColumn extends StatelessWidget {
  const _CenteredColumn({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: child,
      ),
    );
  }
}
