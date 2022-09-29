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
    var tiles = [
      getTiles(context, 'Edibility', properties.howEdible),
      getTiles(context, 'Cap Shape', properties.capShape),
      getTiles(context, 'Ecology', properties.ecologicalType),
      getTiles(context, 'Stem', properties.stipeCharacter),
      getTiles(context, 'Hymenium', properties.hymeniumType),
      getTiles(context, 'Gills', properties.whichGills),
      getTiles(context, 'Spore Color', properties.sporePrintColor),
    ].expand((i) => i).toList();

    if (tiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Properties",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            direction: Axis.horizontal,
            children: tiles,
          )
        ],
      ),
    );
  }

  List<Widget> getTiles<T extends Enum>(
      BuildContext context, String title, List<T>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    return list
        .map(
          (e) => SizedBox(
            width: 190,
            // height: 85,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: SizedBox(
                  height: 45,
                  width: 45,
                  child: CachedNetworkImage(
                    imageUrl: SpeciesProperties.iconUrl(e),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: Text(title),
                subtitle: Text(e.name),
              ),
            ),
          ),
        )
        .toList();
  }
}
