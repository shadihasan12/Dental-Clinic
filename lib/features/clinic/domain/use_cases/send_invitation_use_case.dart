import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

class SendInvitationParams {
  final String email;
  final List<String> roles;

  const SendInvitationParams({required this.email, required this.roles});
}

@injectable
class SendInvitationUseCase
    implements UseCase<InvitationEntity, SendInvitationParams> {
  final ClinicRepository _repository;

  SendInvitationUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, InvitationEntity>> call(
    SendInvitationParams params,
  ) {
    return _repository.sendInvitation(
      email: params.email,
      roles: params.roles,
    );
  }
}
