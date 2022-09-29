import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/domain/species_properties.dart';

class SpeciesCommonNamesView extends StatelessWidget {
  final List<CommonName> names;

  const SpeciesCommonNamesView({
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Common Names'),
      subtitle: Text(
        names
            // .where((element) => element.language == 'en')
            .map((e) => '${e.name}, ${e.language}')
            .join(', '),
      ),
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
