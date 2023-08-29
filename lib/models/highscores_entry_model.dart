import 'package:freezed_annotation/freezed_annotation.dart';

part 'highscores_entry_model.freezed.dart';
part 'highscores_entry_model.g.dart';

@freezed
class HighscoresEntry with _$HighscoresEntry {
  @JsonSerializable(explicitToJson: true)
  const factory HighscoresEntry({
    required int id,
    required int score,
    String? country,
    String? city,
    required String username,
  }) = _HigscoresEntry;
  factory HighscoresEntry.fromJson(Map<String, dynamic> json) =>
      _$HighscoresEntryFromJson(json);
}
