import '/localization/messages.i18n.dart';
import '/main.dart';
import '/models/highscores_entry_model.dart';
import '/providers/controllers/highscores/highscores_filter_controller_provider.dart';
import '/providers/states/highscores/highscores_filter_state.dart';
import '/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HighscoreTile extends ConsumerWidget {
  final HighscoresEntry entry;
  const HighscoreTile({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Container(
      height: 100,
      // color: resolveColor(entry.position),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 70,
                height: 70,
                color: cardBackgroundColor,

                ///TODO: dodac obrazek
                child: const Icon(Icons.person),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.username,
                  style: highscoresTileTextStyle,
                ),
                Text(
                  '${entry.score.toString()} ${_locale.highscores.points}',
                  style: highscoresTileTextStyle.copyWith(
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            // resolvePosition(entry.position),
          ],
        ),
      ),
    );
  }

  Color resolveColor(int position) {
    switch (position) {
      case 1:
        return firstPositionColor;
      case 2:
        return secondPositionColor;
      case 3:
        return tertiaryColor;
      default:
        return Colors.white;
    }
  }

  Widget resolvePosition(int position) {
    if (position > 3) {
      return Text(position.toString());
    } else if (position == 1) {
      return const Icon(Icons.one_k);
    } else if (position == 2) {
      return const Icon(Icons.two_k);
    } else {
      return const Icon(Icons.three_k);
    }
  }
}

class FilterChooser extends ConsumerWidget {
  const FilterChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Row(
      children: [
        Text(
          '${_locale.highscores.in_your} ',
          style: logoTextStyle,
        ),
        DropdownButton(
          value: ref.watch(highscoresFilterControllerProvider),
          items: ref
              .watch(highscoresFilterControllerProvider.notifier)
              .getAllStates()
              .map<DropdownMenuItem<HighscoresFilterState>>(
                  (HighscoresFilterState value) {
            return DropdownMenuItem<HighscoresFilterState>(
              value: value,
              child: Text(translateFilter(value.toString(), _locale)),
            );
          }).toList(),
          onChanged: (value) {
            ref
                .read(highscoresFilterControllerProvider.notifier)
                .setState(value as HighscoresFilterState);
          },
          elevation: 0,
          style: logoTextStyle,
        )
      ],
    );
  }

  String translateFilter(String value, Messages messages) {
    if (value == 'Country') {
      return messages.highscores.country;
    }
    if (value == 'City') {
      return messages.highscores.city;
    }
    if (value == 'Neighbourhood') {
      return messages.highscores.neighbourhood;
    }
    return 'Error';
  }
}

class HighscoresList extends ConsumerWidget {
  List<HighscoresEntry> entries;
  HighscoresList({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leaderboard leaderboard = ref.watch(leaderboardNotifier);
    // List<HighscoresEntry>? entries = leaderboard.leader_board;
    // entries ??= [];
    return Expanded(
      child: ListView(
        children: [
          for (HighscoresEntry entry in entries) HighscoreTile(entry: entry),
        ],
      ),
    );
  }
}
