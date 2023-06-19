import 'package:carbonless/models/partner_model.dart';
import 'package:carbonless/providers/states/partner/partners_filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
