import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/use_cases/get_conversations_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/use_cases/create_conversation_use_case.dart';
import 'package:injectable/injectable.dart';

part 'support_conversations_bloc.freezed.dart';
part 'support_conversations_event.dart';
part 'support_conversations_state.dart';

@injectable
class SupportConversationsBloc
    extends Bloc<SupportConversationsEvent, SupportConversationsState> {
  final GetConversationsUseCase _getConversations;
  final CreateConversationUseCase _createConversation;

  SupportConversationsBloc({
    required GetConversationsUseCase getConversations,
    required CreateConversationUseCase createConversation,
  })  : _getConversations = getConversations,
        _createConversation = createConversation,
        super(const SupportConversationsState.initial()) {
    on<_LoadConversations>(_onLoad);
    on<_CreateConversation>(_onCreate);
  }

  Future<void> _onLoad(
    _LoadConversations event,
    Emitter<SupportConversationsState> emit,
  ) async {
    emit(const SupportConversationsState.loading());

    final result = await _getConversations(NoParams());

    result.fold(
      (error) => emit(
        SupportConversationsState.error(
          NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (conversations) =>
          emit(SupportConversationsState.loaded(conversations)),
    );
  }

  Future<void> _onCreate(
    _CreateConversation event,
    Emitter<SupportConversationsState> emit,
  ) async {
    final result = await _createConversation(NoParams());

    result.fold(
      (error) => emit(
        SupportConversationsState.error(
          NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (newConvo) {
        // Reload to get the full updated list
        final currentConversations = state.maybeWhen(
          loaded: (convos) => convos,
          created: (_, convos) => convos,
          orElse: () => <SupportConversationEntity>[],
        );
        emit(SupportConversationsState.created(
          newConvo,
          [newConvo, ...currentConversations],
        ));
      },
    );
  }
}
