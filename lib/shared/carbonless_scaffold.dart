import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final BuildContext context;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? drawer;
  const DefaultScaffold({
    required this.context,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    Key? key,
  }) : super(key: key);

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: drawer,
    );
  }
}
