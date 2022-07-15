import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/utils/images.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'domain.g.dart';

const maxImages = 10;
const maxImageSize = 1000;

UserObservation initializeObservation() {
  return UserObservation(
    images: const [],
    dateCreated: DateTime.now(),
    lat: 0.0,
    lng: 0.0,
    id: const Uuid().v4(),
    lastUpdated: DateTime.now(),
  );
}

UserObservation addImageToObservation(
  UserObservation obs,
  String imagePath,
) {
  Image? image = resizeFromFile(imagePath, maxImageSize);

  if (image == null) return obs;

  obs.images.add(UserObservationImage(
    imageBytes: image.getBytes(),
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
  double lat;
  double lng;
  final String id;
  DateTime dateCreated;
  DateTime lastUpdated;
  List<UserObservationImage> images;
  Predictions? predictions;

  UserObservation({
    required this.lat,
    required this.lng,
    required this.dateCreated,
    required this.images,
    required this.id,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, lat, lng, dateCreated, images, predictions];

  static List<UserObservation> observations = [];
  factory UserObservation.fromJson(Map<String, dynamic> json) =>
      _$UserObservationFromJson(json);

  Map<String, dynamic> toJson() => _$UserObservationToJson(this);
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
class Prediction extends Equatable {
  final String species;
  final double probability;

  const Prediction({
    required this.species,
    required this.probability,
  });

  @override
  List<Object?> get props => [species, probability];

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}

class UserObservationImage extends Equatable {
  final String? id;
  final Uint8List imageBytes;

  const UserObservationImage({
    required this.imageBytes,
    required this.id,
  });

  @override
  List<Object?> get props => [id, imageBytes];

  factory UserObservationImage.fromJson(Map<String, dynamic> json) {
    return UserObservationImage(
      id: json['id'],
      imageBytes: dataFromBase64String(json['image']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': base64String(imageBytes),
      };

  // factory UserObservationImage.fromJson(Map<String, dynamic> json) =>
  //     _$UserObservationImageFromJson(json);

  // Map<String, dynamic> toJson() => _$UserObservationImageToJson(this);
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
