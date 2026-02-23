part of 'support_conversations_bloc.dart';

@freezed
class SupportConversationsState with _$SupportConversationsState {
  const factory SupportConversationsState.initial() = _Initial;
  const factory SupportConversationsState.loading() = _Loading;
  const factory SupportConversationsState.loaded(
    List<SupportConversationEntity> conversations,
  ) = _Loaded;
  const factory SupportConversationsState.created(
    SupportConversationEntity newConversation,
    List<SupportConversationEntity> conversations,
  ) = _Created;
  const factory SupportConversationsState.error(String message) = _Error;
}
