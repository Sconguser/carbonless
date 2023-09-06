import 'package:carbonless_business/views/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/qr_generator_controller_provider.dart';
import '../../providers/states/qr_generator_state.dart';

class PrizeView extends ConsumerWidget {
  const PrizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QrGeneratorState qrGeneratorState =
        ref.watch(qrGeneratorControllerProvider);
    return Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Center(
          child: qrGeneratorState is QrGeneratorShowCode
              ? QrCodeView(value: qrGeneratorState.data)
              : const Text("No qr code"),
        ));
  }
}
