import 'package:carbonless/models/prize_model.dart';
import 'package:carbonless/providers/controllers/prize_list/prize_list_filter_controller_provider.dart';
import 'package:carbonless/providers/states/prize_list/prize_filter_state.dart';
import 'package:carbonless/repositories/prize_repository.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:carbonless/views/prize/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsPlate extends ConsumerWidget {
  const PointsPlate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: double.infinity,
          color: primaryColor,
          child: Column(
            children: [
              Text(
                'Twoje punkty:',
                style: labelTextStyle,
              ),
              Text(
                '1234',
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
              child: Text('Twoje nagrody'),
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
              child: Text('Nagrody do odblokowania'),
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
    List<Prize>? prizes = filter(ref.watch(prizeRepositoryProvider).prizes,
        ref.read(prizeListFilterControllerProvider));
    ref.watch(prizeListFilterControllerProvider.notifier).addListener((state) {
      prizes = filter(prizes, state);
      setState(() {});
    });
    final rows = <Widget>[];
    if (prizes == null || prizes!.isEmpty) {
      return Center(child: Text('W tym momencie nie ma żadnych nagród'));
    }
    for (int i = 0; i < prizes!.length; i += 2) {
      final tile1 =
          DialogGestureDetector(prizeTile: PrizeTile(prize: prizes![i]));
      final tile2 = i + 1 < prizes!.length
          ? DialogGestureDetector(prizeTile: PrizeTile(prize: prizes![i + 1]))
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
      width: 200,
      height: 200,
      child: Card(
        color: widget.prize.isObtained ? secondaryColor : inactiveColor,
        child: Stack(
          children: [
            if (widget.prize.id != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(Icons.ice_skating_outlined),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.vertical(
                    //   bottom: Radius.circular(4),
                    // ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(widget.prize.text),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogGestureDetector extends StatelessWidget {
  Widget prizeTile;
  DialogGestureDetector({Key? key, required this.prizeTile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, _, __) {
              return Container(
                child: Hero(
                  tag: "prize${prizeTile.hashCode}",
                  child: prizeTile,
                ),
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
