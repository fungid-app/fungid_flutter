import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:intersperse/intersperse.dart';

class InlineSpeciesPropertiesIcons extends StatelessWidget {
  final List<Enum> properties;
  final EdgeInsetsGeometry padding;

  const InlineSpeciesPropertiesIcons({
    Key? key,
    required this.properties,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const SizedBox.shrink();
    }
    var icons = getIcons(context, properties);
    return Padding(
      padding: padding,
      child: Row(
        children: intersperse(
          const SizedBox(
            width: 10,
          ),
          icons,
        ).toList(),
      ),
    );
  }

  List<Widget> getIcons<T extends Enum>(BuildContext context, List<T>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    return list
        .map(
          (e) => SizedBox(
            width: 20,
            height: 20,
            child: CachedNetworkImage(
              imageUrl: SpeciesProperties.iconUrl(e),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        )
        .toList();
  }
}
