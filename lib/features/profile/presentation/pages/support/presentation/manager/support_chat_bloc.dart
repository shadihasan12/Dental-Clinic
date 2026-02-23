import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/use_cases/send_message_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/use_cases/get_auto_reply_use_case.dart';
import 'package:injectable/injectable.dart';

part 'support_chat_bloc.freezed.dart';
part 'support_chat_event.dart';
part 'support_chat_state.dart';

@injectable
class SupportChatBloc extends Bloc<SupportChatEvent, SupportChatState> {
  final SendMessageUseCase _sendMessage;
  final GetAutoReplyUseCase _getAutoReply;

  SupportChatBloc({
    required SendMessageUseCase sendMessage,
    required GetAutoReplyUseCase getAutoReply,
  })  : _sendMessage = sendMessage,
        _getAutoReply = getAutoReply,
        super(const SupportChatState.initial()) {
    on<_StartConversation>(_onStart);
    on<_SendMessage>(_onSendMessage);
  }

  String? _conversationId;

  Future<void> _onStart(
    _StartConversation event,
    Emitter<SupportChatState> emit,
  ) async {
    _conversationId = event.conversation.id;
    emit(SupportChatState.loaded(event.conversation));
  }

  Future<void> _onSendMessage(
    _SendMessage event,
    Emitter<SupportChatState> emit,
  ) async {
    if (_conversationId == null) return;

    // Send the user message
    final sendResult = await _sendMessage(
      SendMessageParams(
        conversationId: _conversationId!,
        text: event.text,
      ),
    );

    final sentConvo = sendResult.fold(
      (error) {
        emit(SupportChatState.error(
          NetworkExceptions.getErrorMessage(error),
        ));
        return null;
      },
      (conversation) => conversation,
    );

    if (sentConvo == null) return;

    // Show conversation with user message + typing indicator
    emit(SupportChatState.loaded(sentConvo, isReplying: true));

    // Get auto-reply (has built-in 1.5s delay)
    final replyResult = await _getAutoReply(_conversationId!);

    replyResult.fold(
      (error) {
        // On error, just hide typing indicator — message was already sent
        emit(SupportChatState.loaded(sentConvo, isReplying: false));
      },
      (updatedConvo) {
        emit(SupportChatState.loaded(updatedConvo, isReplying: false));
      },
    );
  }
}
