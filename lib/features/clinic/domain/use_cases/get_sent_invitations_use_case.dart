import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSentInvitationsUseCase
    implements UseCase<List<InvitationEntity>, InvitationStatus?> {
  final ClinicRepository _repository;

  GetSentInvitationsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<InvitationEntity>>> call(
    InvitationStatus? params,
  ) {
    return _repository.getSentInvitations(status: params);
  }
}
