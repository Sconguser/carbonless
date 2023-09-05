import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/loading_state.dart';

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
