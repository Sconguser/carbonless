import 'package:equatable/equatable.dart';

import '../../../models/partner_model.dart';

class PartnersFilterState extends Equatable {
  const PartnersFilterState();
  @override
  List<Object?> get props => [];
}

class PartnersFilterAll extends PartnersFilterState {
  const PartnersFilterAll();
  @override
  List<Object?> get props => [];
}

class PartnersFilterByName extends PartnersFilterState {
  final String name;
  const PartnersFilterByName({required this.name});
  @override
  List<Object?> get props => [];
}

class PartnersFilterByPartner extends PartnersFilterState {
  final Partner partner;
  const PartnersFilterByPartner({required this.partner});
  @override
  List<Object?> get props => [];
}
