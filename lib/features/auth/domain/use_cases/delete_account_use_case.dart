import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/delete_account_result.dart';
import '../repositories/auth_repository.dart';

/// Schedules the signed-in account for deletion.
///
/// Deliberately does *not* wipe the session itself. The caller decides what
/// to do with a success, and it has to - the confirmation screen wants to
/// tell the user how long they have to change their mind before it signs
/// them out, and a use case that had already cleared the token would leave
/// nothing to say it on.
@injectable
class DeleteAccountUseCase implements UseCase<DeleteAccountResult, NoParams> {
  DeleteAccountUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<NetworkExceptions, DeleteAccountResult>> call(
    NoParams params,
  ) => _repository.deleteAccount();
}
