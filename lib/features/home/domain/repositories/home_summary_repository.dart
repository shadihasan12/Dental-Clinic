import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../entities/home_summary.dart';

abstract class HomeSummaryRepository {
  /// The Home carousel's figures for the given inclusive date range.
  Future<Either<NetworkExceptions, HomeSummary>> getHomeSummary({
    required String startDate,
    required String endDate,
  });
}
