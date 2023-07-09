import 'package:carbonless/localization/messages.i18n.dart';
import 'package:carbonless/main.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:carbonless/views/highscores/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/highscores_entry_model.dart';

class HighscoresView extends ConsumerWidget {
  const HighscoresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Container(
      padding: standardOuterPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _locale.drawer.highscores,
            style: logoTextStyle,
          ),
          Text('Twoja pozycja:', style: logoTextStyle),
          HighscoreTile(
            entry: HighscoresEntry(
              nickname: 'Milosz T.',
              points: 350,
              position: 25,
            ),
          ),
          FilterChooser(),
          HighscoresList(),
        ],
      ),
    );
  }
}
