import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/home_summary.dart';
import '../../domain/repositories/home_summary_repository.dart';
import '../data_sources/home_summary_remote_data_source.dart';

@Injectable(as: HomeSummaryRepository)
class HomeSummaryRepositoryImpl implements HomeSummaryRepository {
  HomeSummaryRepositoryImpl(this._remoteDataSource);

  final HomeSummaryRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, HomeSummary>> getHomeSummary({
    required String startDate,
    required String endDate,
  }) async {
    try {
      return Right(
        await _remoteDataSource.getHomeSummary(
          startDate: startDate,
          endDate: endDate,
        ),
      );
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
