import '/providers/controllers/qr_scanner_controller_provider.dart';
import '/providers/controllers/travel_session_controller_provider/travel_session_controller_provider.dart';
import '/providers/states/travel_session_state.dart';
import '/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/states/qr_scanner_state.dart';

class QrSendConfirmationWindow extends ConsumerWidget {
  const QrSendConfirmationWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(qrScannerControllerProvider);
    return Container(
        child: viewState is QrScannerStateBusy
            ? CircularProgressIndicator()
            : ValidationWindow());
  }
}

class ValidationWindow extends ConsumerWidget {
  const ValidationWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(qrScannerControllerProvider);
    return Container(
      child: viewState is QrScannerStateSuccess ? PrizeValid() : PrizeInvalid(),
    );
  }
}

class PrizeValid extends ConsumerWidget {
  const PrizeValid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Prize is valid',
          style: logoTextStyle,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(qrScannerControllerProvider.notifier);
            ref.read(qrScannerControllerProvider.notifier).reset();
          },
          child: Text('Validate prize'),
        )
      ],
    );
  }
}

class PrizeInvalid extends ConsumerWidget {
  const PrizeInvalid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Prize is not valid',
          style: logoTextStyle,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(qrScannerControllerProvider.notifier).reset();
          },
          child: Text('Return'),
        )
      ],
    );
  }
}
