import 'dart:typed_data';

import 'package:carbonless/views/scanner/barcode_scanner_window.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BarcodeScannerWithScanWindow(),
      ),
    );
  }
}
