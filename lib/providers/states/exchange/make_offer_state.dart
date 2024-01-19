import 'package:equatable/equatable.dart';

class MakeRequestState extends Equatable {
  const MakeRequestState();
  @override
  List<Object?> get props => [];
}

class MakeRequestStateInitial extends MakeRequestState {
  const MakeRequestStateInitial();
  @override
  List<Object?> get props => [];
}

class MakeRequestLoading extends MakeRequestState {
  const MakeRequestLoading();
  @override
  List<Object?> get props => [];
}

class MakeRequestSuccess extends MakeRequestState {
  const MakeRequestSuccess();
  @override
  List<Object?> get props => [];
}

class MakeRequestError extends MakeRequestState {
  final String error;
  const MakeRequestError({required this.error});
  @override
  List<Object?> get props => [];
}
