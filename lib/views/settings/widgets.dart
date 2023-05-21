import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../shared/constants.dart';

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  ref.read(languageProvider.notifier).state =
                      Locale.fromSubtags(languageCode: 'en');
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
                  ref.read(languageProvider.notifier).state =
                      Locale.fromSubtags(languageCode: 'pl');
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
    ThemeMode _themeMode = ref.watch(themeProvider);
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
                  ref.read(themeProvider.notifier).state = ThemeMode.light;
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
                  ref.read(themeProvider.notifier).state = ThemeMode.dark;
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
