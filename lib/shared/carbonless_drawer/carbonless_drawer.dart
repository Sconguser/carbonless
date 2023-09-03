import 'package:carbonless/main.dart';
import 'package:carbonless/shared/carbonless_drawer/drawer_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

enum DRAWER_TILES {
  EDIT_DATA,
  HIGHSCORES,
  HISTORY,
  PARTNERS,
  SETTINGS,
  ABOUT,
  LOGOUT,
}

class CarbonlessDrawer extends StatelessWidget {
  const CarbonlessDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // DrawerHeader(),
                DrawerMenuItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(
                'https://media-be.chewy.com/wp-content/uploads/2021/04/11150112/Border-Collie-1420601907-924x615.jpg'),
          ),
          Text('Piesek'),
        ],
      ),
    );
  }
}

class DrawerMenuItems extends ConsumerWidget {
  const DrawerMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.read(messagesProvider);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          DrawerButton(
            icon: const Icon(Icons.person),
            text: _locale.drawer.edit_data,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.EDIT_DATA, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.people),
            text: _locale.drawer.highscores,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.HIGHSCORES, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.watch_later),
            text: _locale.drawer.history,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.HISTORY, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.sports_handball),
            text: _locale.drawer.partners,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.PARTNERS, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.settings),
            text: _locale.drawer.settings,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.SETTINGS, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.info),
            text: _locale.drawer.about,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.ABOUT, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.logout),
            text: _locale.drawer.log_out,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.LOGOUT, context);
            },
          ),
        ],
      ),
    );
  }
}

void handleButtonPress(WidgetRef ref, DRAWER_TILES tile, BuildContext context) {
  switch (tile) {
    case DRAWER_TILES.EDIT_DATA:
      ref.read(drawerControllerProvider.notifier).showEditDataView();
      break;
    case DRAWER_TILES.HIGHSCORES:
      ref.read(drawerControllerProvider.notifier).showHighscores();
      break;
    case DRAWER_TILES.HISTORY:
      ref.read(drawerControllerProvider.notifier).showHistory();
      break;
    case DRAWER_TILES.PARTNERS:
      ref.read(drawerControllerProvider.notifier).showPartners();
      break;
    case DRAWER_TILES.SETTINGS:
      ref.read(drawerControllerProvider.notifier).showSettings();
      break;
    case DRAWER_TILES.ABOUT:
      ref.read(drawerControllerProvider.notifier).showAbout();
      break;
    case DRAWER_TILES.LOGOUT:
      ref.read(drawerControllerProvider.notifier).logout();
      return;
  }
  Navigator.pop(context);
}

class DrawerButton extends StatelessWidget {
  Icon icon;
  String text;
  VoidCallback onPressed;
  DrawerButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
        child: Row(
          children: [
            icon,
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(text),
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
