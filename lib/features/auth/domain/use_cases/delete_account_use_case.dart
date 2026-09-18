import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// What the user agreed to on the confirmation screen.
class DeleteAccountParams {
  const DeleteAccountParams({
    required this.password,
    required this.reason,
    this.reasonNote,
  });

  /// The current login password. It is the only gate on the deletion, which
  /// is why it is asked for here rather than a typed word: the account is
  /// destroyed immediately and cannot be recovered, so the thing that stops a
  /// borrowed phone has to be something only the account holder knows.
  final String password;

  /// One of the enum values the preview offered. Never a label.
  final String reason;

  final String? reasonNote;
}

/// Deletes the signed-in account, for good.
///
/// Deliberately does *not* wipe the session itself. The caller decides what
/// to do with a success, and it has to - the screen wants to say what
/// happened before the app drops back to the login page.
@injectable
class DeleteAccountUseCase implements UseCase<Unit, DeleteAccountParams> {
  DeleteAccountUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<NetworkExceptions, Unit>> call(DeleteAccountParams params) =>
      _repository.deleteAccount(
        password: params.password,
        reason: params.reason,
        reasonNote: params.reasonNote,
      );
}
