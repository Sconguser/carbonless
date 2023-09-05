import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../shared/carbonless_drawer/drawer_controller_provider.dart';

class AuxiliaryView extends ConsumerWidget {
  const AuxiliaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBarView(
      scaffoldChild: getDrawerView(ref.watch(drawerControllerProvider)),
    );
  }
}
