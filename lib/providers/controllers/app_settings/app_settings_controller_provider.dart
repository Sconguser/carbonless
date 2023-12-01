import '/providers/controllers/local_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_settings.dart';

class AppSettingsController extends StateNotifier<AppSettings> {
  final Ref ref;
  AppSettingsController({required this.ref}) : super(AppSettings()) {
    readAll();
  }

  Future<void> readAll() async {
    // Simulating async read operation
    await Future.delayed(Duration(seconds: 2));

    // Read values from secure storage or any other source
    // final isDarkTheme = await secureStorage.read('isDarkTheme');
    // final language = await secureStorage.read('language');
    String? theme = await ref.read(secureStorageProvider).read(KEYS.theme.name);
    String? language =
        await ref.read(secureStorageProvider).read(KEYS.language.name);
    // Update state notifiers
    state = state.copyWith(
      theme: getThemeModeFromString(theme),
      language: language ?? 'en',
    );
  }

  void setPolishLanguage() {
    if (state.language == 'pl') {
      return;
    }
    state = state.copyWith(language: 'pl');
    _saveLanguage('pl');
  }

  void setEnglishLanguage() {
    if (state.language == 'en') {
      return;
    }
    state = state.copyWith(language: 'en');
    _saveLanguage('en');
  }

  void _saveLanguage(String language) {
    ref.read(secureStorageProvider).write(KEYS.language.name, language);
  }

  void setDarkTheme() {
    if (state.theme == ThemeMode.dark) {
      return;
    }
    state = state.copyWith(theme: ThemeMode.dark);
    _saveTheme(ThemeMode.dark);
  }

  void setLightTheme() {
    if (state.theme == ThemeMode.light) {
      return;
    }
    state = state.copyWith(theme: ThemeMode.light);
    _saveTheme(ThemeMode.light);
  }

  void _saveTheme(ThemeMode theme) {
    ref
        .read(secureStorageProvider)
        .write(KEYS.theme.name, getStringFromThemeMode(theme));
  }

  ThemeMode getThemeModeFromString(String? theme) {
    if (theme == null) {
      return ThemeMode.light;
    } else if (theme == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  String getStringFromThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      return 'light';
    } else if (themeMode == ThemeMode.dark) {
      return 'dark';
    } else {
      return 'light';
    }
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  return AppSettingsController(ref: ref);
});
