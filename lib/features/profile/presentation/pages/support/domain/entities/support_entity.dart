import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_entity.freezed.dart';

@freezed
class SupportConversationEntity with _$SupportConversationEntity {
  const factory SupportConversationEntity({
    required String id,
    required String subject,
    @Default([]) List<SupportMessageEntity> messages,
    @Default(true) bool isRead,
  }) = _SupportConversationEntity;
}

class SupportMessageEntity {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isFromUser;

  const SupportMessageEntity({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
  });
}
