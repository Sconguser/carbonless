import 'dart:convert';

import '../../../auth/auth_repository.dart';
import '/providers/controllers/highscores/highscores_filter_controller_provider.dart';
import '/providers/controllers/highscores/leaderboard_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';
import '../../../services/http_utils/http_service.dart';
import '../../../services/http_utils/request_provider.dart';
import '../../states/highscores/highscores_filter_state.dart';
import '../loaders/view_loading_controller_provider.dart';
import 'package:http/http.dart' as http;

class LeaderboardNotifier extends StateNotifier<Leaderboard> {
  LeaderboardNotifier(Leaderboard state, this.ref) : super(state);
  final Ref ref;
  bool _initialized = false;

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await refreshOnState();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  Future<void> _getHighscoresWithoutScope() async {
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          null,
          Endpoint.HIGHSCORE,
          ref.read(authRepositoryProvider).getToken(),
          null,
        );
    Map<String, dynamic> decodedMap = jsonDecode(response.body);
    _setLeaderboardFromJson(decodedMap);
  }

  Future<void> _getHighscoresCountryScoped() async {
    Map<String, dynamic> queryParameters = {
      "scope": "country",
      "country": "Poland"
    };
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          queryParameters,
          Endpoint.HIGHSCORE,
          ref.read(authRepositoryProvider).getToken(),
          null,
        );
    Map<String, dynamic> decodedMap = jsonDecode(response.body);
    _setLeaderboardFromJson(decodedMap);
  }

  Future<void> _getHighscoresCityScoped() async {
    Map<String, dynamic> queryParameters = {"scope": "city", "country": "Lodz"};
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          queryParameters,
          Endpoint.HIGHSCORE,
          ref.read(authRepositoryProvider).getToken(),
          null,
        );
    Map<String, dynamic> decodedMap = jsonDecode(response.body);
    _setLeaderboardFromJson(decodedMap);
  }

  Future<void> refreshOnState() async {
    HighscoresFilterState highscoresFilterState =
        ref.read(highscoresFilterControllerProvider);
    if (highscoresFilterState == HighscoresFilterCity()) {
      _getHighscoresCityScoped();
      return;
    } else if (highscoresFilterState == HighscoresFilterCountry()) {
      _getHighscoresCountryScoped();
      return;
    } else if (highscoresFilterState == HighscoresFilterNeighbourhood()) {
      _getHighscoresWithoutScope();
      return;
    }
  }

  void _setLeaderboardFromJson(Map<String, dynamic> decodedMap) {
    Leaderboard leaderboard = Leaderboard.fromJson(decodedMap);
    state = leaderboard;
  }
}

final leaderboardNotifier =
    StateNotifierProvider<LeaderboardNotifier, Leaderboard>((ref) {
  Leaderboard leaderboard = const Leaderboard(rank: 0, score: 0, username: '');
  return LeaderboardNotifier(leaderboard, ref);
});
