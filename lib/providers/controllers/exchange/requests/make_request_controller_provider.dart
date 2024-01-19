import 'package:carbonless_free/auth/auth_repository.dart';
import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/providers/states/exchange/make_request_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../models/exchange_request_model.dart';
import '../../notifications/toast/toast_controller_provider.dart';

class MakeRequestController extends StateNotifier<MakeRequestState> {
  final Ref ref;
  MakeRequestController(this.ref) : super(const MakeRequestStateInitial());

  void sendRequest(String requestBody) async {
    Messages _locale = ref.read(messagesProvider);
    try {
      state = const MakeRequestLoading();
      String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
      if (bearerToken == null) {
        throw Exception(_locale.exceptions.not_authorized);
      }

      /// TODO: implement real connection with server
      await Future.delayed(Duration(seconds: 5));

      state = const MakeRequestSuccess();
      ref.read(toastProvider).showToast(_locale.toast.message_sent);
    } catch (e) {
      state = MakeRequestError(error: e.toString());
    }
  }
}

final makeRequestControllerProvider =
    StateNotifierProvider<MakeRequestController, MakeRequestState>(
        (ref) => MakeRequestController(ref));
