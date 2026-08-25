import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';

class InvitationModel {
  final String id;
  final String clinicId;
  final String clinicName;
  final String? clinicLogoUrl;
  final String inviteeEmail;
  final String? inviteeName;
  final String? inviteeImageUrl;
  final String? inviteeSpecialty;
  final List<ClinicRole> roles;
  final ClinicRole role;
  final InvitationStatus status;
  final String invitedByUserId;
  final String? invitedByName;
  final String? message;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final DateTime? respondedAt;
  final List<AuditEntry> audits;

  const InvitationModel({
    required this.id,
    required this.clinicId,
    required this.clinicName,
    required this.inviteeEmail,
    required this.roles,
    required this.role,
    required this.status,
    required this.invitedByUserId,
    this.clinicLogoUrl,
    this.inviteeName,
    this.inviteeImageUrl,
    this.inviteeSpecialty,
    this.invitedByName,
    this.message,
    this.createdAt,
    this.expiresAt,
    this.respondedAt,
    this.audits = const [],
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    final clinic = json['clinic'] as Map<String, dynamic>? ?? const {};
    // `user` block appears on /sent (the invitee). For /received, fall back
    // to the older invited_by / inviter shapes.
    final user = json['user'] as Map<String, dynamic>?;
    final invitedBy = json['invited_by'] as Map<String, dynamic>? ??
        json['inviter'] as Map<String, dynamic>? ??
        const {};

    final rawRoles = json['roles'];
    final parsedRoles = rawRoles is List
        ? rawRoles.map((r) => _parseRole(r?.toString())).toList()
        : <ClinicRole>[];
    final firstRole = parsedRoles.isNotEmpty
        ? parsedRoles.first
        : _parseRole(json['role']?.toString());

    final specialty = user?['specialty'] is Map<String, dynamic>
        ? (user!['specialty'] as Map<String, dynamic>)['name'] as String?
        : null;

    return InvitationModel(
      id: (json['id'] ?? '').toString(),
      clinicId: (clinic['id'] ?? json['clinic_id'] ?? '').toString(),
      clinicName: (clinic['name'] ?? json['clinic_name'] ?? '').toString(),
      clinicLogoUrl: clinic['logo_url'] as String? ??
          clinic['logo'] as String?,
      inviteeEmail: (user?['email'] ??
              json['invited_email'] ??
              json['email'] ??
              json['invitee_email'] ??
              '')
          .toString(),
      inviteeName: _composeName(user),
      inviteeImageUrl: user?['image'] as String?,
      inviteeSpecialty: specialty,
      roles: parsedRoles,
      role: firstRole,
      status: _parseStatus(json['status']?.toString()),
      invitedByUserId: (invitedBy['id'] ?? json['invited_by_id'] ?? '')
          .toString(),
      invitedByName: _composeName(invitedBy),
      message: json['message'] as String?,
      createdAt: _parseDate(json['created_at']),
      expiresAt: _parseDate(json['expires_at']),
      respondedAt: _parseDate(json['responded_at']),
      audits: AuditEntry.listFromJson(json['audits']),
    );
  }

  InvitationEntity toEntity() => InvitationEntity(
        id: id,
        clinicId: clinicId,
        clinicName: clinicName,
        inviteeEmail: inviteeEmail,
        inviteeName: inviteeName,
        inviteeImageUrl: inviteeImageUrl,
        inviteeSpecialty: inviteeSpecialty,
        roles: roles,
        role: role,
        status: status,
        invitedByUserId: invitedByUserId,
        invitedByName: invitedByName,
        message: message,
        clinicLogoUrl: clinicLogoUrl,
        createdAt: createdAt,
        expiresAt: expiresAt,
        respondedAt: respondedAt,
        audits: audits,
      );

  static InvitationStatus _parseStatus(String? raw) {
    switch (raw?.toUpperCase()) {
      case 'ACCEPTED':
        return InvitationStatus.accepted;
      case 'DECLINED':
        return InvitationStatus.declined;
      case 'EXPIRED':
        return InvitationStatus.expired;
      case 'CANCELLED':
        return InvitationStatus.cancelled;
      case 'PENDING':
      default:
        return InvitationStatus.pending;
    }
  }

  static ClinicRole _parseRole(String? raw) {
    switch (raw?.toUpperCase()) {
      case 'ADMIN':
        return ClinicRole.admin;
      case 'DENTIST':
        return ClinicRole.dentist;
      case 'SECRETARY':
        return ClinicRole.secretary;
      default:
        return ClinicRole.receptionist;
    }
  }

  static String? _composeName(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) return null;
    final full = json['name'] as String?;
    if (full != null && full.isNotEmpty) return full;
    final first = json['first_name'] as String? ?? '';
    final last = json['last_name'] as String? ?? '';
    final composed = '$first $last'.trim();
    return composed.isEmpty ? null : composed;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  /// API value for a status enum, matching the backend filter param.
  static String apiValue(InvitationStatus status) {
    switch (status) {
      case InvitationStatus.pending:
        return 'PENDING';
      case InvitationStatus.accepted:
        return 'ACCEPTED';
      case InvitationStatus.declined:
        return 'DECLINED';
      case InvitationStatus.expired:
        return 'EXPIRED';
      case InvitationStatus.cancelled:
        return 'CANCELLED';
    }
  }
}
