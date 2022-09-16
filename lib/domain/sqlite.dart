import 'package:equatable/equatable.dart';

class ClassifierSpecies extends Equatable {
  final String family;
  final String genus;
  final String species;
  final String familyKey;
  final String genusKey;
  final String total;

  const ClassifierSpecies({
    required this.family,
    required this.genus,
    required this.species,
    required this.familyKey,
    required this.genusKey,
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

  Map<String, dynamic> toMap() {
    return {
      'family': family,
      'genus': genus,
      'species': species,
      'familyKey': familyKey,
      'genusKey': genusKey,
      'total': total,
    };
  }

  static fromMap(Map<String, Object?> e) {
    return ClassifierSpecies(
      family: e['family'] as String,
      genus: e['genus'] as String,
      species: e['species'] as String,
      familyKey: e['familyKey'] as String,
      genusKey: e['genusKey'] as String,
      total: e['total'] as String,
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

  Map<String, dynamic> toMap() {
    return {
      'eluid': eluid,
      'class1': class1,
      'class2': class2,
      'class3': class3,
    };
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

  Map<String, dynamic> toMap() {
    return {
      'specieskey': specieskey,
      'gbifid': gbifid,
      'imgid': imgid,
      'externalUrl': externalUrl,
      'rightsHolder': rightsHolder,
      'creator': creator,
      'license': license,
    };
  }
}

class ClassifierSpeciesStats extends Equatable {
  final int specieskey;
  final String stat;
  final String value;
  final double likelihood;

  const ClassifierSpeciesStats({
    required this.specieskey,
    required this.stat,
    required this.value,
    required this.likelihood,
  });

  @override
  List<Object?> get props => [
        specieskey,
        stat,
        value,
        likelihood,
      ];

  Map<String, dynamic> toMap() {
    return {
      'specieskey': specieskey,
      'stat': stat,
      'value': value,
      'likelihood': likelihood,
    };
  }
}

class CommonNames extends Equatable {
  final int specieskey;
  final String name;
  final String language;

  const CommonNames({
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
}
