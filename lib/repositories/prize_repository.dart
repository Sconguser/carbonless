import 'package:carbonless/models/prize_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrizeRepository {
  List<Prize>? _prizes = [
    Prize(
      id: '0',
      isObtained: false,
      text: "Zniżka na metro",
      price: 200,
    ),
    Prize(
      id: '1',
      isObtained: true,
      text: "Zniżka na kawe",
      price: 500,
    ),
    Prize(
      id: '2',
      isObtained: false,
      text: "Wstęp do zoo",
      price: 300,
    ),
    Prize(
      id: '3',
      isObtained: false,
      text: "Kino",
      price: 600,
    ),
    Prize(
      id: '4',
      isObtained: false,
      text: "Pociąg",
      price: 200,
    ),
    Prize(
      id: '5',
      isObtained: false,
      text: "Samolot",
      price: 100,
    ),
    Prize(
      id: '6',
      isObtained: false,
      text: "Samochód",
      price: 400,
    ),
  ];
  List<Prize>? get prizes => _prizes;
}

final prizeRepositoryProvider = Provider<PrizeRepository>((ref) {
  return PrizeRepository();
});
