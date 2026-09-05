import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';

/// Wire model for one report from the tickets API.
class IssueModel {
  final String id;
  final String category;
  final String status;
  final String title;
  final String description;
  final List<IssueAttachmentModel> attachments;
  final String? createdAt;
  final String? updatedAt;

  const IssueModel({
    required this.id,
    required this.category,
    required this.status,
    required this.title,
    required this.description,
    this.attachments = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      id: json['id']?.toString() ?? '',
      category: json['category'] as String? ?? '',
      status: json['status'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      attachments: (json['attachments'] as List?)
              ?.whereType<Map>()
              .map(
                (a) => IssueAttachmentModel.fromJson(
                  Map<String, dynamic>.from(a),
                ),
              )
              .toList() ??
          const [],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  IssueEntity toEntity() {
    return IssueEntity(
      id: id,
      category: category,
      status: status,
      title: title,
      description: description,
      attachments: attachments.map((a) => a.toEntity()).toList(),
      createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
      updatedAt: updatedAt == null ? null : DateTime.tryParse(updatedAt!),
    );
  }
}

/// One screenshot on a report. Both links are HMAC-signed and expire an hour
/// after the server minted them, so they are never persisted — the list is
/// re-fetched to get fresh ones.
class IssueAttachmentModel {
  final String mediaItemId;
  final String viewUrl;
  final String downloadUrl;

  const IssueAttachmentModel({
    required this.mediaItemId,
    required this.viewUrl,
    required this.downloadUrl,
  });

  factory IssueAttachmentModel.fromJson(Map<String, dynamic> json) {
    return IssueAttachmentModel(
      mediaItemId: json['media_item_id'] as String? ?? '',
      viewUrl: json['view'] as String? ?? '',
      downloadUrl: json['download'] as String? ?? '',
    );
  }

  IssueAttachmentEntity toEntity() => IssueAttachmentEntity(
    mediaItemId: mediaItemId,
    viewUrl: viewUrl,
    downloadUrl: downloadUrl,
  );
}

/// A `{value, label}` pair from the categories or statuses endpoint. The
/// value is the wire constant and is never translated; the label already is.
class IssueOptionModel {
  final String value;
  final String label;

  const IssueOptionModel({required this.value, required this.label});

  factory IssueOptionModel.fromJson(Map<String, dynamic> json) {
    return IssueOptionModel(
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  IssueOptionEntity toEntity() => IssueOptionEntity(value: value, label: label);
}

/// `meta.pagination` from the list endpoint.
class IssuePaginationModel {
  final int page;
  final int size;
  final int count;
  final int total;
  final int lastPage;

  const IssuePaginationModel({
    required this.page,
    required this.size,
    required this.count,
    required this.total,
    required this.lastPage,
  });

  factory IssuePaginationModel.fromJson(Map<String, dynamic> json) {
    int asInt(Object? value, int fallback) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? fallback;
    }

    return IssuePaginationModel(
      page: asInt(json['page'], 1),
      size: asInt(json['size'], 15),
      count: asInt(json['count'], 0),
      total: asInt(json['total'], 0),
      lastPage: asInt(json['last_page'], 1),
    );
  }
}

/// One page of reports plus where it sits in the whole list.
class IssuePageModel {
  final List<IssueModel> items;
  final IssuePaginationModel pagination;

  const IssuePageModel({required this.items, required this.pagination});

  IssuePageEntity toEntity() => IssuePageEntity(
    items: items.map((i) => i.toEntity()).toList(),
    page: pagination.page,
    lastPage: pagination.lastPage,
    total: pagination.total,
  );
}
