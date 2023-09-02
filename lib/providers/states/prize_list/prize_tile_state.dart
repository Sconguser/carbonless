import 'package:equatable/equatable.dart';

class PrizeTileState extends Equatable {
  int prizeId;
  PrizeTileState({required this.prizeId});
  @override
  List<Object?> get props => [];
}

class PrizeTileShowPrize extends PrizeTileState {
  PrizeTileShowPrize({required prizeId}) : super(prizeId: prizeId);
  @override
  List<Object?> get props => [];
}

class PrizeTileShowCode extends PrizeTileState {
  String data;
  PrizeTileShowCode({required this.data, required prizeId})
      : super(prizeId: prizeId);
  @override
  List<Object?> get props => [];
}
