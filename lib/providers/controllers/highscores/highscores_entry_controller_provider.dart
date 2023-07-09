import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';
import '../../../models/highscores_entry_model.dart';

class HighscoresEntryNotifier extends StateNotifier<List<HighscoresEntry>> {
  HighscoresEntryNotifier(List<HighscoresEntry> state) : super(state);
}

final highscoresEntryNotifier =
    StateNotifierProvider<HighscoresEntryNotifier, List<HighscoresEntry>>(
        (ref) {
  List<HighscoresEntry>? highscores = [
    HighscoresEntry(nickname: 'Mioszek P.', points: 1000, position: 1),
    HighscoresEntry(nickname: 'Kinia R.', points: 900, position: 2),
    HighscoresEntry(nickname: 'Harry T.', points: 700, position: 3),
    HighscoresEntry(nickname: 'Tadek W.', points: 300, position: 4),
    HighscoresEntry(nickname: 'Maciek C.', points: 10, position: 5),
  ];
  return HighscoresEntryNotifier(highscores);
});
