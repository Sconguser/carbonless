import 'package:carbonless/models/prize_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrizeRepository {
  List<Prize>? _prizes = [
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
  List<Prize>? get prizes => _prizes;
}

final prizeRepositoryProvider = Provider<PrizeRepository>((ref) {
  return PrizeRepository();
});
