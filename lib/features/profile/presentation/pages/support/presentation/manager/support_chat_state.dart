part of 'support_chat_bloc.dart';

@freezed
class SupportChatState with _$SupportChatState {
  const factory SupportChatState.initial() = _Initial;
  const factory SupportChatState.loaded(
    SupportConversationEntity conversation, {
    @Default(false) bool isReplying,
  }) = _Loaded;
  const factory SupportChatState.error(String message) = _Error;
}
