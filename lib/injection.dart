import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/injection.config.dart';
import 'package:dental_clinic_app/features/statistics/statistics_injection.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
  registerStatisticsModule();
}
