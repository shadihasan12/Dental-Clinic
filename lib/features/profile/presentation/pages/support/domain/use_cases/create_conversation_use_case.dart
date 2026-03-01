import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/repositories/support_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateConversationUseCase
    extends UseCase<SupportConversationEntity, NoParams> {
  final SupportRepository _repository;

  CreateConversationUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>> call(
    NoParams params,
  ) {
    return _repository.createConversation();
  }
}
