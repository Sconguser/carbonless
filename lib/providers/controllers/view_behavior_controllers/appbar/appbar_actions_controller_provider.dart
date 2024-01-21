import 'package:carbonless_free/providers/controllers/app_navigation_controller_provider.dart';
import 'package:carbonless_free/providers/states/navigation/exchanges/offers_navigation_state.dart';
import 'package:carbonless_free/views/exchange/offers/create/create_view.dart';
import 'package:carbonless_free/views/exchange/offers/offer_list/exchanges_list/exchange_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../states/navigation/app_navigation_state.dart';

class AppbarActionsController extends StateNotifier<List<Widget>> {
  AppbarActionsController(List<Widget> actions, this.ref) : super(actions) {
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
  return [];
}

final appbarActionsControllerNotifier =
    StateNotifierProvider<AppbarActionsController, List<Widget>>((ref) {
  return AppbarActionsController([], ref);
});
