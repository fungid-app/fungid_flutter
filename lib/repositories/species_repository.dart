import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/providers/species_local_database_provider.dart';

class SpeciesRepository {
  const SpeciesRepository({
    required SpeciesLocalDatabaseProvider speciesProvider,
  }) : _speciesProvider = speciesProvider;

  final SpeciesLocalDatabaseProvider _speciesProvider;

  Future<Species?> getSpecies(String species) async {
    return await _speciesProvider.getSpecies(species);
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

  Future<List<SimilarSpecies>> getSimilarSpecies(int speciesKey) async {
    return await _speciesProvider.getSimilarSpecies(speciesKey);
  }
}
