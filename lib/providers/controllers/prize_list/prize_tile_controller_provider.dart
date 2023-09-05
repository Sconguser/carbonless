import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/prize_list/prize_tile_state.dart';

class PrizeTileStateNotifier extends StateNotifier<PrizeTileState> {
  PrizeTileStateNotifier() : super(PrizeTileShowPrize(prizeId: -1));

  void showQrCode(String data, int prizeId) {
    state = PrizeTileShowCode(data: data, prizeId: prizeId);
  }

  void showPrize(int prizeId) {
    state = PrizeTileShowPrize(prizeId: prizeId);
  }
}

final prizeTileProvider =
    StateNotifierProvider<PrizeTileStateNotifier, PrizeTileState>((ref) {
  return PrizeTileStateNotifier();
});
