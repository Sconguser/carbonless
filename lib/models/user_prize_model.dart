import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_prize_model.freezed.dart';
part 'user_prize_model.g.dart';

@freezed
class UserPrize with _$UserPrize {
  const factory UserPrize({
    required String id,
    required int user_id,
    required int prize_id,
    required bool active,
  }) = _UserPrize;
  factory UserPrize.fromJson(Map<String, dynamic> json) =>
      _$UserPrizeFromJson(json);
}
