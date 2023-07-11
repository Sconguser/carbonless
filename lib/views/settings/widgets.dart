import 'package:carbonless/providers/controllers/app_settings/app_settings_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../providers/controllers/app_settings/app_settings.dart';
import '../../shared/constants.dart';

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AppSettings appSettings = ref.watch(appSettingsProvider);
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: _locale.languageCode == 'en'
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (_locale.languageCode != 'en') {
                  ref.read(appSettingsProvider.notifier).setEnglishLanguage();
                }
              },
              child: Text(
                _locale.languages.english,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: _locale.languageCode == 'pl'
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (_locale.languageCode != 'pl') {
                  ref.read(appSettingsProvider.notifier).setPolishLanguage();
                }
              },
              child: Text(
                _locale.languages.polish,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AppSettings appSettings = ref.watch(appSettingsProvider);
    ThemeMode _themeMode = appSettings.theme;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: _themeMode.name == 'light'
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (_themeMode.name != 'light') {
                  ref.read(appSettingsProvider.notifier).setLightTheme();
                }
              },
              child: Text(
                _locale.theme.light,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: _themeMode.name == 'dark'
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (_themeMode.name != 'dark') {
                  ref.read(appSettingsProvider.notifier).setDarkTheme();
                }
              },
              child: Text(
                _locale.theme.dark,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
