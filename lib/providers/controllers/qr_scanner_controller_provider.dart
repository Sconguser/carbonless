import 'package:carbonless/localization/messages.i18n.dart';
import 'package:carbonless/providers/states/qr_scanner_state.dart';
import 'package:carbonless/services/qr_code_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../models/qr_model.dart';

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController(this.ref) : super(const QrScannerStateInitial());
  final Ref ref;

  void sendQr(QRDTO qrdto) async {
    state = const QrScannerStateBusy();
    Messages _locale = ref.watch(messagesProvider);
    try {
      await ref.read(qrService).sendQr(qrdto);
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
