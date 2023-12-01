import '/localization/messages.i18n.dart';
import '/main.dart';
import '/providers/controllers/highscores/highscores_entry_controller_provider.dart';
import '/shared/constants.dart';
import '/views/highscores/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/highscores_entry_model.dart';
import '../../providers/controllers/highscores/leaderboard_model.dart';

class HighscoresView extends ConsumerWidget {
  const HighscoresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    Leaderboard leaderboard = ref.watch(leaderboardNotifier);
    return Container(
      padding: standardOuterPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _locale.drawer.highscores,
            style: logoTextStyle,
          ),
          Text(_locale.highscores.your_position, style: logoTextStyle),
          HighscoreTile(
            entry: HighscoresEntry(
              id: 0,
              username: leaderboard.username,
              score: leaderboard.score,
            ),
          ),
          FilterChooser(),
          HighscoresList(
            entries: leaderboard.leader_board ?? [],
          ),
        ],
      ),
    );
  }
}
