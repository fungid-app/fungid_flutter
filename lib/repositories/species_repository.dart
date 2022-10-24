import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/providers/local_database_provider.dart';

class SpeciesRepository {
  const SpeciesRepository({
    required LocalDatabaseProvider speciesProvider,
  }) : _speciesProvider = speciesProvider;

  final LocalDatabaseProvider _speciesProvider;

  Future<Species?> getSpecies(String species) async {
    return await _speciesProvider.getSpecies(species);
  }

  Future<SimpleSpecies?> getSimpleSpecies(int specieskey) async {
    return await _speciesProvider.getSimpleSpecies(specieskey);
  }

  Future<Species?> getSpeciesByKey(int specieskey) async {
    return await _speciesProvider.getSpeciesByKey(specieskey);
  }

  Future<Map<String, SpeciesImage>> getImageMap({
    required List<String> species,
  }) async {
    final imageMap = <String, SpeciesImage>{};

    for (final s in species) {
      final key = await _speciesProvider.getSpeciesKey(s);
      if (key != null) {
        final image = await _speciesProvider.getImage(key);
        if (image != null) {
          imageMap[s] = image;
        }
      }
    }

    return imageMap;
  }

  Future<List<BasicPrediction>> getSimilarSpecies(int speciesKey) async {
    var similar = await _speciesProvider.getSimilarSpecies(speciesKey);
    return await Future.wait(
      similar.map((s) async {
        return BasicPrediction(
          specieskey: s.specieskey,
          probability: s.probability,
        );
      }),
    );
  }
}
