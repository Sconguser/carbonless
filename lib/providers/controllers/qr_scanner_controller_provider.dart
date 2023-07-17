import 'package:carbonless/auth/auth_repository.dart';
import 'package:carbonless/localization/messages.i18n.dart';
import 'package:carbonless/providers/controllers/geolocation/geolocation_controller_provider.dart';
import 'package:carbonless/providers/controllers/travel_session_controller_provider/travel_session_controller_provider.dart';
import 'package:carbonless/providers/states/qr_scanner_state.dart';
import 'package:carbonless/providers/states/travel_session_state.dart';
import 'package:carbonless/services/qr_code_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../models/qr_model.dart';
import 'package:http/http.dart' as http;

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController(this.ref) : super(const QrScannerStateInitial());
  final Ref ref;

  void sendQr(String uuid, String expires) async {
    state = const QrScannerStateBusy();
    await ref.read(geolocationProvider.notifier).getCurrentPosition();
    String longitude = ref.read(geolocationProvider).longitude;
    String latitude = ref.read(geolocationProvider).latitude;
    // latitude = '51.763774';
    // longitude = '19.447215';
    QRDTO qrdto = QRDTO(
        uuid: 'ba633a78-09a1-4a3d-bc2f-14ccca8f91d0',
        expiration: expires,
        latitude: latitude,
        longitude: longitude);
    Messages _locale = ref.watch(messagesProvider);
    try {
      await Future.delayed(Duration(seconds: 3));
      String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
      if (bearerToken == null) {
        return Future.error('Bearer token is null');
      }
      TravelSessionState travelSessionState =
          ref.read(travelSessionControllerProvider);
      if (travelSessionState == const TravelSessionClosed()) {
        http.Response response = await ref
            .read(qrService)
            .sendQrPost(qrdto.toJsonStart(), bearerToken);
        if (response.statusCode == 202) {
          ref.read(travelSessionControllerProvider.notifier).openSession();
        }
      } else {
        http.Response response = await ref
            .read(qrService)
            .sendQrPatch(qrdto.toJsonEnd(), bearerToken);
        if (response.statusCode == 200) {
          ref.read(travelSessionControllerProvider.notifier).closeSession();
        }
      }
    } catch (e) {
      state = const QrScannerStateError();
    }
    state = const QrScannerStateSuccess();
  }

  void reset() {
    state = const QrScannerStateInitial();
  }
}

final qrScannerControllerProvider =
    StateNotifierProvider<QrScannerController, QrScannerState>((ref) {
  return QrScannerController(ref);
});
