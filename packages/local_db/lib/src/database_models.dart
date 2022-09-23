import 'package:equatable/equatable.dart';

class ClassifierSpecies extends Equatable {
  final String family;
  final String genus;
  final String species;
  final int familyKey;
  final int genusKey;
  final int speciesKey;
  final int total;

  const ClassifierSpecies({
    required this.family,
    required this.genus,
    required this.species,
    required this.familyKey,
    required this.genusKey,
    required this.speciesKey,
    required this.total,
  });

  @override
  List<Object?> get props => [
        family,
        genus,
        species,
        familyKey,
        genusKey,
        total,
      ];

  static ClassifierSpecies fromMap(Map<String, Object?> e) {
    return ClassifierSpecies(
      family: e['family'] as String,
      genus: e['genus'] as String,
      species: e['species'] as String,
      familyKey: e['familykey'] as int,
      genusKey: e['genuskey'] as int,
      speciesKey: e['specieskey'] as int,
      total: e['total'] as int,
    );
  }
}

class ClassifierEluValues extends Equatable {
  final int eluid;
  final String class1;
  final String class2;
  final String class3;

  const ClassifierEluValues({
    required this.eluid,
    required this.class1,
    required this.class2,
    required this.class3,
  });

  @override
  List<Object?> get props => [
        eluid,
        class1,
        class2,
        class3,
      ];

  static ClassifierEluValues fromMap(Map<String, Object?> e) {
    return ClassifierEluValues(
      eluid: e['eluid'] as int,
      class1: e['class1'] as String,
      class2: e['class2'] as String,
      class3: e['class3'] as String,
    );
  }
}

class ClassifierSpeciesImages extends Equatable {
  final int specieskey;
  final int gbifid;
  final int imgid;
  final String externalUrl;
  final String rightsHolder;
  final String creator;
  final String license;

  const ClassifierSpeciesImages({
    required this.specieskey,
    required this.gbifid,
    required this.imgid,
    required this.externalUrl,
    required this.rightsHolder,
    required this.creator,
    required this.license,
  });

  @override
  List<Object?> get props => [
        specieskey,
        gbifid,
        imgid,
        externalUrl,
        rightsHolder,
        creator,
        license,
      ];

  static ClassifierSpeciesImages fromMap(Map<String, Object?> e) {
    return ClassifierSpeciesImages(
      specieskey: e['specieskey'] as int,
      gbifid: e['gbifid'] as int,
      imgid: e['imgid'] as int,
      externalUrl: e['external_url'] as String,
      rightsHolder: e['rights_holder'] as String,
      creator: e['creator'] as String,
      license: e['license'] as String,
    );
  }
}

class ClassifierSpeciesStat extends Equatable {
  final String species;
  final String stat;
  final String value;
  final double likelihood;

  const ClassifierSpeciesStat({
    required this.species,
    required this.stat,
    required this.value,
    required this.likelihood,
  });

  @override
  List<Object?> get props => [
        species,
        stat,
        value,
        likelihood,
      ];

  static ClassifierSpeciesStat fromMap(Map<String, Object?> e) {
    return ClassifierSpeciesStat(
      species: e['species'] as String,
      stat: e['stat'] as String,
      value: e['value'] as String? ?? '',
      likelihood: e['likelihood'] as double,
    );
  }
}

class ClassifierCommonName extends Equatable {
  final int specieskey;
  final String name;
  final String language;

  const ClassifierCommonName({
    required this.specieskey,
    required this.name,
    required this.language,
  });

  @override
  List<Object?> get props => [
        specieskey,
        name,
        language,
      ];

  static ClassifierCommonName fromMap(Map<String, Object?> e) {
    return ClassifierCommonName(
      specieskey: e['specieskey'] as int,
      name: e['name'] as String,
      language: e['lang'] as String,
    );
  }
}

class ClassifierSpeciesProp extends Equatable {
  final int specieskey;
  final String prop;
  final String value;
  final String datasource;

  const ClassifierSpeciesProp({
    required this.specieskey,
    required this.prop,
    required this.value,
    required this.datasource,
  });

  @override
  List<Object?> get props => [
        specieskey,
        prop,
        value,
        datasource,
      ];

  static ClassifierSpeciesProp fromMap(Map<String, Object?> e) {
    return ClassifierSpeciesProp(
      specieskey: e['specieskey'] as int,
      prop: e['prop'] as String,
      value: e['value'] as String,
      datasource: e['datasource'] as String,
    );
  }
}
