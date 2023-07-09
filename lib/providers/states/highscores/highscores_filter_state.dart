import 'package:equatable/equatable.dart';

class HighscoresFilterState extends Equatable {
  HighscoresFilterState(this.name);
  String name;
  @override
  List<Object?> get props => [];
  @override
  toString() {
    return name;
  }
}

class HighscoresFilterCountry extends HighscoresFilterState {
  HighscoresFilterCountry() : super('Country');
  @override
  List<Object?> get props => [];
}

class HighscoresFilterNeighbourhood extends HighscoresFilterState {
  HighscoresFilterNeighbourhood() : super('Neighbourhood');
  @override
  List<Object?> get props => [];
}

class HighscoresFilterCity extends HighscoresFilterState {
  HighscoresFilterCity() : super('City');
  @override
  List<Object?> get props => [];
}
