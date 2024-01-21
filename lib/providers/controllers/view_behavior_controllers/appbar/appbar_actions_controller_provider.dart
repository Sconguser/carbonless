import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppbarActionsController extends StateNotifier<List<Widget>> {
  AppbarActionsController(List<Widget> actions, this.ref) : super(actions);
  final Ref ref;

  void setActions(List<Widget> actions) {
    state = actions;
  }

  void setActionsForTypeView() {}

  void clearActions() {
    state = [];
  }
}

// List<Widget> getActionsForOffersView(Ref ref) {
//   if (ref.read(exchangeNavigationControllerProvider) == const CreateOffer()) {
//     return [];
//   }
//   return [
//     ElevatedButton(
//       child: Text(ref.read(messagesProvider).button.add_offer),
//       onPressed: () {
//         ref.read(exchangeNavigationControllerProvider.notifier).createOffer();
//       },
//     )
//   ];
// }

final appbarActionsControllerNotifier =
    StateNotifierProvider<AppbarActionsController, List<Widget>>((ref) {
  // List<Widget>? actions = getActionsForOffersView(ref);
  return AppbarActionsController([], ref);
});
