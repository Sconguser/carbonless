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
