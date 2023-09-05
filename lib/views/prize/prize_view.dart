import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';

class PrizeView extends ConsumerWidget {
  const PrizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: PointsPlate(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: PrizeViewSwitch(),
              ),
            ],
          ),
          PrizeList(),
        ],
      ),
    );
  }
}
