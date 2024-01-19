import '/main.dart';
import '/shared/carbonless_drawer/drawer_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

enum DRAWER_TILES {
  EDIT_DATA,
  MY_OFFERS,
  MY_REQUESTS,
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
            icon: const Icon(Icons.local_offer_outlined),
            text: _locale.drawer.my_offers,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.MY_OFFERS, context);
            },
          ),
          DrawerButton(
            icon: const Icon(Icons.request_quote_outlined),
            text: _locale.drawer.my_requests,
            onPressed: () {
              handleButtonPress(ref, DRAWER_TILES.MY_REQUESTS, context);
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
  var drawerController = ref.read(drawerControllerProvider.notifier);
  switch (tile) {
    case DRAWER_TILES.EDIT_DATA:
      drawerController.showEditDataView();
      break;
    case DRAWER_TILES.HIGHSCORES:
      drawerController.showHighscores();
      break;
    case DRAWER_TILES.HISTORY:
      drawerController.showHistory();
      break;
    case DRAWER_TILES.PARTNERS:
      drawerController.showPartners();
      break;
    case DRAWER_TILES.SETTINGS:
      drawerController.showSettings();
      break;
    case DRAWER_TILES.ABOUT:
      drawerController.showAbout();
      break;
    case DRAWER_TILES.LOGOUT:
      drawerController.logout();
      return;
    case DRAWER_TILES.MY_OFFERS:
      drawerController.showMyOffers();
      break;
    case DRAWER_TILES.MY_REQUESTS:
      drawerController.showMyRequests();
      break;
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
