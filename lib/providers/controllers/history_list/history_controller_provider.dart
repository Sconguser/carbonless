import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/history_model.dart';

class HistoryNotifier extends StateNotifier<List<History>> {
  HistoryNotifier(List<History> state) : super(state);
}

final historyNotifier =
    StateNotifierProvider<HistoryNotifier, List<History>>((ref) {
  List<History>? histories = [
    History(
        text: "Zdobyto 10 punktów za zakup kawy w ekologicznym kubku",
        dateTime: DateTime.now()),
    History(
        text: "Wydano 1000 punktów w sklepie",
        dateTime: DateTime(2021, 10, 10)),
    History(
        text: "Zdobyto 2137 punktów za przejazd metrm",
        dateTime: DateTime(2023, 12, 11)),
    History(
        text: "Zdobyto 2222 punktów za przejazd tramwajem",
        dateTime: DateTime(2021, 2, 3)),
    History(
        text: "Zdobyto 321 punktów za zakupy w slkepie ekologicznym",
        dateTime: DateTime(2022, 10, 10)),
    History(
        text: "Zdobyto 10 punktów za zakup kawy w ekologicznym kubku",
        dateTime: DateTime(2021, 11, 3)),
    History(
        text: "Zdobyto 10 punktów za zakup kawy w ekologicznym kubku",
        dateTime: DateTime(2022, 1, 1)),
  ];
  return HistoryNotifier(histories);
});
