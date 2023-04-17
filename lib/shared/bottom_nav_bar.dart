import 'package:carbonless/shared/carbonless_appbar.dart';
import 'package:carbonless/shared/carbonless_drawer.dart';
import 'package:carbonless/shared/widgets.dart';
import 'package:carbonless/views/carbonless_map/carbonless_map_view.dart';
import 'package:carbonless/views/scanner/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../localization/messages.i18n.dart';
import '../views/prize/prize_view.dart';
import 'carbonless_scaffold.dart';

Messages _locale = Messages();

class BottomNavigationBarView extends ConsumerWidget {
  const BottomNavigationBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _locale = ref.watch(messagesProvider);
    return DefaultScaffold(
      appBar: CarbonLessAppBar(
        context: context,
        title: LogoText(),
        showLeading: false,
      ),
      drawer: CarbonlessDrawer(),
      context: context,
      body: IndexedStack(
        index: ref.watch(bottomNavIndexProvider),
        children: [
          PrizeView(),
          ScannerView(),
          CarbonlessMapView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: ref.watch(bottomNavIndexProvider),
        onTap: (index) =>
            ref.read(bottomNavIndexProvider.notifier).state = index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.star,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.qr_code,
              size: 30,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.map_outlined,
              size: 30,
            ),
            label: 'Checkout',
          ),
        ],
      ),
    );
  }
}

final bottomNavIndexProvider = StateProvider((ref) => 0);
