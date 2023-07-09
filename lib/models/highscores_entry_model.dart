import 'package:freezed_annotation/freezed_annotation.dart';

part 'highscores_entry_model.freezed.dart';
part 'highscores_entry_model.g.dart';

@freezed
class HighscoresEntry with _$HighscoresEntry {
  const factory HighscoresEntry({
    required String nickname,
    required int points,
    required int position,
  }) = _HigscoresEntry;
  factory HighscoresEntry.fromJson(Map<String, dynamic> json) =>
      _$HighscoresEntryFromJson(json);
}
