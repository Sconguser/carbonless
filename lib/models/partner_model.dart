import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:equatable/equatable.dart';

import 'location_model.dart';
part 'partner_model.freezed.dart';
part 'partner_model.g.dart';

@freezed
class Partner extends Equatable with _$Partner {
  const Partner._();
  const factory Partner({
    required String name,
    String? description,
    required List<Location> locations,
  }) = _Partner;
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
  @override
  List<Object?> get props => [name, locations];
}
