import 'package:freezed_annotation/freezed_annotation.dart';

import 'location_model.dart';

part 'partner_model.freezed.dart';
part 'partner_model.g.dart';

@freezed
class Partner with _$Partner {
  const factory Partner({
    required String name,
    required List<Location> locations,
  }) = _Partner;
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}
