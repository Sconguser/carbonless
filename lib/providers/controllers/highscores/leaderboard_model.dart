import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/highscores_entry_model.dart';

part 'leaderboard_model.freezed.dart';
part 'leaderboard_model.g.dart';

@freezed
class Leaderboard with _$Leaderboard {
  const factory Leaderboard({
    List<HighscoresEntry>? leader_board,
    required int rank,
    required int score,
    required String username,
  }) = _Leaderboard;
  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);
}
