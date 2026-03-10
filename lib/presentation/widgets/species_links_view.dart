import 'package:flutter/material.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';
import 'package:fungid_flutter/utils/urls.dart';

class SpeciesLinksView extends StatelessWidget {
  final String species;

  const SpeciesLinksView({
    Key? key,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiHelpers.sectionHeader(context, "Links"),
        const SizedBox(height: UiHelpers.itemSpacing),
        Wrap(
          spacing: UiHelpers.itemSpacing,
          children: [
            ActionChip(
              avatar: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Wikipedia'),
              onPressed: () => launchWikiUrl(species),
            ),
            ActionChip(
              avatar: const Icon(Icons.search, size: 18),
              label: const Text('Google'),
              onPressed: () => launchGoogleUrl(species),
            ),
          ],
        ),
      ],
    );
  }
}
