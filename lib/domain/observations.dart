import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'observations.g.dart';

const maxImages = 10;
const maxImageSize = 1000;

UserObservation addImageToObservation(
  UserObservation obs,
  String imagePath,
) {
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
  final DateTime observationDate;
  final DateTime lastUpdated;
  final List<UserObservationImage> images;

  const UserObservation({
    required this.location,
    required this.images,
    required this.id,
    required this.dateCreated,
    required this.observationDate,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        id,
        location,
        dateCreated,
        observationDate,
        images,
        lastUpdated,
      ];

  static List<UserObservation> observations = [];
  factory UserObservation.fromJson(Map<String, dynamic> json) =>
      _$UserObservationFromJson(json);

  DateTime localDate() => observationDate.toLocal();
  String dayObserved() {
    return DateFormat.yMMMd().format(observationDate);
  }

  Map<String, dynamic> toJson() => _$UserObservationToJson(this);

  UserObservation copyWith({
    ObservationLocation? location,
    String? id,
    DateTime? dateCreated,
    DateTime? observationDate,
    List<UserObservationImage>? images,
    DateTime? lastUpdated,
  }) {
    return UserObservation(
      location: location ?? this.location,
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      observationDate: observationDate ?? this.observationDate,
      images: images ?? this.images,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
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
  List<Object?> get props => [
        lat,
        lng,
      ];

  get latLngDisplay =>
      '${lat.toStringAsPrecision(7)}, ${lng.toStringAsPrecision(7)}';

  factory ObservationLocation.fromJson(Map<String, dynamic> json) =>
      _$ObservationLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ObservationLocationToJson(this);
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
  List<Object?> get props => [
        id,
        filename,
        dateCreated,
      ];

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
