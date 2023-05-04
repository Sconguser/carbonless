import 'package:carbonless/providers/controllers/auth_controller_provider.dart';
import 'package:carbonless/providers/states/app_navigation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }
}

final appNavigationControllerProvider =
    StateNotifierProvider<AppNavigationController, AppNavigationState>((ref) {
  return AppNavigationController(ref);
});
