import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../shared/constants.dart';
import 'widgets.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _locale.text.theme,
              style: logoTextStyle,
            ),
          ),
          ThemeSwitch(),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _locale.text.language,
              style: logoTextStyle,
            ),
          ),
          LanguageSwitch(),
        ],
      ),
    );
  }
}
