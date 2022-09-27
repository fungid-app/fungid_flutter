import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species_properties.dart';

class SpeciesPropertiesView extends StatelessWidget {
  final SpeciesProperties properties;

  const SpeciesPropertiesView({
    Key? key,
    required this.properties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmpTiles = [
      getTiles('Edibility', properties.howEdible),
      getTiles('Cap Shape', properties.capShape),
      getTiles('Ecology', properties.ecologicalType),
      getTiles('Stem', properties.stipeCharacter),
      getTiles('Hymenium', properties.hymeniumType),
      getTiles('Gills', properties.whichGills),
      getTiles('Spore Color', properties.sporePrintColor),
    ];
    List<ListTile> tiles = [];

    for (var tile in tmpTiles) {
      tiles.addAll(tile);
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 15,
      childAspectRatio: 4,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
      children: tiles,
    );
  }

  List<ListTile> getTiles<T extends Enum>(String title, List<T>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    return list
        .map(
          (e) => ListTile(
            leading: SizedBox(
              height: 45,
              width: 45,
              child: CachedNetworkImage(
                imageUrl: SpeciesProperties.iconUrl(e),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(title),
            subtitle: Text(e.name),
          ),
        )
        .toList();
  }
}
