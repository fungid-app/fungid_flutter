import 'package:flutter/material.dart';
import 'package:fungid_flutter/utils/urls.dart';

class SpeciesLinksView extends StatelessWidget {
  final String species;

  const SpeciesLinksView({
    Key? key,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Links",
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
          Row(
            children: [
              Wrap(
                spacing: 10,
                children: [
                  ActionChip(
                    avatar: const Icon(Icons.search),
                    label: const Text('Wikipedia'),
                    onPressed: () => launchWikiUrl(species),
                  ),
                  ActionChip(
                    avatar: const Icon(Icons.search),
                    label: const Text('Google'),
                    onPressed: () {
                      launchGoogleUrl(species);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
