import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/repositories/support_repository.dart';
import 'package:injectable/injectable.dart';

class SendMessageParams {
  final String conversationId;
  final String text;

  SendMessageParams({required this.conversationId, required this.text});
}

@injectable
class SendMessageUseCase
    extends UseCase<SupportConversationEntity, SendMessageParams> {
  final SupportRepository _repository;

  SendMessageUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>> call(
    SendMessageParams params,
  ) {
    return _repository.sendMessage(params.conversationId, params.text);
  }
}
