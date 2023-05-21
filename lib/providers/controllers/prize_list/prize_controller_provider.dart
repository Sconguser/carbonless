import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/prize_model.dart';

class PrizesNotifier extends StateNotifier<List<Prize>> {
  PrizesNotifier(List<Prize> state) : super(state);

  Future<void> obtainPrize(String prizeId) async {
    final updatedPrizes = state.map((prize) {
      if (prize.id == prizeId && prize.state == PRIZE_STATE.NOT_OBTAINED) {
        return Prize(
          id: prize.id,
          state: PRIZE_STATE.OBTAINED,
          text: prize.text,
          price: prize.price,
        );
      }
      return prize;
    }).toList();

    state = updatedPrizes;
  }

  Future<void> redeemPrize(String prizeId) async {
    final updatedPrizes = state.map((prize) {
      if (prize.id == prizeId && prize.state == PRIZE_STATE.OBTAINED) {
        // prize.copyWith(state: PRIZE_STATE.REDEEMED);
        return Prize(
          id: prize.id,
          state: PRIZE_STATE.REDEEMED,
          text: prize.text,
          price: prize.price,
        );
      }
      return prize;
    }).toList();

    state = updatedPrizes;
  }
}

final prizesProvider =
    StateNotifierProvider<PrizesNotifier, List<Prize>>((ref) {
  // Initialize the prizes list with some initial values
  List<Prize>? prizes = [
    Prize(
      id: '0',
      state: PRIZE_STATE.NOT_OBTAINED,
      text: "Zniżka na metro",
      price: 200,
    ),
    Prize(
      id: '1',
      state: PRIZE_STATE.OBTAINED,
      text: "Zniżka na kawe",
      price: 500,
    ),
    Prize(
      id: '2',
      state: PRIZE_STATE.OBTAINED,
      text: "Wstęp do zoo",
      price: 300,
    ),
    Prize(
      id: '3',
      state: PRIZE_STATE.OBTAINED,
      text: "Kino",
      price: 600,
    ),
    Prize(
      id: '4',
      state: PRIZE_STATE.NOT_OBTAINED,
      text: "Pociąg",
      price: 200,
    ),
    Prize(
      id: '5',
      state: PRIZE_STATE.NOT_OBTAINED,
      text: "Samolot",
      price: 100,
    ),
    Prize(
      id: '6',
      state: PRIZE_STATE.NOT_OBTAINED,
      text: "Samochód",
      price: 400,
    ),
  ];

  return PrizesNotifier(prizes);
});
