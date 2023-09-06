import 'package:flutter/material.dart';

import '../../shared/carbonless_drawer/drawer_state.dart';
import '../about/about_view.dart';
import '../edit_profile/edit_profile_view.dart';
import '../error/error_view.dart';

import '../settings/settings_view.dart';

Widget getDrawerView(DrawerState drawerState) {
  if (drawerState == const DrawerInitialState()) {
    return const ErrorView();
  }
  if (drawerState == const EditData()) {
    return EditProfileView();
  }
  if (drawerState == const Settings()) {
    return const SettingsView();
  }
  if (drawerState == const About()) {
    return const AboutView();
  }
  return const ErrorView();
}
