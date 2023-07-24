import 'package:equatable/equatable.dart';

class LocalNotificationState extends Equatable {
  LocalNotificationState();
  @override
  List<Object?> get props => [];
}

class LocalNotificationOpen extends LocalNotificationState {
  int minutes;
  int seconds;
  LocalNotificationOpen({required this.minutes, required this.seconds});
  @override
  toString() {
    String formattedHours = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedHours:$formattedSeconds';
  }

  @override
  List<Object?> get props => [];
}

class LocalNotificationClosed extends LocalNotificationState {
  LocalNotificationClosed();
  @override
  List<Object?> get props => [];
}
