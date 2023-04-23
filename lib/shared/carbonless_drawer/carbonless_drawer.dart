import 'package:carbonless/main.dart';
import 'package:carbonless/shared/carbonless_drawer/drawer_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

class CarbonlessDrawer extends StatelessWidget {
  const CarbonlessDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(),
            DrawerMenuItems(),
          ],
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
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(_locale.drawer.edit_data),
            onTap: () {
              ref.read(drawerControllerProvider.notifier).showEditDataView();
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(_locale.drawer.highscores),
            onTap: () {
              ref.read(drawerControllerProvider.notifier).showHighscores();
            },
          ),
          ListTile(
            leading: Icon(Icons.watch_later),
            title: Text(_locale.drawer.history),
            onTap: () {
              ref.read(drawerControllerProvider.notifier).showHistory();
            },
          ),
          ListTile(
            leading: Icon(Icons.sports_handball),
            title: Text(_locale.drawer.partners),
            onTap: () {
              ref.read(drawerControllerProvider.notifier).showPartners();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(_locale.drawer.settings),
            onTap: () {
              ref.read(drawerControllerProvider.notifier).showSettings();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(_locale.drawer.log_out),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
