import '/auth/auth_repository.dart';
import '/localization/messages.i18n.dart';
import '/providers/controllers/geolocation/geolocation_controller_provider.dart';
import '/providers/controllers/notifications/local_notifications/local_notifications_controller_provider.dart';
import '/providers/controllers/travel_session_controller_provider/travel_session_controller_provider.dart';
import '/providers/states/qr_scanner_state.dart';
import '/providers/states/travel_session_state.dart';
import '/services/http_utils/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../models/qr_model.dart';
import 'package:http/http.dart' as http;

import '../../services/http_utils/request_provider.dart';

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController(this.ref) : super(const QrScannerStateInitial());
  final Ref ref;

  void sendQrTravel(String uuid, String expires) async {
    state = const QrScannerStateBusy();
    await ref.read(geolocationProvider.notifier).getCurrentPosition();
    String longitude = ref.read(geolocationProvider).longitude;
    String latitude = ref.read(geolocationProvider).latitude;
    // latitude = '51.763774';
    // longitude = '19.447215';
    QRDTO qrdto = QRDTO(
        uuid: '0d219194-fa91-4fb9-9923-79dbe3cf1b5c',
        expiration: expires,
        latitude: latitude,
        longitude: longitude);
    Messages _locale = ref.watch(messagesProvider);
    try {
      // await Future.delayed(Duration(seconds: 3));
      String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
      if (bearerToken == null) {
        return Future.error('Bearer token is null');
      }
      TravelSessionState travelSessionState =
          ref.read(travelSessionControllerProvider);
      if (travelSessionState == const TravelSessionClosed()) {
        await openTravelSession(qrdto, bearerToken);
      } else {
        await closeTravelSession(qrdto, bearerToken);
      }
    } catch (e) {
      state = const QrScannerStateError();
    }
    state = const QrScannerStateSuccess();
  }

  Future<void> closeTravelSession(QRDTO qrdto, String bearerToken) async {
    // http.Response response =
    //     await ref.read(qrService).sendQrPatch(qrdto.toJsonEnd(), bearerToken);
    // if (response.statusCode == 200 || true) {
    if (true) {
      ref.read(travelSessionControllerProvider.notifier).closeSession();
      ref.read(localNotificationsControllerProvider.notifier).finishSession();
    } else {
      print('error');
    }
  }

  Future<void> openTravelSession(QRDTO qrdto, String bearerToken) async {
    // http.Response response =
    //     await ref.read(qrService).sendQrPost(qrdto.toJsonStart(), bearerToken);
    // if (response.statusCode == 202) {
    if (true) {
      ref.read(travelSessionControllerProvider.notifier).openSession();
      ref.read(localNotificationsControllerProvider.notifier).startSession();
    } else {
      print('error');
    }
  }

  void sendQrPurchase(String uuid, String expires) async {
    state = const QrScannerStateBusy();
    QRDTO qrdto = QRDTO(
      uuid: '0d219194-fa91-4fb9-9923-79dbe3cf1b5c',
      expiration: expires,
    );
    try {
      http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.POST,
          qrdto.toJsonPurchase(),
          null,
          Endpoint.POINTS_PURCHASE);
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
