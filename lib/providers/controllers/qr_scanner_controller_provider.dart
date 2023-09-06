import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../../services/http_utils/http_service.dart';
import '../../services/http_utils/request_provider.dart';
import '../states/qr_scanner_state.dart';

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController(this.ref) : super(const QrScannerStateInitial());
  final Ref ref;

  void reset() {
    state = const QrScannerStateInitial();
  }

  Future<void> validatePrize(String qr_value) async {
    http.Response response = await ref
        .read(httpServiceProvider)
        .executeHttp(RequestType.GET, null, null, Endpoint.USER_PRIZES);
    Map<String, dynamic> decodedMap = jsonDecode(response.body);
  }
}

final qrScannerControllerProvider =
    StateNotifierProvider<QrScannerController, QrScannerState>((ref) {
  return QrScannerController(ref);
});
