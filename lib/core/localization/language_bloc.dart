import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_topics_synchronizer.dart';
import 'language_service.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;

  const ChangeLanguageEvent(this.languageCode);
}

class LoadLanguageEvent extends LanguageEvent {
  const LoadLanguageEvent();
}

abstract class LanguageState {
  final Locale locale;

  const LanguageState(this.locale);
}

class LanguageInitialState extends LanguageState {
  const LanguageInitialState() : super(const Locale('en'));
}

class LanguageLoadedState extends LanguageState {
  const LanguageLoadedState(Locale locale) : super(locale);
}

class LanguageChangedState extends LanguageState {
  const LanguageChangedState(Locale locale) : super(locale);
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageService languageService;
  final ApiConsumer _apiConsumer;
  final NotificationTopicsSynchronizer _topicsSynchronizer;

  LanguageBloc({
    required this.languageService,
    required ApiConsumer apiConsumer,
    required NotificationTopicsSynchronizer topicsSynchronizer,
  })  : _apiConsumer = apiConsumer,
        _topicsSynchronizer = topicsSynchronizer,
        super(const LanguageInitialState()) {
    on<LoadLanguageEvent>(_onLoadLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    String languageCode;
    if (!languageService.hasLanguageSaved) {
      final deviceCode = languageService.deviceLanguageCode;
      languageCode = languageService.isSupported(deviceCode)
          ? deviceCode
          : 'en';
      await languageService.setLanguage(languageCode);
    } else {
      languageCode = languageService.currentLanguage;
    }
    emit(LanguageLoadedState(Locale(languageCode)));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await languageService.setLanguage(event.languageCode);
    final locale = Locale(event.languageCode);
    emit(LanguageChangedState(locale));

    // Tell the backend, then re-derive the topics from the new locale.
    //
    // Both halves matter. A push carries no request behind it, so the server
    // picks its language from the *stored* preference - skip the first call
    // and notifications keep arriving in the old language forever. And the
    // broadcast audience is per-language (`announcement_ar` vs
    // `announcement_en`), so skip the second and the subscription stays on the
    // old topic, which nothing will ever publish to again.
    try {
      await _apiConsumer.post(
        '/users/update-current-language',
        body: {'language': event.languageCode},
      );
    } catch (e) {
      debugPrint('[LanguageBloc] Failed to update language on server: $e');
    }

    // Re-fetches the settings, so the audiences come back in the new locale;
    // the synchronizer unsubscribes whichever name just dropped off the list.
    await _topicsSynchronizer.sync();
  }
}
