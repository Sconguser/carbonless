import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/app_navigation_controller_provider.dart';
import '../../providers/controllers/auth_controller_provider.dart';
import '../../providers/controllers/highscores/highscores_entry_controller_provider.dart';
import '../../providers/controllers/history_list/history_controller_provider.dart';
import '../../providers/controllers/partners/partners_controller_provider.dart';
import '../bottom_nav_bar.dart';
import 'drawer_state.dart';

class DrawerController extends StateNotifier<DrawerState> {
  DrawerController(this.ref) : super(const DrawerInitialState());

  final Ref ref;

  void showEditDataView() {
    state = const EditData();
    _setAppNavigationToAuxiliary();
  }

  void showHighscores() {
    state = const Highscores();
    ref.read(leaderboardNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showHistory() {
    state = const History();
    ref.read(historyNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showPartners() {
    state = const Partners();
    ref.read(partnersNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showSettings() {
    state = const Settings();
    _setAppNavigationToAuxiliary();
  }

  void showAbout() {
    state = const About();
    _setAppNavigationToAuxiliary();
  }

  void logout() {
    ref.read(authControllerProvider.notifier).logout();
    ref.read(appNavigationControllerProvider.notifier).reset();
  }

  void _setAppNavigationToAuxiliary() {
    ref.read(appNavigationControllerProvider.notifier).showAuxiliary();
    ref.read(bottomNavIndexProvider.notifier).state = -1;
  }
}

final drawerControllerProvider =
    StateNotifierProvider<DrawerController, DrawerState>((ref) {
  return DrawerController(ref);
});
