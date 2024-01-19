import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/exchange_offer_model.dart';
import '../loaders/view_loading_controller_provider.dart';

class ExchangeListNotifier extends StateNotifier<List<ExchangeOffer>> {
  ExchangeListNotifier(List<ExchangeOffer> state, this.ref) : super(state);
  final Ref ref;

  bool _initialized = false;

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await _getOffers();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  Future<void> _getOffers() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    // List<dynamic> decodedList = jsonDecode(response.body);
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

final exchangeOfferListNotifier =
    StateNotifierProvider<ExchangeListNotifier, List<ExchangeOffer>>((ref) {
  return ExchangeListNotifier([], ref);
});
