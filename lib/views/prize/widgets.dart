import 'package:carbonless/auth/auth_models/user_model.dart';
import 'package:carbonless/auth/auth_repository.dart';
import 'package:carbonless/main.dart';
import 'package:carbonless/models/prize_model.dart';
import 'package:carbonless/providers/controllers/prize_list/prize_list_filter_controller_provider.dart';
import 'package:carbonless/providers/states/prize_list/prize_filter_state.dart';
import 'package:carbonless/repositories/prize_repository.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:carbonless/views/prize/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../../localization/messages.i18n.dart';
import '../../providers/controllers/prize_list/prize_controller_provider.dart';

class PointsPlate extends ConsumerWidget {
  const PointsPlate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    User? user = ref.watch(authRepositoryProvider).user;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: double.infinity,
          color: primaryColor,
          child: Column(
            children: [
              Text(
                _locale.prizes.your_points,
                style: labelTextStyle,
              ),
              Text(
                user != null ? user.points.toString() : '0',
                style: labelTextStyle,
              ),
            ],
          )),
    );
  }
}

class PrizeViewSwitch extends ConsumerWidget {
  const PrizeViewSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PrizeFilterState filterState = ref.watch(prizeListFilterControllerProvider);
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: filterState == const PrizeFilterUnlocked()
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (filterState == const PrizeFilterUnlocked()) {
                  ref
                      .read(prizeListFilterControllerProvider.notifier)
                      .showAll();
                } else {
                  ref
                      .read(prizeListFilterControllerProvider.notifier)
                      .showUnlocked();
                }
              },
              child: Text(
                _locale.prizes.unlocked_prizes,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: filterState == const PrizeFilterLocked()
                  ? selectedButtonStyle
                  : unselectedButtonStyle,
              onPressed: () {
                if (filterState == const PrizeFilterLocked()) {
                  ref
                      .read(prizeListFilterControllerProvider.notifier)
                      .showAll();
                } else {
                  ref
                      .read(prizeListFilterControllerProvider.notifier)
                      .showLocked();
                }
              },
              child: Text(
                _locale.prizes.locked_prizes,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrizeList extends ConsumerStatefulWidget {
  const PrizeList({Key? key}) : super(key: key);

  @override
  ConsumerState<PrizeList> createState() => _PrizeListState();
}

class _PrizeListState extends ConsumerState<PrizeList> {
  @override
  Widget build(BuildContext context) {
    Messages _locale = ref.watch(messagesProvider);
    List<Prize>? prizes = filter(
        ref.watch(prizesProvider), ref.read(prizeListFilterControllerProvider));
    sortPrizes(prizes);
    ref.watch(prizeListFilterControllerProvider.notifier).addListener((state) {
      prizes = filter(prizes, state);
      setState(() {});
    });
    final rows = <Widget>[];
    if (prizes == null || prizes!.isEmpty) {
      return Center(child: Text(_locale.prizes.empty_prizes));
    }
    for (int i = 0; i < prizes!.length; i += 2) {
      final tile1 = DialogGestureDetector(prize: prizes![i]);
      final tile2 = i + 1 < prizes!.length
          ? DialogGestureDetector(prize: prizes![i + 1])
          : SizedBox(
              height: 200,
              width: 200,
            );
      rows.add(Row(
        children: [
          Expanded(child: tile1),
          SizedBox(width: 8), // Add some space between the PrizeTile widgets
          if (tile2 != null) Expanded(child: tile2),
        ],
      ));
    }
    return Expanded(
        // width: 200,
        // height: 300,
        child: ListView(
      children: rows,
    ));
  }

  void sortPrizes(List<Prize> prizes) {
    prizes.sort((a, b) {
      if (a.isObtained()) {
        return -1;
      } else if (b.isObtained()) {
        return 1;
      }
      return 0;
    });
  }
}

class PrizeTile extends ConsumerStatefulWidget {
  Prize prize;

  PrizeTile({
    Key? key,
    required this.prize,
  }) : super(key: key);

  @override
  ConsumerState<PrizeTile> createState() => _PrizeTileState();
}

class _PrizeTileState extends ConsumerState<PrizeTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO make this relative to screen size
      width: 200,
      height: 200,
      child: Card(
        child: Stack(
          children: [
            if (widget.prize.id != null)
              Center(
                child: Container(
                  color: primaryColor,
                  child: Image.network(
                    'https://www.zooplus.pt/magazine/wp-content/uploads/2021/04/border-collie-im-grass-1024x683-1.jpg',
                    height: 200,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: getPrizeColor(widget.prize),
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(widget.prize.title),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                //TODO: make this relative to screen size
                height: 30,
                width: 50,
                // decoration: const BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('${widget.prize.price}'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogGestureDetector extends StatelessWidget {
  Prize prize;
  DialogGestureDetector({Key? key, required this.prize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrizeTile prizeTile = PrizeTile(prize: prize);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (BuildContext context, _, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    ///TODO: make this relative to the screen size
                    height: 500,
                    width: 300,
                    child: Hero(
                      tag: "prize${prizeTile.hashCode}",
                      child: prizeTile,
                    ),
                  ),
                  prize.isObtained()
                      ? RedeemSlider(prize: prize)
                      : PurchaseButton(prize: prize),
                ],
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: TweenSequence(
                  <TweenSequenceItem<double>>[
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      weight: 1,
                    ),
                  ],
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: "prize${prizeTile.hashCode}",
        child: prizeTile,
      ),
    );
  }
}

class PurchaseButton extends ConsumerWidget {
  Prize prize;
  PurchaseButton({Key? key, required this.prize}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
      onPressed: () {
        // ref.read(prizesProvider.notifier).obtainPrize(prize.id);
      },
      child: Text(_locale.button.obtain),
    );
  }
}

class RedeemSlider extends ConsumerWidget {
  Prize prize;
  RedeemSlider({Key? key, required this.prize}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return ConfirmationSlider(
      height: 50,
      width: 250,
      backgroundColor: secondaryColor,
      backgroundColorEnd: activeColor,
      foregroundColor: primaryColor,
      stickToEnd: true,
      text: _locale.button.redeem,
      textStyle: sliderTextStyle,
      onConfirmation: () {
        // ref.read(prizesProvider.notifier).redeemPrize(prize.id);
      },
    );
  }
}
