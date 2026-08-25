import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptInvitationUseCase
    implements UseCase<InvitationEntity, String> {
  final ClinicRepository _repository;

  AcceptInvitationUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, InvitationEntity>> call(String params) {
    return _repository.acceptInvitation(params);
  }
}

@injectable
class DeclineInvitationUseCase
    implements UseCase<InvitationEntity, String> {
  final ClinicRepository _repository;

  DeclineInvitationUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, InvitationEntity>> call(String params) {
    return _repository.declineInvitation(params);
  }
}
