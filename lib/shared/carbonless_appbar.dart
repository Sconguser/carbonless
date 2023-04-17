import 'package:flutter/material.dart';

class CarbonLessAppBar extends StatelessWidget with PreferredSizeWidget {
  final BuildContext context;
  final Widget title;
  final String? subtitle;
  final bool showLeading;
  const CarbonLessAppBar({
    required this.context,
    required this.title,
    this.subtitle,
    required this.showLeading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: title,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
