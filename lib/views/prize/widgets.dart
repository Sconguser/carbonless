import 'package:carbonless/shared/constants.dart';
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

class PrizeViewSwitch extends StatelessWidget {
  const PrizeViewSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: selectedButtonStyle,
              onPressed: () {},
              child: Text('Twoje nagrody'),
            ),
          ),
          Container(
            width: width * 0.45,
            height: height * 0.1,
            child: ElevatedButton(
              style: unselectedButtonStyle,
              onPressed: () {},
              child: Text('Nagrody do odblokowania'),
            ),
          )
        ],
      ),
    );
  }
}

final prizes = [
  PrizeTile(
    text: "Kawa",
    icon: Icon(Icons.ice_skating),
  ),
  PrizeTile(
    text: "Herbata",
    icon: Icon(Icons.temple_buddhist),
  ),
  PrizeTile(
    text: "Łyżwy",
    icon: Icon(Icons.ice_skating),
  ),
  PrizeTile(
    text: "Zoo",
    icon: Icon(Icons.light_mode_rounded),
  ),
  PrizeTile(
    text: "Metro",
    icon: Icon(Icons.train),
  ),
  PrizeTile(
    text: "Kino",
    icon: Icon(Icons.camera_alt),
  ),
];

class PrizeList extends ConsumerWidget {
  const PrizeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = <Widget>[];
    for (int i = 0; i < prizes.length; i += 2) {
      final tile1 = prizes[i];
      final tile2 = i + 1 < prizes.length ? prizes[i + 1] : null;
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
  Widget? icon;
  String text;
  bool isActive;

  PrizeTile({
    Key? key,
    this.icon,
    required this.text,
    this.isActive = false,
  }) : super(key: key);

  @override
  ConsumerState<PrizeTile> createState() => _PrizeTileState();
}

class _PrizeTileState extends ConsumerState<PrizeTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
        width: 200,
        height: _isExpanded ? 300 : 200,
        child: Card(
          color: widget.isActive ? secondaryColor : inactiveColor,
          child: Stack(
            children: [
              if (widget.icon != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: widget.icon,
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
                        child: Text(widget.text),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
