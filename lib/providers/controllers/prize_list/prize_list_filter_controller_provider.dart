import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/prize_list/prize_filter_state.dart';

class PrizeListFilterController extends StateNotifier<PrizeFilterState> {
  PrizeListFilterController(this.ref) : super(const PrizeFilterAll());
  final Ref ref;

  void showAll() {
    state = const PrizeFilterAll();
  }

  void showUnlocked() {
    state = const PrizeFilterUnlocked();
  }

  void showLocked() {
    state = const PrizeFilterLocked();
  }
}

final prizeListFilterControllerProvider =
    StateNotifierProvider<PrizeListFilterController, PrizeFilterState>(
        (ref) => PrizeListFilterController(ref));
