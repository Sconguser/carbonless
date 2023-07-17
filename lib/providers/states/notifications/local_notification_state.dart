import 'package:equatable/equatable.dart';

class LocalNotificationState extends Equatable {
  LocalNotificationState();
  @override
  List<Object?> get props => [];
}

class LocalNotificationOpen extends LocalNotificationState {
  int hours;
  int seconds;
  LocalNotificationOpen({required this.hours, required this.seconds});
  @override
  toString() {
    String formattedHours = hours.toString().padLeft(2, '0');
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
