import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'domain.g.dart';

const maxImages = 10;
const maxImageSize = 1000;

UserObservation initializeObservation() {
  return UserObservation(
    images: const [],
    location: const ObservationLocation(
      lat: 0.0,
      lng: 0.0,
      placeName: "",
    ),
    id: const Uuid().v4(),
    dateCreated: DateTime.now().toUtc(),
  );
}

UserObservation addImageToObservation(
  UserObservation obs,
  String imagePath,
) {
  // Image? image = resizeFromFile(imagePath, maxImageSize);

  // if (image == null) return obs;

  obs.images.add(UserObservationImage(
    filename: imagePath,
    id: const Uuid().v4(),
  ));

  return obs;
}

UserObservation removeImageFromObservation(
  UserObservation obs,
  String imageID,
) {
  try {
    UserObservationImage? image =
        obs.images.firstWhere((element) => element.id == imageID);

    obs.images.remove(image);
  } catch (e) {
    if (e is! StateError) {
      rethrow;
    }
  }

  return obs;
}

@JsonSerializable()
class UserObservation extends Equatable {
  final ObservationLocation location;
  final String id;
  final DateTime dateCreated;
  final DateTime lastUpdated;
  final List<UserObservationImage> images;
  final Predictions? predictions;

  UserObservation({
    required this.location,
    required this.images,
    required this.id,
    required this.dateCreated,
    this.predictions,
  }) : lastUpdated = DateTime.now().toUtc();

  @override
  List<Object?> get props => [
        id,
        location,
        dateCreated,
        images,
        predictions,
      ];

  static List<UserObservation> observations = [];
  factory UserObservation.fromJson(Map<String, dynamic> json) =>
      _$UserObservationFromJson(json);

  DateTime localDate() => dateCreated.toLocal();
  String dayCreated() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateCreated);
  }

  Map<String, dynamic> toJson() => _$UserObservationToJson(this);

  UserObservation copyWith({
    ObservationLocation? location,
    String? id,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    List<UserObservationImage>? images,
    Predictions? predictions,
  }) {
    return UserObservation(
      location: location ?? this.location,
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      images: images ?? this.images,
      predictions: predictions ?? this.predictions,
    );
  }
}

@JsonSerializable()
class Predictions extends Equatable {
  final List<Prediction> predictions;
  final DateTime dateCreated;

  const Predictions({
    required this.predictions,
    required this.dateCreated,
  });

  @override
  List<Object?> get props => [predictions, dateCreated];

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable()
class ObservationLocation extends Equatable {
  final double lat;
  final double lng;
  final String placeName;

  const ObservationLocation({
    required this.lat,
    required this.lng,
    required this.placeName,
  });

  @override
  List<Object?> get props => [lat, lng];

  factory ObservationLocation.fromJson(Map<String, dynamic> json) =>
      _$ObservationLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ObservationLocationToJson(this);
}

@JsonSerializable()
class Prediction extends Equatable {
  final String species;
  final double probability;

  const Prediction({
    required this.species,
    required this.probability,
  });

  String displayProbabilty() {
    return "${(probability * 100).toStringAsFixed(4)}%";
  }

  @override
  List<Object?> get props => [species, probability];

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}

@JsonSerializable()
class UserObservationImage extends Equatable {
  final String id;
  final String filename;
  final DateTime dateCreated;

  File getFile() => File(filename);

  UserObservationImage({
    required this.filename,
    required this.id,
    DateTime? dateCreated,
  }) : dateCreated = dateCreated ?? DateTime.now().toUtc();

  @override
  List<Object?> get props => [id, filename, dateCreated];

  factory UserObservationImage.fromJson(Map<String, dynamic> json) =>
      _$UserObservationImageFromJson(json);

  Map<String, dynamic> toJson() => _$UserObservationImageToJson(this);

  UserObservationImage copyWith({
    String? id,
    String? filename,
    DateTime? dateCreated,
  }) {
    return UserObservationImage(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}

@JsonSerializable()
class Species extends Equatable {
  final String id;
  final String phylum;
  final String classname;
  final String order;
  final String family;
  final String genus;
  final String species;
  final String description;
  final bool includedInClassifier;
  final int numberOfObservations;

  const Species({
    required this.id,
    required this.phylum,
    required this.classname,
    required this.order,
    required this.family,
    required this.genus,
    required this.species,
    required this.description,
    required this.includedInClassifier,
    required this.numberOfObservations,
  });

  @override
  List<Object?> get props => [id, species];

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesToJson(this);
}
