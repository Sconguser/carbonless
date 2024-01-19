import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/auth_repository.dart';
import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../states/exchange/make_offer_state.dart';
import '../../notifications/toast/toast_controller_provider.dart';

class CreateOfferController extends StateNotifier<MakeOfferState> {
  final Ref ref;
  CreateOfferController(this.ref) : super(const MakeOfferStateInitial());
  void createOffer(String title, String description, String location,
      String exchangeValue) async {
    Messages _locale = ref.read(messagesProvider);
    try {
      state = const MakeOfferLoading();
      String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
      if (bearerToken == null) {
        throw Exception(_locale.exceptions.not_authorized);
      }
      await Future.delayed(Duration(seconds: 5));
      state = const MakeOfferSuccess();
      ref.read(toastProvider).showToast(_locale.toast.message_sent);
    } catch (e) {
      state = MakeOfferError(error: e.toString());
    }
  }
}

final createOfferControllerProvider =
    StateNotifierProvider<CreateOfferController, MakeOfferState>(
        (ref) => CreateOfferController(ref));
