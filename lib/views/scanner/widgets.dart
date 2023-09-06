import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/qr_scanner_controller_provider.dart';
import '../../providers/states/qr_scanner_state.dart';
import '../../providers/states/travel_session_state.dart';

class QrSendConfirmationWindow extends ConsumerWidget {
  const QrSendConfirmationWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(qrScannerControllerProvider);
    return Container(
      child: viewState is QrScannerStateBusy
          ? CircularProgressIndicator()
          : Center(
              child: Text('meh'),
            ),
    );
  }
}
