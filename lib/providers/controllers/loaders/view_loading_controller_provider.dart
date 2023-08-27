import 'package:carbonless/providers/states/loading_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewLoadingController extends StateNotifier<LoadingState> {
  ViewLoadingController() : super(const LoadingOff());

  void viewLoadingOn() {
    state = const LoadingOn();
  }

  void viewLoadingOff() {
    state = const LoadingOff();
  }
}

final viewLoadingControllerProvider =
    StateNotifierProvider<ViewLoadingController, LoadingState>((ref) {
  return ViewLoadingController();
});
