import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';

import '../entities/statistics_entities.dart';
import '../entities/statistics_period.dart';
import '../repositories/statistics_repository.dart';

class GetStatisticsUseCase
    extends UseCase<StatisticsSnapshot, GetStatisticsParams> {
  GetStatisticsUseCase(this._repository);

  final StatisticsRepository _repository;

  @override
  Future<Either<NetworkExceptions, StatisticsSnapshot>> call(
    GetStatisticsParams params,
  ) {
    return _repository.getStatistics(
      clinicId: params.clinicId,
      period: params.period,
    );
  }
}

class GetStatisticsParams {
  const GetStatisticsParams({
    required this.clinicId,
    required this.period,
  });

  final String clinicId;
  final StatisticsPeriod period;
}
