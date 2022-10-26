import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/bloc/seasonal_species_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/local_predictions_widget.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';

class SpeciesLookalikesView extends StatelessWidget {
  final List<BasicPrediction> lookalikes;

  const SpeciesLookalikesView({
    Key? key,
    required this.lookalikes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonalSpeciesBloc, SeasonalSpeciesState>(
      builder: (context, state) {
        if (state is SeasonalSpeciesLoaded) {
          List<LocalPrediction> localPredictions = lookalikes.map(
            (e) {
              log(state.localSpeciesKeys.contains(e.specieskey).toString());
              return LocalPrediction(
                specieskey: e.specieskey,
                probability: e.probability,
                isLocal: state.localSpeciesKeys.contains(e.specieskey),
                localProbability: e.probability,
              );
            },
          ).toList();

          if (localPredictions.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: LocalPredictionsView(
              basicPredictions: localPredictions,
              hueCalculation: BasicHueCalculation(),
              isInline: true,
              title: "Lookalikes",
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
