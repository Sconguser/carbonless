import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';
part 'history_model.g.dart';

@freezed
class History with _$History {
  const factory History({
    required String partner_name,
    required int points,
    required int user_id,
    required String history_type,
    String? prize_title,
    required DateTime created_at,
  }) = _History;
  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}
