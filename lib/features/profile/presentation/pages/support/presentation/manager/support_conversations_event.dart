part of 'support_conversations_bloc.dart';

@freezed
class SupportConversationsEvent with _$SupportConversationsEvent {
  const factory SupportConversationsEvent.loadConversations() =
      _LoadConversations;
  const factory SupportConversationsEvent.createConversation() =
      _CreateConversation;
}
