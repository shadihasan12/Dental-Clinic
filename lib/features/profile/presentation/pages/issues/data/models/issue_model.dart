import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';

/// Wire model for one entry of the issues endpoint.
class IssueModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String? createdAt;

  const IssueModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.createdAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      // Ids arrive as strings, but a numeric id would otherwise blow up the
      // cast, so normalise rather than assume.
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      createdAt: json['created_at'] as String?,
    );
  }

  IssueEntity toEntity() {
    return IssueEntity(
      id: id,
      title: title,
      description: description,
      status: IssueStatus.fromWire(status),
      createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
    );
  }
}
