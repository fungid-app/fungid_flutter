import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:local_db/local_db.dart';

class SpeciesLocalDatabaseProvider {
  const SpeciesLocalDatabaseProvider(
    DatabaseHandler db,
  ) : _db = db;

  final DatabaseHandler _db;

  Future<Species?> getSpecies(String species) async {
    var dbSpecies = await _db.getSpecies(species);

    if (dbSpecies == null) {
      return null;
    } else {
      return _buildFromDB(dbSpecies);
    }
  }

  Future<int?> getSpeciesKey(String species) async {
    var dbSpecies = await _db.getSpecies(species);

    if (dbSpecies == null) {
      return null;
    } else {
      return dbSpecies.speciesKey;
    }
  }

  Future<Species> _buildFromDB(ClassifierSpecies dbSpecies) async {
    return Species(
      family: dbSpecies.family,
      genus: dbSpecies.genus,
      species: dbSpecies.species,
      familyKey: dbSpecies.familyKey,
      genusKey: dbSpecies.genusKey,
      speciesKey: dbSpecies.speciesKey,
      total: dbSpecies.total,
      properties: await getProperties(dbSpecies.speciesKey),
      commonNames: await getCommonNames(dbSpecies.speciesKey),
      stats: await getStats(dbSpecies.species),
      images: await getImages(dbSpecies.speciesKey),
    );
  }

  Future<List<SpeciesImage>> getImages(int speciesKey) async {
    var images = await _db.getSpeciesImages(speciesKey);
    return _buildImages(images);
  }

  List<SpeciesImage> _buildImages(List<ClassifierSpeciesImages> dbImages) {
    return dbImages
        .map((dbImg) => SpeciesImage(
              gbifid: dbImg.gbifid,
              imgid: dbImg.imgid,
              creator: dbImg.creator,
              externalUrl: dbImg.externalUrl,
              license: dbImg.license,
              rightsHolder: dbImg.rightsHolder,
            ))
        .toList();
  }

  Future<List<CommonName>> getCommonNames(int speciesKey) async {
    var names = await _db.getCommonNames(speciesKey);
    return _buildCommonNames(names);
  }

  List<CommonName> _buildCommonNames(List<ClassifierCommonName> dbCommonNames) {
    return dbCommonNames
        .map((dbCommonName) => CommonName(
              name: dbCommonName.name,
              language: dbCommonName.language,
            ))
        .toList();
  }

  Future<SpeciesStats> getStats(String species) async {
    var dbStats = await _db.getSpeciesStats(species);
    return _buildStats(dbStats);
  }

  SpeciesStats _buildStats(List<ClassifierSpeciesStat> dbStats) {
    return SpeciesStats(
      eluClass1Stats: _buildStatsList(dbStats, "elu_class1"),
      eluClass2Stats: _buildStatsList(dbStats, "elu_class2"),
      eluClass3Stats: _buildStatsList(dbStats, "elu_class3"),
      kgStats: _buildStatsList(dbStats, "kg"),
      normalizedMonthStats: _buildStatsList(dbStats, "normalizedmonth"),
      seasonStats: _buildStatsList(dbStats, "season"),
    );
  }

  List<SpeciesStat> _buildStatsList(
    List<ClassifierSpeciesStat> dbStats,
    String statName,
  ) {
    var statList = dbStats
        .where((stat) => stat.stat == statName)
        .map((dbStat) => SpeciesStat(
              value: dbStat.value,
              likelihood: dbStat.likelihood,
            ))
        .toList();
    statList.sort((a, b) => b.likelihood.compareTo(a.likelihood));
    return statList;
  }

  Future<SpeciesProperties> getProperties(int speciesKey) async {
    var dbProperties = await _db.getSpeciesProps(speciesKey);
    return _buildProperties(dbProperties);
  }

  SpeciesProperties _buildProperties(List<ClassifierSpeciesProp> dbProps) {
    return SpeciesProperties(
      capShape:
          _buildPropertiesList(dbProps, 'capshape', CapShapeOption.values),
      ecologicalType: _buildPropertiesList(
          dbProps, 'ecologicaltype', EcologicalTypeOption.values),
      howEdible:
          _buildPropertiesList(dbProps, 'howedible', HowEdibleOption.values),
      hymeniumType: _buildPropertiesList(
          dbProps, 'hymeniumtype', HymeniumTypeOption.values),
      sporePrintColor: _buildPropertiesList(
          dbProps, 'sporeprintcolor', SporePrintColorOption.values),
      stipeCharacter: _buildPropertiesList(
          dbProps, 'stipecharacter', StipeCharacterOption.values),
      whichGills:
          _buildPropertiesList(dbProps, 'whichgills', WhichGillsOption.values),
    );
  }

  List<T> _buildPropertiesList<T>(
    List<ClassifierSpeciesProp> dbProps,
    String propName,
    List<T> values,
  ) {
    return dbProps
        .where((prop) => prop.prop == propName)
        .map((dbProp) => SpeciesProperties.stringToEnum(dbProp.value, values))
        .toList();
  }
}
