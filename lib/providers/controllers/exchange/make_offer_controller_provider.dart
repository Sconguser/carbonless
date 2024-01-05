import 'package:carbonless_free/auth/auth_repository.dart';
import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/providers/states/exchange/make_offer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localization/messages.i18n.dart';

class MakeOfferController extends StateNotifier<MakeOfferState> {
  final Ref ref;
  MakeOfferController(this.ref) : super(const MakeOfferStateInitial());

  void sendOffer(String text) async {
    Messages _locale = ref.read(messagesProvider);
    try {
      state = const MakeOfferLoading();
      String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
      if (bearerToken == null) {
        throw Exception(_locale.exceptions.not_authorized);
      }

      /// TODO: implement real connection with server
      await Future.delayed(Duration(seconds: 5));

      state = const MakeOfferSuccess();
    } catch (e) {
      state = MakeOfferError(error: e.toString());
    }
  }
}

final makeOfferControllerProvider =
    StateNotifierProvider<MakeOfferController, MakeOfferState>(
        (ref) => MakeOfferController(ref));
