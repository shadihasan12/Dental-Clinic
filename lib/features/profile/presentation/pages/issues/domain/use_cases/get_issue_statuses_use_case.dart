import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:injectable/injectable.dart';

/// Status labels. Display only — no endpoint changes a report's status, and
/// the user never sets one.
@injectable
class GetIssueStatusesUseCase
    implements UseCase<List<IssueOptionEntity>, NoParams> {
  final IssueRepository _repository;

  GetIssueStatusesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>> call(
    NoParams params,
  ) {
    return _repository.getStatuses();
  }
}
