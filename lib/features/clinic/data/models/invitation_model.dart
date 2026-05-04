import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';

class InvitationModel {
  final String id;
  final String clinicId;
  final String clinicName;
  final String? clinicLogoUrl;
  final String inviteeEmail;
  final ClinicRole role;
  final InvitationStatus status;
  final String invitedByUserId;
  final String? invitedByName;
  final String? message;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final DateTime? respondedAt;

  const InvitationModel({
    required this.id,
    required this.clinicId,
    required this.clinicName,
    required this.inviteeEmail,
    required this.role,
    required this.status,
    required this.invitedByUserId,
    this.clinicLogoUrl,
    this.invitedByName,
    this.message,
    this.createdAt,
    this.expiresAt,
    this.respondedAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    final clinic = json['clinic'] as Map<String, dynamic>? ?? const {};
    final invitedBy = json['invited_by'] as Map<String, dynamic>? ??
        json['inviter'] as Map<String, dynamic>? ??
        const {};

    final rawRoles = json['roles'];
    final firstRole = rawRoles is List && rawRoles.isNotEmpty
        ? rawRoles.first
        : json['role'];

    return InvitationModel(
      id: (json['id'] ?? '').toString(),
      clinicId: (clinic['id'] ?? json['clinic_id'] ?? '').toString(),
      clinicName: (clinic['name'] ?? json['clinic_name'] ?? '').toString(),
      clinicLogoUrl: clinic['logo_url'] as String? ??
          clinic['logo'] as String?,
      inviteeEmail: (json['invited_email'] ??
              json['email'] ??
              json['invitee_email'] ??
              '')
          .toString(),
      role: _parseRole(firstRole?.toString()),
      status: _parseStatus(json['status']?.toString()),
      invitedByUserId: (invitedBy['id'] ?? json['invited_by_id'] ?? '')
          .toString(),
      invitedByName: _composeName(invitedBy),
      message: json['message'] as String?,
      createdAt: _parseDate(json['created_at']),
      expiresAt: _parseDate(json['expires_at']),
      respondedAt: _parseDate(json['responded_at']),
    );
  }

  InvitationEntity toEntity() => InvitationEntity(
        id: id,
        clinicId: clinicId,
        clinicName: clinicName,
        inviteeEmail: inviteeEmail,
        role: role,
        status: status,
        invitedByUserId: invitedByUserId,
        invitedByName: invitedByName,
        message: message,
        clinicLogoUrl: clinicLogoUrl,
        createdAt: createdAt,
        expiresAt: expiresAt,
        respondedAt: respondedAt,
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

  static String? _composeName(Map<String, dynamic> json) {
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
