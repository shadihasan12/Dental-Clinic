import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class CreateIssueParams extends Equatable {
  const CreateIssueParams({
    required this.category,
    required this.title,
    required this.description,
    this.mediaItemIds = const [],
  });

  /// A `value` from the categories endpoint, never a label.
  final String category;
  final String title;
  final String description;

  /// Ids from `POST /media-items`, uploaded before this call.
  final List<String> mediaItemIds;

  @override
  List<Object?> get props => [category, title, description, mediaItemIds];
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
      category: params.category,
      title: params.title,
      description: params.description,
      mediaItemIds: params.mediaItemIds,
    );
  }
}
