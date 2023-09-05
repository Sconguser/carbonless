import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'widgets.dart';
import '../../providers/controllers/qr_scanner_controller_provider.dart';
import '../../providers/states/qr_scanner_state.dart';
import 'barcode_scanner_window.dart';

class ScannerView extends ConsumerWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(qrScannerControllerProvider);
    return Container(
      child: Center(
        child: viewState is QrScannerStateInitial
            ? BarcodeScannerWithScanWindow()
            : QrSendConfirmationWindow(),
      ),
    );
  }
}
