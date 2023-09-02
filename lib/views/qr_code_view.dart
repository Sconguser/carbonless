import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeView extends StatelessWidget {
  String value;
  QrCodeView({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: QrImage(
        data: value,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
