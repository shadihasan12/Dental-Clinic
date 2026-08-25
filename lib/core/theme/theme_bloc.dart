import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_service.dart';

// ── Events ──────────────────────────────────────────────────────────────────

abstract class ThemeEvent {
  const ThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;
  const ChangeThemeEvent(this.themeMode);
}

// ── States ──────────────────────────────────────────────────────────────────

abstract class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ThemeInitialState extends ThemeState {
  // Matches ThemeService's fallback, so the frames rendered before
  // LoadThemeEvent resolves do not flash the wrong brightness.
  const ThemeInitialState() : super(ThemeMode.system);
}

class ThemeLoadedState extends ThemeState {
  const ThemeLoadedState(super.themeMode);
}

class ThemeChangedState extends ThemeState {
  const ThemeChangedState(super.themeMode);
}

// ── Bloc ────────────────────────────────────────────────────────────────────

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeService themeService;

  ThemeBloc({required this.themeService}) : super(const ThemeInitialState()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final mode = themeService.currentThemeMode;
    emit(ThemeLoadedState(mode));
  }

  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await themeService.setThemeMode(event.themeMode);
    emit(ThemeChangedState(event.themeMode));
  }
}
