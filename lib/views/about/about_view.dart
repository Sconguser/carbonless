import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../shared/constants.dart';

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.read(messagesProvider);

    return Padding(
      padding: standardOuterPadding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _locale.about.what,
              style: logoTextStyle,
            ),
            Center(
              child: ElevatedButton(
                child: Text(_locale.about.show_licenses),
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationIcon: const FlutterLogo(),
                    applicationName: 'Carbonless',
                    applicationVersion: 'September 2023',
                    applicationLegalese: '\u{a9} 2023 Carbonless Authors',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
