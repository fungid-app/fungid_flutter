import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class SpeciesCommonNamesView extends StatelessWidget {
  final List<CommonName> names;

  const SpeciesCommonNamesView({
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) {
      return const SizedBox.shrink();
    }

    final englishNames = names
        .where((element) => element.language == 'en')
        .map((e) => e.name)
        .toList();

    if (englishNames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UiHelpers.itemSpacing),
        Text(
          englishNames.join(', '),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
