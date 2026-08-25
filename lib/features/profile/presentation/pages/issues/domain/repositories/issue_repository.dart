import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';

abstract class IssueRepository {
  /// The caller's own reports. Rendered in the order received.
  Future<Either<NetworkExceptions, List<IssueEntity>>> getIssues();

  /// Files a new report. Returns the created record so the list can show it
  /// without a second round trip.
  Future<Either<NetworkExceptions, IssueEntity>> createIssue({
    required String title,
    required String description,
  });
}
