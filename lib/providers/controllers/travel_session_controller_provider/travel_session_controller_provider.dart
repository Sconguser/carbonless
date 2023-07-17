import 'package:carbonless/providers/states/travel_session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TravelSessionController extends StateNotifier<TravelSessionState> {
  TravelSessionController(this.ref) : super(const TravelSessionClosed());
  final Ref ref;

  void openSession() {
    state = const TravelSessionOpen();
  }

  void closeSession() {
    state = const TravelSessionClosed();
  }
}

final travelSessionControllerProvider =
    StateNotifierProvider<TravelSessionController, TravelSessionState>((ref) {
  return TravelSessionController(ref);
});
