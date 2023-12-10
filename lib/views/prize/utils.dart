import '/providers/states/prize_list/prize_filter_state.dart';
import '/shared/constants.dart';
import 'package:flutter/material.dart';
import '../../models/prize_model.dart';

List<Prize> filter(List<Prize>? prizes, PrizeFilterState prizeFilterState) {
  if (prizes == null) return [];
  if (prizeFilterState == PrizeFilterAll()) return prizes;
  if (prizeFilterState == PrizeFilterUnlocked()) {
    return prizes.where((prize) => prize.isObtained()).toList();
  }
  if (prizeFilterState == PrizeFilterLocked()) {
    return prizes.where((prize) => !prize.isObtained()).toList();
  }
  return [];
}

Color getPrizeColor(Prize prize) {
  if (prize.state == PRIZE_STATE.NOT_OBTAINED) {
    return inactiveColor;
  }
  if (prize.state == PRIZE_STATE.OBTAINED) {
    return secondaryColor;
  }
  if (prize.state == PRIZE_STATE.REDEEMED) {
    return activeColor;
  }
  return inactiveColor;
}
