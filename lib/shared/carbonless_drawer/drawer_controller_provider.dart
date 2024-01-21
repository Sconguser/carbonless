import '../../providers/controllers/exchange/offers/my_offer_list_controller_provider.dart';
import '../../providers/controllers/exchange/requests/my_request_list_controller_provider.dart';
import '../../providers/states/navigation/app_navigation_state.dart';
import '../../providers/states/navigation/exchanges/offers_navigation_state.dart';
import '../../providers/states/navigation/exchanges/request_navigation_state.dart';
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
    _setAppNavigationToAuxiliary(const EditProfileView());
  }

  void showHighscores() {
    state = const Highscores();
    ref.read(leaderboardNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary(const HighscoresView());
  }

  void showHistory() {
    state = const History();
    ref.read(historyNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary(const HistoryView());
  }

  void showMyOffers() {
    state = const MyOffers();
    ref.read(myOfferListNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary(const MyOfferListView());
  }

  void showMyRequests() {
    state = const MyRequests();
    ref.read(myRequestListNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary(const MyRequestListView());
  }

  void showPartners() {
    state = const Partners();
    ref.read(partnersNotifier.notifier).initialize();
    _setAppNavigationToAuxiliary(const PartnersView());
  }

  void showSettings() {
    state = const Settings();
    _setAppNavigationToAuxiliary(const SettingsView());
  }

  void showAbout() {
    state = const About();
    _setAppNavigationToAuxiliary(const AboutView());
  }

  void logout() {
    ref.read(authControllerProvider.notifier).logout();
    ref.read(appNavigationControllerProvider.notifier).reset();
  }

  void _setAppNavigationToAuxiliary(AppNavigationState state) {
    ref.read(appNavigationControllerProvider.notifier).showAuxiliary(state);
  }
}

final drawerControllerProvider =
    StateNotifierProvider<DrawerController, DrawerState>((ref) {
  return DrawerController(ref);
});
