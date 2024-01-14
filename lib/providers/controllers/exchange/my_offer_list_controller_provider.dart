import 'package:carbonless_free/providers/controllers/loaders/view_loading_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/exchange_offer_model.dart';

class MyOfferListNotifier extends StateNotifier<List<ExchangeOffer>> {
  MyOfferListNotifier(List<ExchangeOffer> initialState, this.ref)
      : super(initialState);
  final Ref ref;
  bool _initialized = false;

  void initialize() async {
    if (_initialized) {
      return;
    }
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
    await _getMyOffers();
    _initialized = true;
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
  }

  Future<void> _getMyOffers() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setListOfOffersFromJson([]);
  }

  void setListOfOffersFromJson(List<dynamic> offers) {
    List<ExchangeOffer> offersList = [
      ExchangeOffer(
        id: 0,
        username: 'Mioszek',
        location: 'Lowicz',
        description: 'Pralka w dobrym stanie, nieprzechodzona',
        title: 'Oddam pralkę',
        created_at: DateTime(2023, 10, 13),
      ),
      ExchangeOffer(
        id: 1,
        username: 'Mioszek',
        location: 'Lowicz',
        description: 'Pralka w dobrym stanie, nieprzechodzona',
        title: 'Oddam pralkę',
        created_at: DateTime(2023, 11, 13),
      ),
      ExchangeOffer(
        id: 2,
        username: 'Mioszek',
        location: 'Lowicz',
        description: 'Pralka w dobrym stanie, nieprzechodzona',
        title: 'Oddam pralkę',
        created_at: DateTime(2023, 12, 13),
      ),
      ExchangeOffer(
        id: 3,
        username: 'Mioszek',
        location: 'Lowicz',
        description: 'Pralka w dobrym stanie, nieprzechodzona',
        title: 'Oddam pralkę',
        created_at: DateTime(2023, 10, 14),
      ),
      ExchangeOffer(
        id: 4,
        username: 'Mioszek',
        location: 'Lowicz',
        description: 'Pralka w dobrym stanie, nieprzechodzona',
        title: 'Oddam pralkę',
        created_at: DateTime(2023, 10, 15),
      ),
    ];
    state = offersList;
  }
}

final myOfferListNotifier =
    StateNotifierProvider<MyOfferListNotifier, List<ExchangeOffer>>((ref) {
  return MyOfferListNotifier([], ref);
});
