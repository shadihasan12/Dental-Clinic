import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}
