import 'package:carbonless/providers/states/loading_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetLoadingController extends StateNotifier<LoadingState> {
  WidgetLoadingController() : super(const LoadingOff());

  void widgetLoadingOn() {
    state = const LoadingOn();
  }

  void widgetLoadingOff() {
    state = const LoadingOff();
  }
}

final widgetLoadingControllerProvider =
    StateNotifierProvider<WidgetLoadingController, LoadingState>((ref) {
  return WidgetLoadingController();
});
