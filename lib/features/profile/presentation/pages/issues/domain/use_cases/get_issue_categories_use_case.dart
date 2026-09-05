import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:injectable/injectable.dart';

/// The category list for the compose form. Fetched, never hardcoded — the
/// labels come back translated and the set can grow server-side.
@injectable
class GetIssueCategoriesUseCase
    implements UseCase<List<IssueOptionEntity>, NoParams> {
  final IssueRepository _repository;

  GetIssueCategoriesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>> call(
    NoParams params,
  ) {
    return _repository.getCategories();
  }
}
