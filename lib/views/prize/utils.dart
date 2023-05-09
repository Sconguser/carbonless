import 'package:carbonless/providers/states/prize_list/prize_filter_state.dart';

import '../../models/prize_model.dart';

List<Prize> filter(List<Prize>? prizes, PrizeFilterState prizeFilterState) {
  if (prizes == null) return [];
  if (prizeFilterState == PrizeFilterAll()) return prizes;
  if (prizeFilterState == PrizeFilterUnlocked()) {
    return prizes.where((prize) => prize.isObtained).toList();
  }
  if (prizeFilterState == PrizeFilterLocked()) {
    return prizes.where((prize) => !prize.isObtained).toList();
  }
  return [];
}
