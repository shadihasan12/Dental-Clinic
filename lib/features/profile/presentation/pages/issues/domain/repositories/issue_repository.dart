import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';

abstract class IssueRepository {
  /// One page of the caller's own reports, sorted by the server as
  /// `updated_at` descending — the report support last touched comes first.
  Future<Either<NetworkExceptions, IssuePageEntity>> getIssues({
    int page,
    int size,
  });

  /// Files a new report. Returns the created record so the list can show it
  /// without a second round trip.
  ///
  /// [mediaItemIds] are ids from `POST /media-items`, uploaded beforehand;
  /// the whole call is rejected if one of them is not an image or belongs to
  /// another clinic.
  Future<Either<NetworkExceptions, IssueEntity>> createIssue({
    required String category,
    required String title,
    required String description,
    List<String> mediaItemIds,
  });

  /// Categories for the compose form. Never hardcoded — the labels are
  /// translated server-side against `Accept-Language`.
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>> getCategories();

  /// Statuses, used only to label what the server reports.
  Future<Either<NetworkExceptions, List<IssueOptionEntity>>> getStatuses();
}
