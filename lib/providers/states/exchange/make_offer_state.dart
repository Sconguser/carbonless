import 'package:equatable/equatable.dart';

class MakeOfferState extends Equatable {
  const MakeOfferState();
  @override
  List<Object?> get props => [];
}

class MakeOfferStateInitial extends MakeOfferState {
  const MakeOfferStateInitial();
  @override
  List<Object?> get props => [];
}

class MakeOfferLoading extends MakeOfferState {
  const MakeOfferLoading();
  @override
  List<Object?> get props => [];
}

class MakeOfferSuccess extends MakeOfferState {
  const MakeOfferSuccess();
  @override
  List<Object?> get props => [];
}

class MakeOfferError extends MakeOfferState {
  final String error;
  const MakeOfferError({required this.error});
  @override
  List<Object?> get props => [];
}
