import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:fungid_flutter/providers/species_local_database_provider.dart';

class SpeciesRepository {
  const SpeciesRepository({
    required SpeciesLocalDatabaseProvider speciesProvider,
  }) : _speciesProvider = speciesProvider;

  final SpeciesLocalDatabaseProvider _speciesProvider;

  Future<Species?> getSpecies(String species) async {
    return await _speciesProvider.getSpecies(species);
  }

  Future<Map<String, Species>> getSpeciesMap({
    required List<String> species,
  }) async {
    final speciesMap = <String, Species>{};

    for (final s in species) {
      final sp = await getSpecies(s);
      if (sp != null) {
        speciesMap[s] = sp;
      }
    }

    return speciesMap;
  }

  Future<SpeciesProperties?> getProperties(String species) async {
    int? key = await _speciesProvider.getSpeciesKey(species);

    if (key == null) {
      return null;
    } else {
      return await _speciesProvider.getProperties(key);
    }
  }
}
