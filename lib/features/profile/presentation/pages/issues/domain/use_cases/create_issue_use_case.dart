import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class CreateIssueParams extends Equatable {
  const CreateIssueParams({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}

@injectable
class CreateIssueUseCase implements UseCase<IssueEntity, CreateIssueParams> {
  final IssueRepository _repository;

  CreateIssueUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, IssueEntity>> call(
    CreateIssueParams params,
  ) {
    return _repository.createIssue(
      title: params.title,
      description: params.description,
    );
  }
}
