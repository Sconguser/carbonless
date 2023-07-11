import 'package:carbonless/models/location_model.dart';
import 'package:carbonless/models/partner_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnersNotifier extends StateNotifier<List<Partner>> {
  PartnersNotifier(List<Partner> state) : super(state);
  void setListOfPartners(List<dynamic> partners) {
    List<Partner> partnerList = [];
    for (dynamic partner in partners) {
      partnerList.add(Partner.fromJson(partner));
    }
    state = partnerList;
  }
}

final partnersNotifier =
    StateNotifierProvider<PartnersNotifier, List<Partner>>((ref) {
  List<Partner>? partners = [
    Partner(
      name: "Star shop",
      locations: [
        Location(longitude: '30.5', latitude: '20'),
      ],
    ),
    Partner(
      name: "Coffee Star",
      locations: [
        Location(longitude: '49.5', latitude: '-0.09'),
        Location(longitude: '23.5', latitude: '-0.09'),
        Location(longitude: '32.5', latitude: '-0.08'),
      ],
    ),
  ];
  return PartnersNotifier(partners);
});
