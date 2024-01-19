import 'package:carbonless_free/views/exchange/requests/my_requests/my_requests_list_view.dart';

import '../exchange/offers/offer_list/my_offers_list/my_offers_list_view.dart';
import '/views/about/about_view.dart';
import '/views/edit_profile/edit_profile_view.dart';
import '/views/highscores/highscores_view.dart';
import '/views/history/history_view.dart';
import '/views/partners/partners_view.dart';
import 'package:flutter/material.dart';

import '../../shared/carbonless_drawer/drawer_state.dart';
import '../error/error_view.dart';
import '../settings/settings_view.dart';

Widget getDrawerView(DrawerState drawerState) {
  if (drawerState == const DrawerInitialState()) {
    return const ErrorView();
  }
  if (drawerState == const EditData()) {
    return EditProfileView();
  }
  if (drawerState == const Highscores()) {
    return const HighscoresView();
  }
  if (drawerState == const History()) {
    return const HistoryView();
  }
  if (drawerState == const Partners()) {
    return const PartnersView();
  }
  if (drawerState == const Settings()) {
    return const SettingsView();
  }
  if (drawerState == const About()) {
    return const AboutView();
  }
  if (drawerState == const MyOffers()) {
    return const MyOffersListView();
  }
  if (drawerState == const MyRequests()) {
    return const MyRequestsListView();
  }
  return const ErrorView();
}
