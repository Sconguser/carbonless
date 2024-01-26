import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../states/navigation/app_navigation_state.dart';
import '../../../states/navigation/exchanges/offers_navigation_state.dart';
import '../../app_navigation_controller_provider.dart';

class AppbarActionsController extends StateNotifier<List<Widget>> {
  AppbarActionsController(super.actions, this.ref) {
    ref.watch(appNavigationControllerProvider.notifier).addListener((state) {
      setActions(getActionsForState(ref, state));
    });
  }
  final Ref ref;

  void setActions(List<Widget> actions) {
    state = actions;
  }

  void clearActions() {
    state = [];
  }
}

List<Widget> getActionsForState(Ref ref, AppNavigationState state) {
  if (state is AppNavigationAuxiliary) {
    return [];
  }
  if (state is OfferListView) {
    return getOfferListActions(ref);
  }
  return [];
}

List<Widget> getOfferListActions(Ref<Object?> ref) {
  return [
    ElevatedButton(
      child: Text(ref.read(messagesProvider).button.add_offer),
      onPressed: () {
        ref
            .read(appNavigationControllerProvider.notifier)
            .showMain(const NewOfferView());
      },
    )
  ];
}

final appbarActionsControllerNotifier =
    StateNotifierProvider<AppbarActionsController, List<Widget>>((ref) {
  return AppbarActionsController([], ref);
});
