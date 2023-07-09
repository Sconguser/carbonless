import 'package:carbonless/providers/states/highscores/highscores_filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HighscoresFilterController extends StateNotifier<HighscoresFilterState> {
  HighscoresFilterController(this.ref) : super(HighscoresFilterCity());
  final Ref ref;

  void _filterCity() {
    state = HighscoresFilterCity();
  }

  void _filterCountry() {
    state = HighscoresFilterCity();
  }

  void _filterNeighbourhood() {
    state = HighscoresFilterNeighbourhood();
  }

  void setState(HighscoresFilterState state) {
    this.state = state;
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
