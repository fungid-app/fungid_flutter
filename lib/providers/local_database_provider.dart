import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:local_db/local_db.dart';

final Map<String, String> kgNames = {
  "1": "Tropical, rainforest",
  "2": "Tropical, monsoon",
  "3": "Tropical, savannah",
  "4": "Arid, desert, hot",
  "5": "Arid, desert, cold",
  "6": "Arid, steppe, hot",
  "7": "Arid, steppe, cold",
  "8": "Temperate, dry summer, hot summer",
  "9": "Temperate, dry summer, warm summer",
  "10": "Temperate, dry summer, cold summer",
  "11": "Temperate, dry winter, hot summer",
  "12": "Temperate, dry winter, warm summer",
  "13": "Temperate, dry winter, cold summer",
  "14": "Temperate, no dry season, hot summer",
  "15": "Temperate, no dry season, warm summer",
  "16": "Temperate, no dry season, cold summer",
  "17": "Cold, dry summer, hot summer",
  "18": "Cold, dry summer, warm summer",
  "19": "Cold, dry summer, cold summer",
  "20": "Cold, dry summer, very cold winter",
  "21": "Cold, dry winter, hot summer",
  "22": "Cold, dry winter, warm summer",
  "23": "Cold, dry winter, cold summer",
  "24": "Cold, dry winter, very cold winter",
  "25": "Cold, no dry season, hot summer",
  "26": "Cold, no dry season, warm summer",
  "27": "Cold, no dry season, cold summer",
  "28": "Cold, no dry season, very cold winter",
  "29": "Polar, tundra",
  "30": "Polar, frost",
};

class LocalDatabaseProvider {
  LocalDatabaseProvider(
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

  Future<List<BasicPrediction>> getObservationCounts() async {
    var counts = await _db.getObservationCounts();

    if (counts.isEmpty) {
      return [];
    }

    double topCount = counts[7].value.toDouble();

    return counts
        .map(
          (e) => BasicPrediction(
            specieskey: e.key,
            probability:
                e.value > topCount ? 1.0 : e.value.toDouble() / topCount,
          ),
        )
        .toList();
  }

  Future<SimpleSpecies?> getSimpleSpecies(int specieskey) async {
    var dbSpecies = await _db.getSpeciesByKey(specieskey);

    if (dbSpecies == null) {
      return null;
    } else {
      return SimpleSpecies(
        family: dbSpecies.family,
        genus: dbSpecies.genus,
        species: dbSpecies.species,
        familyKey: dbSpecies.familyKey,
        genusKey: dbSpecies.genusKey,
        speciesKey: dbSpecies.speciesKey,
        total: dbSpecies.total,
        properties: await getProperties(dbSpecies.speciesKey),
        commonName: await getCommonName(dbSpecies.speciesKey),
        image: await getImage(dbSpecies.speciesKey),
      );
    }
  }

  Future<String?> getSpeciesName(int speciesKey) async {
    var dbSpecies = await _db.getSpeciesByKey(speciesKey);

    return dbSpecies?.species;
  }

  Future<Species?> getSpeciesByKey(int specieskey) async {
    var dbSpecies = await _db.getSpeciesByKey(specieskey);

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
      stats: await getStats(dbSpecies.speciesKey),
      images: await getImages(dbSpecies.speciesKey),
      similarSpecies: await getSimilarSpecies(dbSpecies.speciesKey),
    );
  }

  Future<List<BasicPrediction>> getSimilarSpecies(int speciesKey) async {
    var similarSpecies = await _db.getSimilarSpecies(speciesKey);

    // var maxScore = similarSpecies.map((e) => e.similarity).reduce(max);
    var maxScore = .005;
    var similar = await Future.wait(similarSpecies.map((e) async {
      return BasicPrediction(
        probability: e.similarity > maxScore ? 1.0 : e.similarity / maxScore,
        specieskey: e.similarSpecieskey,
      );
    }).toList());

    similar.sort((a, b) => b.probability.compareTo(a.probability));

    return similar;
  }

  Future<List<SpeciesImage>> getImages(int speciesKey) async {
    var images = await _db.getSpeciesImages(speciesKey);
    return _buildImages(images);
  }

  Future<SpeciesImage?> getImage(int speciesKey) async {
    var image = await _db.getSpeciesImage(speciesKey);
    return image == null ? null : _buildImage(image);
  }

  List<SpeciesImage> _buildImages(List<ClassifierSpeciesImages> dbImages) {
    return dbImages
        .map(
          (dbImg) => _buildImage(dbImg),
        )
        .toList();
  }

  SpeciesImage _buildImage(ClassifierSpeciesImages dbImg) {
    return SpeciesImage(
      gbifid: dbImg.gbifid,
      imgid: dbImg.imgid,
      creator: dbImg.creator,
      license: dbImg.license,
      rightsHolder: dbImg.rightsHolder,
    );
  }

  Future<List<CommonName>> getCommonNames(int speciesKey) async {
    var names = await _db.getCommonNames(speciesKey);
    return _buildCommonNames(names);
  }

  Future<CommonName?> getCommonName(int speciesKey) async {
    var names = await _db.getCommonNames(speciesKey);
    return names.isEmpty
        ? null
        : CommonName(
            name: names.first.name,
            language: names.first.language,
          );
  }

  List<CommonName> _buildCommonNames(List<ClassifierCommonName> dbCommonNames) {
    return dbCommonNames
        .map((dbCommonName) => CommonName(
              name: dbCommonName.name,
              language: dbCommonName.language,
            ))
        .toList();
  }

  Future<SpeciesStats> getStats(int specieskey) async {
    var dbStats = await _db.getSpeciesStats(specieskey);
    return _buildStats(dbStats);
  }

  SpeciesStats _buildStats(List<ClassifierSpeciesStat> dbStats) {
    return SpeciesStats(
      eluClass1Stats: _buildStatsList(dbStats, "elu_class1"),
      eluClass2Stats: _buildStatsList(dbStats, "elu_class2"),
      eluClass3Stats: _buildStatsList(dbStats, "elu_class3"),
      kgStats: _buildStatsList(dbStats, "kg")
          .map(
            (e) => SpeciesStat(
              value: kgNames[e.value] ?? e.value,
              likelihood: e.likelihood,
            ),
          )
          .toList(),
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
      capShape: _buildPropertiesList(dbProps, 'capshape', CapShape.values),
      ecologicalType: _buildPropertiesList(
          dbProps, 'ecologicaltype', EcologicalType.values),
      howEdible: _buildPropertiesList(dbProps, 'howedible', HowEdible.values),
      hymeniumType:
          _buildPropertiesList(dbProps, 'hymeniumtype', HymeniumType.values),
      sporePrintColor: _buildPropertiesList(
          dbProps, 'sporeprintcolor', SporePrintColor.values),
      stipeCharacter: _buildPropertiesList(
          dbProps, 'stipecharacter', StipeCharacter.values),
      whichGills:
          _buildPropertiesList(dbProps, 'whichgills', WhichGills.values),
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

  Set<int>? _edibileSpeciesKeys;
  Future<Set<int>> getEdibleSpeciesKeys() async {
    if (_edibileSpeciesKeys == null) {
      var dbSpecies = await _db.getEdibleSpeciesKeys();
      _edibileSpeciesKeys = dbSpecies.toSet();
    }

    return _edibileSpeciesKeys!;
  }

  Set<int>? poisonousSpeciesKeys;
  Future<Set<int>> getPoisonousSpeciesKeys() async {
    if (poisonousSpeciesKeys == null) {
      var dbSpecies = await _db.getPoisonousSpeciesKeys();
      poisonousSpeciesKeys = dbSpecies.toSet();
    }

    return poisonousSpeciesKeys!;
  }

  Future<Set<int>> searchSpecies(String query) async {
    var dbSpecies =
        await _db.searchCommonNames(query) + await _db.searchSpecies(query);
    return dbSpecies.toSet();
  }
}
