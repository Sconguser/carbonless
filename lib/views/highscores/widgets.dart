import 'package:carbonless/providers/controllers/highscores/highscores_filter_controller_provider.dart';
import 'package:carbonless/providers/states/highscores/highscores_filter_state.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HighscoreTile extends ConsumerWidget {
  final Color color;
  final Icon? avatar;
  final String nickname;
  final int points;
  final int position;
  const HighscoreTile({
    Key? key,
    this.color = Colors.white,
    this.avatar,
    required this.nickname,
    required this.points,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      color: color,
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
                child: avatar ?? const Icon(Icons.person),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nickname,
                  style: highscoresTileTextStyle,
                ),
                Text(
                  '${points.toString()} points',
                  style: highscoresTileTextStyle.copyWith(
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            resolvePosition(position),
          ],
        ),
      ),
    );
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
    return Row(
      children: [
        Text(
          'In your ',
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
              child: Text(value.toString()),
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
}

const List<String> list = ['country', 'city', 'neighbourhood'];
