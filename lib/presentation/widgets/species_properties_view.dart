import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiHelpers.sectionHeader(context, "Properties"),
        const SizedBox(height: UiHelpers.itemSpacing),
        Wrap(
          spacing: UiHelpers.itemSpacing,
          runSpacing: UiHelpers.itemSpacing,
          children: tiles,
        ),
      ],
    );
  }

  List<Widget> getTiles<T extends Enum>(
      BuildContext context, String title, List<T>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    var width = MediaQuery.of(context).size.width * .45;

    return list
        .map(
          (e) => SizedBox(
            width: width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CachedNetworkImage(
                        imageUrl: SpeciesProperties.iconUrl(e),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                        Text(
                          e.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
