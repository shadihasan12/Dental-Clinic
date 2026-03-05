import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/localization/language_service.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';

@module
abstract class BlocInjection {
  @lazySingleton
  LanguageService languageService(SharedPreferences sharedPreferences) =>
      LanguageService(sharedPreferences);

  @lazySingleton
  LanguageBloc languageBloc(LanguageService languageService, ApiConsumer apiConsumer) =>
      LanguageBloc(languageService: languageService, apiConsumer: apiConsumer);
}