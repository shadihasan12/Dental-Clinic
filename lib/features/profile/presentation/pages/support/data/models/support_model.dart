import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';

class SupportMessageModel {
  final String id;
  final String text;
  final String timestamp;
  final bool isFromUser;

  SupportMessageModel({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
  });

  factory SupportMessageModel.fromJson(Map<String, dynamic> json) {
    return SupportMessageModel(
      id: json['id'] as String,
      text: json['text'] as String,
      timestamp: json['timestamp'] as String,
      isFromUser: json['is_from_user'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'timestamp': timestamp,
      'is_from_user': isFromUser,
    };
  }

  SupportMessageEntity toEntity() {
    return SupportMessageEntity(
      id: id,
      text: text,
      timestamp: DateTime.parse(timestamp),
      isFromUser: isFromUser,
    );
  }

  factory SupportMessageModel.fromEntity(SupportMessageEntity entity) {
    return SupportMessageModel(
      id: entity.id,
      text: entity.text,
      timestamp: entity.timestamp.toIso8601String(),
      isFromUser: entity.isFromUser,
    );
  }
}

class SupportConversationModel {
  final String id;
  final String subject;
  final List<SupportMessageModel> messages;
  final bool isRead;

  SupportConversationModel({
    required this.id,
    required this.subject,
    required this.messages,
    required this.isRead,
  });

  factory SupportConversationModel.fromJson(Map<String, dynamic> json) {
    return SupportConversationModel(
      id: json['id'] as String,
      subject: json['subject'] as String,
      messages: (json['messages'] as List)
          .map((m) => SupportMessageModel.fromJson(m as Map<String, dynamic>))
          .toList(),
      isRead: json['is_read'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'messages': messages.map((m) => m.toJson()).toList(),
      'is_read': isRead,
    };
  }

  SupportConversationEntity toEntity() {
    return SupportConversationEntity(
      id: id,
      subject: subject,
      messages: messages.map((m) => m.toEntity()).toList(),
      isRead: isRead,
    );
  }

  factory SupportConversationModel.fromEntity(
    SupportConversationEntity entity,
  ) {
    return SupportConversationModel(
      id: entity.id,
      subject: entity.subject,
      messages:
          entity.messages.map((m) => SupportMessageModel.fromEntity(m)).toList(),
      isRead: entity.isRead,
    );
  }
}
