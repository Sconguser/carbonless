import '/providers/states/app_navigation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/bottom_nav_bar.dart';
import 'view_behavior_controllers/appbar/appbar_actions_controller_provider.dart';

class AppNavigationController extends StateNotifier<AppNavigationState> {
  AppNavigationController(this.ref)
      : super(AppNavigationMain(view: MainView.Exchange));
  final Ref ref;

  void changeMainView(int index) {
    ref.read(bottomNavIndexProvider.notifier).state = index;
    showMain();
  }

  void showMain() {
    ViewType viewType = getViewTypeForState();
    ref
        .read(appbarActionsControllerNotifier.notifier)
        .setActionsForTypeView(viewType);
    state = AppNavigationMain(
        view:
            viewType == ViewType.OFFERS ? MainView.Exchange : MainView.Scanner);
  }

  void showAuxiliary() {
    ref
        .read(appbarActionsControllerNotifier.notifier)
        .setActionsForTypeView(getViewTypeForState());
    state = const AppNavigationAuxiliary();
    ref.read(bottomNavIndexProvider.notifier).state = -1;
  }

  void reset() {
    ref.read(appbarActionsControllerNotifier.notifier).clearActions();
    state = AppNavigationMain(view: MainView.Exchange);
    ref.read(bottomNavIndexProvider.notifier).state = 0;
  }

  ViewType getViewTypeForState() {
    if (state is AppNavigationMain) {
      switch (ref.read(bottomNavIndexProvider)) {
        case 0:
          return ViewType.OFFERS;
        default:
          return ViewType.OTHER;
      }
    } else {
      return ViewType.OTHER;
    }
  }
}

final appNavigationControllerProvider =
    StateNotifierProvider<AppNavigationController, AppNavigationState>((ref) {
  return AppNavigationController(ref);
});
