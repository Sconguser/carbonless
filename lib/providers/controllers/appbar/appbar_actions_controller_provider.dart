import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/providers/controllers/exchange/exchange_navigation_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/exchange/exchange_navigation_state.dart';

enum ViewType { OFFERS, OTHER }

class AppbarActionsController extends StateNotifier<List<Widget>> {
  AppbarActionsController(List<Widget> actions, this.ref) : super(actions);
  final Ref ref;

  void setActions(List<Widget> actions) {
    state = actions;
  }

  void setActionsForTypeView(ViewType viewType) {
    switch (viewType) {
      case ViewType.OFFERS:
        setActions(getActionsForOffersView(ref));
        break;
      default:
        clearActions();
        break;
    }
  }

  void clearActions() {
    state = [];
  }
}

List<Widget> getActionsForOffersView(Ref ref) {
  if (ref.read(exchangeNavigationControllerProvider) == const CreateOffer()) {
    return [];
  }
  return [
    ElevatedButton(
      child: Text(ref.read(messagesProvider).button.add_offer),
      onPressed: () {
        ref.read(exchangeNavigationControllerProvider.notifier).createOffer();
      },
    )
  ];
}

final appbarActionsControllerNotifier =
    StateNotifierProvider<AppbarActionsController, List<Widget>>((ref) {
  List<Widget>? actions = getActionsForOffersView(ref);
  return AppbarActionsController(actions, ref);
});
