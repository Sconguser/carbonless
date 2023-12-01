import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode theme;
  final String language;

  AppSettings({
    this.theme = ThemeMode.light,
    this.language = 'en',
  });

  AppSettings copyWith({
    ThemeMode? theme,
    String? language,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }
}
