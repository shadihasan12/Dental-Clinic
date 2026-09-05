import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/data/data_sources/issue_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IssueRepository)
class IssueRepositoryImpl implements IssueRepository {
  final IssueRemoteDataSource _remoteDataSource;

  IssueRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, IssuePageEntity>> getIssues({
    int page = 1,
    int size = 15,
  }) async {
    try {
      final result = await _remoteDataSource.getIssues(page: page, size: size);
      return Right(result.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, IssueEntity>> createIssue({
    required String category,
    required String title,
    required String description,
    List<String> mediaItemIds = const [],
  }) async {
    try {
      final model = await _remoteDataSource.createIssue(
        category: category,
        title: title,
        description: description,
        mediaItemIds: mediaItemIds,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>>
  getCategories() async {
    try {
      final models = await _remoteDataSource.getCategories();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>>
  getStatuses() async {
    try {
      final models = await _remoteDataSource.getStatuses();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
