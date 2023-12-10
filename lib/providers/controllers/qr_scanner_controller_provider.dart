import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../../services/http_utils/http_service.dart';
import '../../services/http_utils/request_provider.dart';
import '../states/qr_scanner_state.dart';

import '../../services/http_utils/request_provider.dart';

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController(this.ref) : super(const QrScannerStateInitial());
  final Ref ref;

  void reset() {
    state = const QrScannerStateInitial();
  }

  Future<void> validatePrize(String qr_value) async {
    state = const QrScannerStateBusy();
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
        RequestType.GET, null, null, Endpoint.USER_PRIZES, [qr_value]);
    bool isValid = jsonDecode(response.body);
    if (isValid) {
      state = const QrScannerStateSuccess();
    } else {
      state = const QrScannerStateError();
    }
  }

  Future<void> usePrize(String prizeId) async {
    state = const QrScannerStateBusy();
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
        RequestType.PUT, null, null, Endpoint.USER_PRIZES, [prizeId]);
    bool isValid = jsonDecode(response.body);
    // if (isValid) {
    //   state = const QrScannerStateSuccess();
    // } else {
    //   state = const QrScannerStateError();
    // }
  }
}

final qrScannerControllerProvider =
    StateNotifierProvider<QrScannerController, QrScannerState>((ref) {
  return QrScannerController(ref);
});
