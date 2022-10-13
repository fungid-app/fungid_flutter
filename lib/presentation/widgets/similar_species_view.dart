import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';

class SimilarSpeciesView extends StatelessWidget {
  final List<SimilarSpecies> similarSpecies;

  const SimilarSpeciesView({
    Key? key,
    required this.similarSpecies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Lookalikes",
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        ...similarSpecies.map((e) => getSimilarTile(context, e)),
      ],
    );
  }

  ListTile getSimilarTile(
    BuildContext context,
    SimilarSpecies species,
  ) {
    return ListTile(
      leading: species.image == null
          ? null
          : SpeciesImageDisplay(
              image: species.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
      onTap: () => {
        Navigator.push(
          context,
          ViewSpeciesPage.route(
            species: null,
            specieskey: species.similarSpecieskey,
            observation: null,
          ),
        )
      },
      minLeadingWidth: 0,
      title: Text('${species.similarSpeciesName}'),
      subtitle: LinearProgressIndicator(
        value: species.similarity,
        backgroundColor: Colors.grey,
        minHeight: 8,
        valueColor: AlwaysStoppedAnimation<Color>(
          HSLColor.fromAHSL(
            1,
            _getHueFromProbability(species.similarity),
            .75,
            .5,
          ).toColor(),
        ),
      ),
    );
  }

  double _getHueFromProbability(double probability) {
    return 100 * (pow(2 * probability, 3) / pow(2, 3));
  }
}
