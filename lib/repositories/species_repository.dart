import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/domain/wikipedia.dart';
import 'package:fungid_flutter/providers/local_database_provider.dart';
import 'package:fungid_flutter/providers/wikipedia_article_provider.dart';

class SpeciesRepository {
  const SpeciesRepository({
    required LocalDatabaseProvider speciesProvider,
    required WikipediaArticleProvider wikipediaProvider,
  })  : _speciesProvider = speciesProvider,
        _wikipediaProvider = wikipediaProvider;

  final LocalDatabaseProvider _speciesProvider;
  final WikipediaArticleProvider _wikipediaProvider;

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

  Future<bool> isSpeciesActive(String species) async {
    return await _speciesProvider.getSpecies(species) != null;
  }

  Future<WikipediaArticle?> getWikipediaArticle(String species) async {
    return _wikipediaProvider.getSpeciesArticle(
      species,
      isSpeciesActive,
    );
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
