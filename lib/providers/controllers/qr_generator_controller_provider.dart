import 'dart:convert';

import '../../auth/auth_repository.dart';
import '/providers/controllers/loaders/view_loading_controller_provider.dart';
import '/providers/states/qr_generator_state.dart';
import '/services/http_utils/request_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/http_utils/http_service.dart';
import 'package:http/http.dart' as http;

class QrGeneratorController extends StateNotifier<QrGeneratorState> {
  QrGeneratorController(this.ref) : super(const QrGeneratorInitialState());
  final Ref ref;
  bool _initialized = false;

  void initialize() async {
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          null,
          Endpoint.GENERATE_QR_CODE,
          ref.read(authRepositoryProvider).bearerToken,
          null,
        );
    Map<String, dynamic> data = jsonDecode(response.body);
    state = QrGeneratorShowCode(data: jsonEncode(data));
    _initialized = true;
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
  }

  void reset() {
    state = const QrGeneratorInitialState();
  }
}

final qrGeneratorControllerProvider =
    StateNotifierProvider<QrGeneratorController, QrGeneratorState>((ref) {
  return QrGeneratorController(ref);
});
