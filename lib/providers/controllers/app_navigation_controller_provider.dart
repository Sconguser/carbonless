import '/providers/states/app_navigation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/bottom_nav_bar.dart';

class AppNavigationController extends StateNotifier<AppNavigationState> {
  AppNavigationController(this.ref) : super(const AppNavigationMain());
  final Ref ref;
  void showMain() {
    state = const AppNavigationMain();
  }

  void showAuxiliary() {
    state = const AppNavigationAuxiliary();
  }

  void reset() {
    state = const AppNavigationMain();
    ref.read(bottomNavIndexProvider.notifier).state = 0;
  }
}

final appNavigationControllerProvider =
    StateNotifierProvider<AppNavigationController, AppNavigationState>((ref) {
  return AppNavigationController(ref);
});
