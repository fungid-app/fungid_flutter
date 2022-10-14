import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';

class BasicPredictionsView extends StatelessWidget {
  final List<BasicPrediction> basicPredictions;
  final String? title;

  const BasicPredictionsView(
      {Key? key, required this.basicPredictions, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
        ...basicPredictions.map((e) => BasicPredictionTile(
              prediction: e,
            )),
      ],
    );
  }
}

class BasicPredictionTile extends StatelessWidget {
  final BasicPrediction prediction;

  const BasicPredictionTile({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: prediction.image == null
          ? null
          : SpeciesImageDisplay(
              image: prediction.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
      onTap: () => {
        Navigator.push(
          context,
          ViewSpeciesPage.route(
            species: null,
            specieskey: prediction.specieskey,
            observation: null,
          ),
        )
      },
      minLeadingWidth: 0,
      title: Text('${prediction.speciesName}'),
      subtitle: LinearProgressIndicator(
        value: prediction.probability as double,
        backgroundColor: Colors.grey,
        minHeight: 8,
        valueColor: AlwaysStoppedAnimation<Color>(
          HSLColor.fromAHSL(
            1,
            _getHueFromProbability(prediction.probability),
            .75,
            .5,
          ).toColor(),
        ),
      ),
    );
  }

  double _getHueFromProbability(num probability) {
    return 100 * (pow(2 * probability, 3) / pow(2, 3));
  }
}
