import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/account_deletion_preview.dart';
import '../repositories/auth_repository.dart';

/// Reads what deleting this account would destroy.
///
/// Called every time the screen opens rather than cached: the counts are a
/// snapshot of a clinic other people are still working in, and a stale one
/// would understate what the user is about to agree to.
@injectable
class GetAccountDeletionPreviewUseCase
    implements UseCase<AccountDeletionPreview, NoParams> {
  GetAccountDeletionPreviewUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<NetworkExceptions, AccountDeletionPreview>> call(
    NoParams params,
  ) => _repository.getAccountDeletionPreview();
}
