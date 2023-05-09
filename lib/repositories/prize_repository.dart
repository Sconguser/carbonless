import 'package:carbonless/models/prize_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrizeRepository {
  List<Prize>? _prizes = [
    Prize(
      id: '0',
      isObtained: false,
      text: "Zniżka na metro",
    ),
    Prize(
      id: '1',
      isObtained: true,
      text: "Zniżka na kawe",
    ),
    Prize(
      id: '2',
      isObtained: false,
      text: "Wstęp do zoo",
    ),
    Prize(
      id: '3',
      isObtained: false,
      text: "Kino",
    ),
    Prize(
      id: '4',
      isObtained: false,
      text: "Pociąg",
    ),
    Prize(
      id: '5',
      isObtained: false,
      text: "Samolot",
    ),
    Prize(
      id: '6',
      isObtained: false,
      text: "Samochód",
    ),
  ];
  List<Prize>? get prizes => _prizes;
}

final prizeRepositoryProvider = Provider<PrizeRepository>((ref) {
  return PrizeRepository();
});
