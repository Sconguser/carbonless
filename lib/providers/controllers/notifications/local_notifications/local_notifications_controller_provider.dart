import 'dart:async';

import '/localization/messages.i18n.dart';
import '/main.dart';
import '/providers/states/notifications/local_notification_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalNotificationController
    extends StateNotifier<LocalNotificationState> {
  Ref ref;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  LocalNotificationController({required state, required this.ref})
      : super(state) {
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('carbon');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void startSession() async {
    // Set showNotification to true and update the notification
    state = LocalNotificationOpen(minutes: 0, seconds: 0);
    // notifyListeners();

    // Start the timer
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      LocalNotificationOpen tempState = state as LocalNotificationOpen;
      if (tempState.seconds == 60) {
        tempState.minutes++;
        tempState.seconds = 0;
      } else {
        (tempState).seconds++;
      }
      // Update the notification every second
      state = tempState;
      updateNotification(tempState);
    });
  }

  void updateNotification(LocalNotificationOpen localNotificationState) async {
    Messages _locale = ref.read(messagesProvider);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'carbonless_channel',
      'Carbonless Open Session Notification',
      channelDescription:
          'This channel displays information that travel session is open and counts time since opening of session.',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
      icon: 'carbon',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    String notificationMessage =
        '${_locale.notifications.elapsed_time}: ${localNotificationState.minutes} ${_locale.notifications.minutes} ${localNotificationState.seconds} ${_locale.notifications.seconds}';

    // Use the same notification ID to update the existing notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      _locale.notifications.session_time,
      notificationMessage,
      platformChannelSpecifics,
    );
  }

  void finishSession() async {
    // Reset the state and cancel the timer
    state = LocalNotificationClosed();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timer.cancel();
    });

    // Hide the notification
    _flutterLocalNotificationsPlugin.cancel(0);
  }
}

final localNotificationsControllerProvider =
    StateNotifierProvider<LocalNotificationController, LocalNotificationState>(
        (ref) {
  return LocalNotificationController(
      ref: ref, state: LocalNotificationClosed());
});
