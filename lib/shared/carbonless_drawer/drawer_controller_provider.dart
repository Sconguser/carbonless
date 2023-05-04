import 'package:carbonless/providers/controllers/app_navigation_controller_provider.dart';
import 'package:carbonless/providers/controllers/auth_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drawer_state.dart';

class DrawerController extends StateNotifier<DrawerState> {
  DrawerController(this.ref) : super(const DrawerInitialState());

  final Ref ref;

  void showEditDataView() {
    state = const EditData();
    _setAppNavigationToAuxiliary();
  }

  void showHighscores() {
    state = Highscores();
    _setAppNavigationToAuxiliary();
  }

  void showHistory() {
    state = History();
    _setAppNavigationToAuxiliary();
  }

  void showPartners() {
    state = Partners();
    _setAppNavigationToAuxiliary();
  }

  void showSettings() {
    state = Settings();
    _setAppNavigationToAuxiliary();
  }

  void logout() {
    ref.read(authControllerProvider.notifier).logout();
  }

  void _setAppNavigationToAuxiliary() {
    ref.read(appNavigationControllerProvider.notifier).showAuxiliary();
  }
}

final drawerControllerProvider =
    StateNotifierProvider<DrawerController, DrawerState>((ref) {
  return DrawerController(ref);
});
