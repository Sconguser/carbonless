import 'package:carbonless/providers/controllers/qr_scanner_controller_provider.dart';
import 'package:carbonless/providers/controllers/travel_session_controller_provider/travel_session_controller_provider.dart';
import 'package:carbonless/providers/states/travel_session_state.dart';
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
          : getQrSendConfirmationWindow(ref),
    );
  }
}

Widget getQrSendConfirmationWindow(WidgetRef ref) {
  TravelSessionState travelSessionState =
      ref.read(travelSessionControllerProvider);
  if (travelSessionState == const TravelSessionOpen()) {
    return const SessionStarted();
  } else {
    return PointsEarned(points: 200);
  }
}

class PointsEarned extends ConsumerWidget {
  int points;
  PointsEarned({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You earned $points points!'),
          ElevatedButton(
            onPressed: () {
              ref.read(qrScannerControllerProvider.notifier).reset();
            },
            child: Text('Cool'),
          )
        ],
      ),
    );
  }
}

class SessionStarted extends ConsumerWidget {
  const SessionStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text('Session started!'),
            ElevatedButton(
              onPressed: () {
                ref.read(qrScannerControllerProvider.notifier).reset();
              },
              child: Text('Cool'),
            )
          ],
        ),
      ),
    );
  }
}
