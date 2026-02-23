import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/repositories/support_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAutoReplyUseCase extends UseCase<SupportConversationEntity, String> {
  final SupportRepository _repository;

  GetAutoReplyUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>> call(
    String params,
  ) {
    return _repository.getAutoReply(params);
  }
}
