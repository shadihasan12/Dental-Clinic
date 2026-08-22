import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/localization/language_service.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_topics_synchronizer.dart';
import 'package:dental_clinic_app/core/theme/theme_service.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';

@module
abstract class BlocInjection {
  @lazySingleton
  LanguageService languageService(SharedPreferences sharedPreferences) =>
      LanguageService(sharedPreferences);

  @lazySingleton
  LanguageBloc languageBloc(
    LanguageService languageService,
    ApiConsumer apiConsumer,
    NotificationTopicsSynchronizer topicsSynchronizer,
  ) =>
      LanguageBloc(
        languageService: languageService,
        apiConsumer: apiConsumer,
        topicsSynchronizer: topicsSynchronizer,
      );

  @lazySingleton
  ThemeService themeService(SharedPreferences sharedPreferences) =>
      ThemeService(sharedPreferences);

  @lazySingleton
  ThemeBloc themeBloc(ThemeService themeService) =>
      ThemeBloc(themeService: themeService);
}