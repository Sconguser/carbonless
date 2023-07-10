import 'package:carbonless/main.dart';
import 'package:carbonless/shared/carbonless_drawer/drawer_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

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
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          DrawerButton(
            icon: Icon(Icons.person),
            text: _locale.drawer.edit_data,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).showEditDataView();
              Navigator.pop(context);
            },
          ),
          DrawerButton(
            icon: Icon(Icons.people),
            text: _locale.drawer.highscores,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).showHighscores();
              Navigator.pop(context);
            },
          ),
          DrawerButton(
            icon: Icon(Icons.watch_later),
            text: _locale.drawer.history,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).showHistory();
              Navigator.pop(context);
            },
          ),
          DrawerButton(
            icon: Icon(Icons.sports_handball),
            text: _locale.drawer.partners,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).showPartners();
              Navigator.pop(context);
            },
          ),
          DrawerButton(
            icon: Icon(Icons.settings),
            text: _locale.drawer.settings,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).showSettings();
              Navigator.pop(context);
            },
          ),
          DrawerButton(
            icon: Icon(Icons.logout),
            text: _locale.drawer.log_out,
            onPressed: () {
              ref.read(drawerControllerProvider.notifier).logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
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
