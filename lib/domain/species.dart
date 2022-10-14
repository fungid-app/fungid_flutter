import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'species.g.dart';

class CommonName {
  final String name;
  final String language;

  CommonName({
    required this.name,
    required this.language,
  });
}

@JsonSerializable()
class SpeciesImage {
  final int gbifid;
  final int imgid;
  final String rightsHolder;
  final String creator;
  final int license;

  SpeciesImage({
    required this.gbifid,
    required this.imgid,
    required this.rightsHolder,
    required this.creator,
    required this.license,
  });

  get fungidUrl =>
      // Home URL
      // 'https://api.fungid.app/images/observations/$gbifid-$imgid.jpg';
      // DO Spaces URL
      'https://images.fungid.app/fungid/app-images/$gbifid-$imgid.jpg';

  factory SpeciesImage.fromJson(Map<String, dynamic> json) =>
      _$SpeciesImageFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesImageToJson(this);
}

class SpeciesStat {
  final String value;
  final double likelihood;

  SpeciesStat({
    required this.value,
    required this.likelihood,
  });
}

class SpeciesStats {
  final List<SpeciesStat> eluClass1Stats;
  final List<SpeciesStat> eluClass2Stats;
  final List<SpeciesStat> eluClass3Stats;
  final List<SpeciesStat> kgStats;
  final List<SpeciesStat> normalizedMonthStats;
  final List<SpeciesStat> seasonStats;

  SpeciesStats({
    required this.eluClass1Stats,
    required this.eluClass2Stats,
    required this.eluClass3Stats,
    required this.kgStats,
    required this.normalizedMonthStats,
    required this.seasonStats,
  });
}

class Species {
  final String family;
  final String genus;
  final String species;
  final int familyKey;
  final int genusKey;
  final int speciesKey;
  final int total;
  final List<SpeciesImage> images;
  final List<CommonName> commonNames;
  final SpeciesStats stats;
  final SpeciesProperties properties;
  final List<BasicPrediction> similarSpecies;

  Species({
    required this.family,
    required this.genus,
    required this.species,
    required this.familyKey,
    required this.genusKey,
    required this.speciesKey,
    required this.total,
    required this.images,
    required this.commonNames,
    required this.stats,
    required this.properties,
    required this.similarSpecies,
  });
}
