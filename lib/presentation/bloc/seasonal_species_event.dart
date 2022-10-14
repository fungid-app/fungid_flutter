part of 'seasonal_species_bloc.dart';

abstract class SeasonalSpeciesEvent extends Equatable {
  const SeasonalSpeciesEvent();

  @override
  List<Object> get props => [];
}

class SeasonalSpeciesLoad extends SeasonalSpeciesEvent {
  final DateTime date;

  const SeasonalSpeciesLoad({
    required this.date,
  });

  @override
  List<Object> get props => [
        date,
      ];
}
