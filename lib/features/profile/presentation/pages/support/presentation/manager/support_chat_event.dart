part of 'support_chat_bloc.dart';

@freezed
class SupportChatEvent with _$SupportChatEvent {
  const factory SupportChatEvent.startConversation(
    SupportConversationEntity conversation,
  ) = _StartConversation;
  const factory SupportChatEvent.sendMessage(String text) = _SendMessage;
}
