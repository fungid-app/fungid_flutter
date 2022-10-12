part of 'observation_image_cubit.dart';

class ObservationImageState extends Equatable {
  const ObservationImageState({
    required this.storageDirectory,
  });

  final Directory storageDirectory;

  @override
  List<Object> get props => [
        storageDirectory,
      ];
}
