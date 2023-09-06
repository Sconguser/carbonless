import 'package:equatable/equatable.dart';

class QrGeneratorState extends Equatable {
  const QrGeneratorState();
  @override
  List<Object?> get props => [];
}

class QrGeneratorInitialState extends QrGeneratorState {
  const QrGeneratorInitialState();
  @override
  List<Object?> get props => [];
}

class QrGeneratorShowCode extends QrGeneratorState {
  final String data;
  const QrGeneratorShowCode({required this.data});
  @override
  List<Object?> get props => [];
}
