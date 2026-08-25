import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InvitationCardMode { received, sent }

/// One invitation. Same list-card shape as a clinic row: 16px card, hairline
/// border, and a 3px leading border carrying the status hue.
class InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  final InvitationCardMode mode;
  final bool isUpdating;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const InvitationCard({
    super.key,
    required this.invitation,
    this.mode = InvitationCardMode.received,
    this.isUpdating = false,
    this.onAccept,
    this.onReject,
  });

  bool get _isPendingReceived =>
      mode == InvitationCardMode.received &&
      invitation.status == InvitationStatus.pending;

  String _primaryLabel() {
    if (mode == InvitationCardMode.sent) {
      final name = invitation.inviteeName;
      if (name != null && name.isNotEmpty) return name;
      return invitation.inviteeEmail.isNotEmpty ? invitation.inviteeEmail : '—';
    }
    return invitation.clinicName.isNotEmpty ? invitation.clinicName : '—';
  }

  String? _secondaryLabel() {
    if (mode == InvitationCardMode.sent) {
      // Only show email as subtitle when we already used the name on top.
      final hasName =
          invitation.inviteeName != null && invitation.inviteeName!.isNotEmpty;
      return hasName ? invitation.inviteeEmail : null;
    }
    return null;
  }

  List<ClinicRole> _displayRoles() {
    if (invitation.roles.isNotEmpty) return invitation.roles;
    return [invitation.role];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final statusColor = _statusColor(invitation.status);
    final secondary = _secondaryLabel();
    final message = invitation.message;
    final invitedBy = invitation.invitedByName;
    final specialty = invitation.inviteeSpecialty;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        // Uniform border only: a BoxDecoration with differing sides and a
        // borderRadius throws while painting. The status accent is drawn as a
        // positioned stripe instead.
        border: Border.all(color: c.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Full-height status stripe on the leading edge; RTL moves it to the
          // trailing edge with the rest of the mirror.
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: 3.w,
            child: ColoredBox(color: statusColor),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(14.w, 12.h, 12.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Avatar(
                      invitation: invitation,
                      mode: mode,
                      fallbackColor: statusColor,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _primaryLabel(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              fontFamily: family,
                              fontWeight: FontWeight.w600,
                              color: c.textPrimary,
                            ),
                          ),
                          if (secondary != null && secondary.isNotEmpty) ...[
                            SizedBox(height: 3.h),
                            Text(
                              secondary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: family,
                                color: c.textTertiary,
                              ),
                            ),
                          ],
                          SizedBox(height: 7.h),
                          Wrap(
                            spacing: 5.w,
                            runSpacing: 4.h,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              for (final r in _displayRoles())
                                _RolePill(role: r),
                              if (specialty != null && specialty.isNotEmpty)
                                _NeutralPill(label: specialty),
                              if (mode == InvitationCardMode.received &&
                                  invitedBy != null &&
                                  invitedBy.isNotEmpty)
                                Text(
                                  l10n.invitedBy(invitedBy),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: family,
                                    color: c.textTertiary,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _StatusBadge(status: invitation.status, color: statusColor),
                  ],
                ),
                if (message != null && message.isNotEmpty) ...[
                  SizedBox(height: 9.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: c.cardBgSecondary,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        height: 1.5,
                        fontFamily: family,
                        color: c.textSecondary,
                      ),
                    ),
                  ),
                ],
                if (_isPendingReceived) ...[
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _CardButton(
                          label: l10n.decline,
                          onTap: isUpdating ? null : onReject,
                          filled: false,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: _CardButton(
                          label: l10n.accept,
                          onTap: isUpdating ? null : onAccept,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return ColorManager.warning;
      case InvitationStatus.accepted:
        return ColorManager.success;
      case InvitationStatus.declined:
        return ColorManager.error;
      case InvitationStatus.expired:
      case InvitationStatus.cancelled:
        return ColorManager.gray400;
    }
  }
}

/// Filled brand button for the action that moves the invitation forward;
/// white with a 1.5px brand border for the one that turns it down.
class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(12.r);
    final disabled = onTap == null;

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: filled ? ColorManager.primary : c.cardBg,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 11.h),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: filled
                  ? null
                  : Border.all(color: ColorManager.primary, width: 1.5),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: filled ? ColorManager.white : ColorManager.primaryDarker,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  final ClinicRole role;
  const _RolePill({required this.role});

  @override
  Widget build(BuildContext context) => _NeutralPill(label: _label(context));

  String _label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case ClinicRole.admin:
        return l10n.roleAdmin;
      case ClinicRole.dentist:
        return l10n.roleDentist;
      case ClinicRole.secretary:
        return l10n.roleSecretary;
      case ClinicRole.receptionist:
        return l10n.roleReceptionist;
    }
  }
}

/// Roles and specialties describe the invitation; they are not its status, so
/// they stay neutral and let the 3px border carry the only colour that means
/// something.
class _NeutralPill extends StatelessWidget {
  const _NeutralPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: c.textSecondary,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final InvitationStatus status;
  final Color color;
  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _label(l10n),
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _label(AppLocalizations l10n) {
    switch (status) {
      case InvitationStatus.pending:
        return l10n.pending;
      case InvitationStatus.accepted:
        return l10n.accepted;
      case InvitationStatus.declined:
        return l10n.declined;
      case InvitationStatus.expired:
        return l10n.expired;
      case InvitationStatus.cancelled:
        return l10n.cancelled;
    }
  }
}

class _Avatar extends StatelessWidget {
  final InvitationEntity invitation;
  final InvitationCardMode mode;
  final Color fallbackColor;

  const _Avatar({
    required this.invitation,
    required this.mode,
    required this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    // Sent: invitee's photo. Received: the clinic logo when the API has one,
    // otherwise a status-coloured icon.
    final url = mode == InvitationCardMode.sent
        ? invitation.inviteeImageUrl
        : invitation.clinicLogoUrl;
    if (url != null && url.isNotEmpty) {
      return CircleAvatar(
        radius: 19.r,
        backgroundColor: fallbackColor.withValues(alpha: 0.12),
        backgroundImage: NetworkImage(url),
      );
    }

    if (mode == InvitationCardMode.sent) {
      final initials = _initials(
        invitation.inviteeName ?? invitation.inviteeEmail,
      );
      return Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: fallbackColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: fallbackColor,
          ),
        ),
      );
    }

    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: fallbackColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.business_outlined, size: 19.w, color: fallbackColor),
    );
  }

  String _initials(String source) {
    final parts = source
        .trim()
        .split(RegExp(r'[\s@]+'))
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    return (parts.first.characters.first + parts.elementAt(1).characters.first)
        .toUpperCase();
  }
}
