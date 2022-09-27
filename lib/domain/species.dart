import 'package:fungid_flutter/domain/species_properties.dart';

class CommonName {
  final String name;
  final String language;

  CommonName({
    required this.name,
    required this.language,
  });
}

class SpeciesImage {
  final int gbifid;
  final int imgid;
  final String externalUrl;
  final String rightsHolder;
  final String creator;
  final String license;

  SpeciesImage({
    required this.gbifid,
    required this.imgid,
    required this.externalUrl,
    required this.rightsHolder,
    required this.creator,
    required this.license,
  });

  get fungidUrl =>
      'https://api.fungid.app/images/observations/$gbifid-$imgid.jpg';
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
  });
}
