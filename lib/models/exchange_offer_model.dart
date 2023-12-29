import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_offer_model.freezed.dart';
part 'exchange_offer_model.g.dart';

@freezed
class ExchangeOffer with _$ExchangeOffer {
  const factory ExchangeOffer({
    required int id,
    required String username,
    required String location,
    required String description,
    required String title,
    required DateTime created_at,
  }) = _ExchangeOffer;
  factory ExchangeOffer.fromJson(Map<String, dynamic> json) =>
      _$ExchangeOfferFromJson(json);
}
