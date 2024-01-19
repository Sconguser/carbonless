import 'package:carbonless_free/providers/controllers/exchange/requests/my_request_list_controller_provider.dart';

import '../../providers/controllers/exchange/offers/my_offer_list_controller_provider.dart';
import '/providers/controllers/app_navigation_controller_provider.dart';
import '/providers/controllers/auth_controller_provider.dart';
import '/providers/controllers/highscores/highscores_entry_controller_provider.dart';
import '/providers/controllers/history_list/history_controller_provider.dart';
import '/providers/controllers/partners/partners_controller_provider.dart';
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
    state = const Highscores();
    ref.read(leaderboardNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showHistory() {
    state = const History();
    ref.read(historyNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showMyOffers() {
    state = const MyOffers();
    ref.read(myOfferListNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary();
  }

  void showMyRequests() {
    state = const MyRequests();
    ref.read(myRequestListNotifier.notifier).initialize();
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
  }
}

final drawerControllerProvider =
    StateNotifierProvider<DrawerController, DrawerState>((ref) {
  return DrawerController(ref);
});
