import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarbonLessAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final Widget title;
  final String? subtitle;
  final bool showLeading;
  final List<Widget>? actions;
  const CarbonLessAppBar({
    required this.scaffoldKey,
    required this.context,
    required this.title,
    this.subtitle,
    required this.showLeading,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      title: title,
      automaticallyImplyLeading: true,
      actions: [
        Row(
          children: (actions ?? []) +
              [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    if (scaffoldKey.currentState != null) {
                      scaffoldKey.currentState!.openEndDrawer();
                    }
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
