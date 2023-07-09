import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';
part 'history_model.g.dart';

@freezed
class History with _$History {
  const factory History({
    required String text,
    required DateTime dateTime,
  }) = _History;
  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}
