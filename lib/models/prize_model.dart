import 'package:freezed_annotation/freezed_annotation.dart';

part 'prize_model.freezed.dart';
part 'prize_model.g.dart';

enum PRIZE_STATE { NOT_OBTAINED, OBTAINED, REDEEMED }

@freezed
class Prize with _$Prize {
  const factory Prize({
    required int id,
    required String title,
    required int price,
    required int duration,
    required String uuid,
    required int partner_id,
    @Default(PRIZE_STATE.NOT_OBTAINED) PRIZE_STATE state,
  }) = _Prize;
  factory Prize.fromJson(Map<String, dynamic> json) => _$PrizeFromJson(json);
}

extension PrizeExtension on Prize {
  bool isObtained() =>
      state == PRIZE_STATE.OBTAINED || state == PRIZE_STATE.REDEEMED;
}
