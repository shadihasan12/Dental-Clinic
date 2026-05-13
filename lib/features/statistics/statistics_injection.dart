import 'package:dental_clinic_app/injection.dart';

import 'data/data_sources/mock_statistics_data_source.dart';
import 'data/data_sources/statistics_remote_data_source.dart';
import 'data/repositories/statistics_repository_impl.dart';
import 'domain/repositories/statistics_repository.dart';
import 'domain/use_cases/get_statistics_use_case.dart';
import 'presentation/bloc/statistics_bloc.dart';

/// Manual registration of the statistics feature.
///
/// Skipping `@injectable` here keeps the feature self-contained so it
/// works without re-running build_runner. When the real backend lands,
/// swap [MockStatisticsDataSource] for the production data source — that
/// is the only line that needs to change.
void registerStatisticsModule() {
  if (getIt.isRegistered<StatisticsRepository>()) return;

  getIt.registerLazySingleton<StatisticsRemoteDataSource>(
    () => const MockStatisticsDataSource(),
  );
  getIt.registerLazySingleton<StatisticsRepository>(
    () => StatisticsRepositoryImpl(getIt<StatisticsRemoteDataSource>()),
  );
  getIt.registerFactory<GetStatisticsUseCase>(
    () => GetStatisticsUseCase(getIt<StatisticsRepository>()),
  );
  getIt.registerFactory<StatisticsBloc>(
    () => StatisticsBloc(getStatistics: getIt<GetStatisticsUseCase>()),
  );
}
