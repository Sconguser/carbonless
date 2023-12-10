import '/providers/controllers/app_navigation_controller_provider.dart';
import '/providers/controllers/loaders/view_loading_controller_provider.dart';
import '/providers/states/loading_state.dart';
import '/shared/carbonless_appbar.dart';
import '/shared/carbonless_drawer/carbonless_drawer.dart';
import '/shared/constants.dart';
import '/shared/widgets.dart';
import '/views/carbonless_map/carbonless_map_view.dart';
import '/views/loading_view.dart';
import '/views/scanner/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../localization/messages.i18n.dart';
import '../views/prize/prize_view.dart';
import 'carbonless_scaffold.dart';

Messages _locale = Messages();

class BottomNavigationBarView extends ConsumerWidget {
  Widget? scaffoldChild;
  BottomNavigationBarView({
    Key? key,
    this.scaffoldChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _locale = ref.watch(messagesProvider);
    LoadingState viewLoadingState = ref.watch(viewLoadingControllerProvider);
    if (viewLoadingState == const LoadingOn()) {
      return const LoadingView();
    }
    return DefaultScaffold(
      appBar: CarbonLessAppBar(
        context: context,
        title: LogoText(
          color: Colors.white,
        ),
        showLeading: false,
      ),
      drawer: const CarbonlessDrawer(),
      context: context,
      body: scaffoldChild ??
          IndexedStack(
            index: ref.watch(bottomNavIndexProvider),
            children: const [
              PrizeView(),
              ScannerView(),
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: ref.watch(bottomNavIndexProvider) == -1
            ? 0
            : ref.read(bottomNavIndexProvider),
        onTap: (index) {
          ref.read(appNavigationControllerProvider.notifier).showMain();
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        selectedItemColor: ref.read(bottomNavIndexProvider) == -1
            ? unselectedIndexColor
            : selectedIndexColor,
        unselectedItemColor: unselectedIndexColor,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.star_border,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.star,
              size: 30,
            ),
            label: _locale.business.qr_generator,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.qr_code,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.qr_code_scanner,
              size: 30,
            ),
            label: _locale.bottomNavBar.scanner,
          ),
        ],
      ),
    );
  }
}

final bottomNavIndexProvider = StateProvider((ref) => 0);

enum bottomNavViewIndex {
  PRIZE,
  SCANNER,
}
