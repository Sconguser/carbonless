import '../states/navigation/app_navigation_state.dart';
import '../states/navigation/exchanges/offers_navigation_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/bottom_nav_bar.dart';
import 'view_behavior_controllers/appbar/appbar_actions_controller_provider.dart';

class AppNavigationController extends StateNotifier<AppNavigationState> {
  AppNavigationController(this.ref) : super(const OfferListView());
  final Ref ref;

  void changeMainView(int index) {
    ref.read(bottomNavIndexProvider.notifier).state = index;
    switch (index) {
      case 0:
        showMain(const OfferListView());
        break;
      case 1:
        showMain(const ScannerView());
        break;
      default:
        showMain(const ErrorView());
    }
  }

  void showMain(AppNavigationState state) {
    ref.read(appbarActionsControllerNotifier.notifier).setActionsForTypeView();
    this.state = state;
  }

  void showAuxiliary(AppNavigationState state) {
    // ref.read(appbarActionsControllerNotifier.notifier).setActionsForTypeView();
    this.state = state;
    ref.read(bottomNavIndexProvider.notifier).state = -1;
  }

  void reset() {
    ref.read(appbarActionsControllerNotifier.notifier).clearActions();
    state = getDefaultView();
    ref.read(bottomNavIndexProvider.notifier).state = 0;
  }

  AppNavigationState getDefaultView() {
    return const OfferListView();
  }
}

final appNavigationControllerProvider =
    StateNotifierProvider<AppNavigationController, AppNavigationState>((ref) {
  return AppNavigationController(ref);
});
