import 'package:carbonless/views/edit_profile/edit_profile_view.dart';
import 'package:carbonless/views/highscores/highscores_view.dart';
import 'package:carbonless/views/history/history_view.dart';
import 'package:carbonless/views/partners/partners_view.dart';
import 'package:flutter/material.dart';

import '../../shared/carbonless_drawer/drawer_state.dart';
import '../error/error_view.dart';
import '../settings/settings_view.dart';

Widget getDrawerView(DrawerState drawerState) {
  if (drawerState == DrawerInitialState()) {
    return ErrorView();
  }
  if (drawerState == EditData()) {
    return EditProfileView();
  }
  if (drawerState == Highscores()) {
    return HighscoresView();
  }
  if (drawerState == History()) {
    return HistoryView();
  }
  if (drawerState == Partners()) {
    return PartnersView();
  }
  if (drawerState == Settings()) {
    return SettingsView();
  }
  return ErrorView();
}
