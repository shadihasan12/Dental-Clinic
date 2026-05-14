import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/action_button.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InvitationCardMode { received, sent }

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
      return invitation.inviteeEmail.isNotEmpty
          ? invitation.inviteeEmail
          : '—';
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
    final statusColor = _statusColor(invitation.status);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _primaryLabel(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_secondaryLabel() != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        _secondaryLabel()!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: c.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final r in _displayRoles()) _RolePill(role: r),
                        if (invitation.inviteeSpecialty != null &&
                            invitation.inviteeSpecialty!.isNotEmpty)
                          _SpecialtyChip(
                              label: invitation.inviteeSpecialty!),
                        if (mode == InvitationCardMode.received &&
                            invitation.invitedByName != null &&
                            invitation.invitedByName!.isNotEmpty)
                          Text(
                            l10n.invitedBy(invitation.invitedByName!),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: FontHelper.fontFamily(context),
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

          if (invitation.message != null && invitation.message!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: c.cardBgSecondary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                invitation.message!,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontStyle: FontStyle.italic,
                  color: c.textSecondary,
                ),
              ),
            ),
          ],

          if (_isPendingReceived) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: l10n.decline,
                    onPressed: isUpdating ? null : onReject,
                    fillColor: c.cardBg,
                    filled: false,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ActionButton(
                    text: l10n.accept,
                    onPressed: isUpdating ? null : onAccept,
                    fillColor: ColorManager.primary,
                    textColor: ColorManager.white,
                    filled: true,
                  ),
                ),
              ],
            ),
          ],
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

class _RolePill extends StatelessWidget {
  final ClinicRole role;
  const _RolePill({required this.role});

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _label(context),
        style: TextStyle(
          fontSize: 11.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _color() {
    switch (role) {
      case ClinicRole.admin:
        return ColorManager.primary;
      case ClinicRole.dentist:
        return ColorManager.info;
      case ClinicRole.secretary:
      case ClinicRole.receptionist:
        return ColorManager.secondary;
    }
  }

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

class _StatusBadge extends StatelessWidget {
  final InvitationStatus status;
  final Color color;
  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _label(l10n),
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w700,
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
    // Sent: invitee's photo. Received: no good photo source from the API
    // yet, fall back to a status-coloured icon.
    final url = mode == InvitationCardMode.sent
        ? invitation.inviteeImageUrl
        : invitation.clinicLogoUrl;
    if (url != null && url.isNotEmpty) {
      return CircleAvatar(
        radius: 22.r,
        backgroundColor: fallbackColor.withValues(alpha: 0.12),
        backgroundImage: NetworkImage(url),
      );
    }

    if (mode == InvitationCardMode.sent) {
      final initials = _initials(invitation.inviteeName ??
          invitation.inviteeEmail);
      return Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: fallbackColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w700,
              color: fallbackColor,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: fallbackColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.business_outlined, size: 22.w, color: fallbackColor),
    );
  }

  String _initials(String source) {
    final parts =
        source.trim().split(RegExp(r'[\s@]+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    return (parts.first.characters.first + parts.elementAt(1).characters.first)
        .toUpperCase();
  }
}

class _SpecialtyChip extends StatelessWidget {
  final String label;
  const _SpecialtyChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: ColorManager.of(context).textSecondary,
        ),
      ),
    );
  }
}
