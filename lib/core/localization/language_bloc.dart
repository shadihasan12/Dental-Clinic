import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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

  LanguageBloc({required this.languageService})
      : super(const LanguageInitialState()) {
    on<LoadLanguageEvent>(_onLoadLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final languageCode = languageService.currentLanguage;
    final locale = Locale(languageCode);
    emit(LanguageLoadedState(locale));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await languageService.setLanguage(event.languageCode);
    final locale = Locale(event.languageCode);
    emit(LanguageChangedState(locale));
  }
}
