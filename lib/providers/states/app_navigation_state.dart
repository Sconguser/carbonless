import 'package:equatable/equatable.dart';

enum MainView { Exchange, Scanner }

class AppNavigationState extends Equatable {
  const AppNavigationState();
  @override
  List<Object?> get props => [];
}

class AppNavigationMain extends AppNavigationState {
  MainView view;
  AppNavigationMain({required this.view});
  @override
  List<Object?> get props => [];
}

class AppNavigationAuxiliary extends AppNavigationState {
  const AppNavigationAuxiliary();
  @override
  List<Object?> get props => [];
}
