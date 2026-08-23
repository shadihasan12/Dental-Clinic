import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetIssuesUseCase implements UseCase<List<IssueEntity>, NoParams> {
  final IssueRepository _repository;

  GetIssuesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<IssueEntity>>> call(NoParams params) {
    return _repository.getIssues();
  }
}
