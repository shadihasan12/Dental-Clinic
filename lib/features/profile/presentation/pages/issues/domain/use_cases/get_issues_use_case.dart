import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class GetIssuesParams extends Equatable {
  const GetIssuesParams({this.page = 1, this.size = 15});

  final int page;

  /// The server's own default is 15 and its ceiling is 100.
  final int size;

  @override
  List<Object?> get props => [page, size];
}

@injectable
class GetIssuesUseCase implements UseCase<IssuePageEntity, GetIssuesParams> {
  final IssueRepository _repository;

  GetIssuesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, IssuePageEntity>> call(
    GetIssuesParams params,
  ) {
    return _repository.getIssues(page: params.page, size: params.size);
  }
}
