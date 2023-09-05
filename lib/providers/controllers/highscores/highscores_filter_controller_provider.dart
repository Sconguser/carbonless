import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/highscores/highscores_filter_state.dart';
import 'highscores_entry_controller_provider.dart';

class HighscoresFilterController extends StateNotifier<HighscoresFilterState> {
  HighscoresFilterController(this.ref) : super(HighscoresFilterCity());
  final Ref ref;

  // void _filterCity() {
  //   state = HighscoresFilterCity();
  //   ref.read(leaderboardNotifier.notifier).getHighscoresCityScoped();
  // }
  //
  // void _filterCountry() {
  //   state = HighscoresFilterCountry();
  //   ref.read(leaderboardNotifier.notifier).getHighscoresCountryScoped();
  // }
  //
  // void _filterNeighbourhood() {
  //   state = HighscoresFilterNeighbourhood();
  //   ref.read(leaderboardNotifier.notifier).getHighscoresWithoutScope();
  // }

  void setState(HighscoresFilterState state) {
    this.state = state;
    ref.read(leaderboardNotifier.notifier).refreshOnState();
  }

  List<HighscoresFilterState> getAllStates() {
    return [
      HighscoresFilterCountry(),
      HighscoresFilterCity(),
      HighscoresFilterNeighbourhood()
    ];
  }
}

final highscoresFilterControllerProvider =
    StateNotifierProvider<HighscoresFilterController, HighscoresFilterState>(
        (ref) => HighscoresFilterController(ref));
