import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_settings.dart';

class AppSettingsController extends StateNotifier<AppSettings> {
  AppSettingsController() : super(AppSettings());

  Future<void> readAll() async {
    // Simulating async read operation
    await Future.delayed(Duration(seconds: 2));

    // Read values from secure storage or any other source
    // final isDarkTheme = await secureStorage.read('isDarkTheme');
    // final language = await secureStorage.read('language');
    final theme = ThemeMode.light;
    final language = 'pl';
    // Update state notifiers
    state = state.copyWith(
      theme: theme ?? ThemeMode.light,
      language: language ?? 'en',
    );
  }

  void setPolishLanguage() {
    if (state.language == 'pl') {
      return;
    }
    state = state.copyWith(language: 'pl');
  }

  void setEnglishLanguage() {
    if (state.language == 'en') {
      return;
    }
    state = state.copyWith(language: 'en');
  }

  void setDarkTheme() {
    if (state.theme == ThemeMode.dark) {
      return;
    }
    state = state.copyWith(theme: ThemeMode.dark);
  }

  void setLightTheme() {
    if (state.theme == ThemeMode.light) {
      return;
    }
    state = state.copyWith(theme: ThemeMode.light);
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  return AppSettingsController();
});
