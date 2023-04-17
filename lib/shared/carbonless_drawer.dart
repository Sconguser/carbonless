import 'package:flutter/material.dart';

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

class DrawerMenuItems extends StatelessWidget {
  const DrawerMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edytuj dane'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Rankingi'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.watch_later),
            title: Text('Historia'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.sports_handball),
            title: Text('Firmy Carbonless'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ustawienia'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Wyloguj się'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
