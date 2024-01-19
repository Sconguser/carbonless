import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_request_model.freezed.dart';
part 'exchange_request_model.g.dart';

@freezed
class ExchangeRequest with _$ExchangeRequest {
  const factory ExchangeRequest({
    required int id,
    required String username,
    required String body,
    required DateTime created_at,
  }) = _ExchangeRequest;
  factory ExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRequestFromJson(json);
}
