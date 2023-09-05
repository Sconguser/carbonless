import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';
import '../../shared/constants.dart';

class PartnersView extends ConsumerWidget {
  const PartnersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: standardOuterPadding,
      child: Column(
        children: [
          PartnersSearch(),
          PartnersList(),
        ],
      ),
    );
  }
}
