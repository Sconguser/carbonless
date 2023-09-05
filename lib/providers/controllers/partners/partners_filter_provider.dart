import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/partner_model.dart';
import '../../states/partner/partners_filter_state.dart';

class PartnersFilterController extends StateNotifier<PartnersFilterState> {
  PartnersFilterController(this.ref) : super(const PartnersFilterAll());
  final Ref ref;

  void showAll() {
    state = const PartnersFilterAll();
  }

  void filterByPartner(Partner partner) {
    state = PartnersFilterByPartner(partner: partner);
  }

  void filterByName(String name) {
    state = PartnersFilterByName(name: name);
  }
}

final partnersFilterControllerProvider =
    StateNotifierProvider<PartnersFilterController, PartnersFilterState>(
        (ref) => PartnersFilterController(ref));
