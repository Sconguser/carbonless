import 'package:flutter/foundation.dart';

import '../models/partner_model.dart';
import '../providers/states/partner/partners_filter_state.dart';

class PartnersUtils {
  PartnersUtils._();
  static List<Partner> filter(
      List<Partner> partners, PartnersFilterState partnersFilterState) {
    if (partnersFilterState is PartnersFilterAll) {
      return partners;
    }
    if (partnersFilterState is PartnersFilterByPartner) {
      Partner partner = partnersFilterState.partner;
      return _filterByPartner(partners, partner);
    }
    if (partnersFilterState is PartnersFilterByName) {
      String name = partnersFilterState.name;
      return _filterByName(partners, name);
    }
    debugPrint('Failed to filter partnerList $partnersFilterState, $partners');
    return partners;
  }

  static List<Partner> _filterByPartner(
      List<Partner> partners, Partner partner) {
    return partners.where((listPartner) => listPartner == partner).toList();
  }

  static List<Partner> _filterByName(List<Partner> partners, String name) {
    return partners
        .where((partner) =>
            partner.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
