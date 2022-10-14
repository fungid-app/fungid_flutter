part of 'seasonal_species_bloc.dart';

abstract class SeasonalSpeciesState extends Equatable {
  const SeasonalSpeciesState();

  @override
  List<Object> get props => [];
}

class SeasonalSpeciesInitial extends SeasonalSpeciesState {}

class SeasonalSpeciesLoading extends SeasonalSpeciesState {
  final DateTime date;

  const SeasonalSpeciesLoading({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class SeasonalSpeciesLoaded extends SeasonalSpeciesState {
  final List<BasicPrediction> predictions;

  const SeasonalSpeciesLoaded({
    required this.predictions,
  });

  @override
  List<Object> get props => [
        predictions,
      ];
}

class SeasonalSpeciesError extends SeasonalSpeciesState {
  final String message;

  const SeasonalSpeciesError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
