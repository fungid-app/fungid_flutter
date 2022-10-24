import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/bloc/simple_species_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/circular_prediction_indicator.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';
import 'package:intersperse/intersperse.dart';

class BasicPredictionsView extends StatelessWidget {
  final List<BasicPrediction> basicPredictions;
  final HueCalculation hueCalculation;
  final String? title;

  const BasicPredictionsView({
    Key? key,
    required this.basicPredictions,
    this.title,
    required this.hueCalculation,
  }) : super(key: key);

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
        ...intersperse(
          UiHelpers.basicDivider,
          basicPredictions.map(
            (e) => BasicPredictionTile(
              prediction: e,
              hueCalculation: hueCalculation,
            ),
          ),
        ),
      ],
    );
  }
}

class BasicPredictionTile extends StatelessWidget {
  final BasicPrediction prediction;
  final HueCalculation hueCalculation;

  const BasicPredictionTile({
    Key? key,
    required this.prediction,
    required this.hueCalculation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpeciesRepository speciesRepository = context.read<SpeciesRepository>();

    return BlocProvider(
      create: (context) =>
          SimpleSpeciesBloc(speciesRepository: speciesRepository)
            ..add(
              SimpleSpeciesLoad(
                specieskey: prediction.specieskey,
              ),
            ),
      child: BasicPredictionTileView(
        prediction: prediction,
        hueCalculation: hueCalculation,
      ),
    );
  }
}

class BasicPredictionTileView extends StatelessWidget {
  final BasicPrediction prediction;
  final HueCalculation hueCalculation;

  const BasicPredictionTileView({
    Key? key,
    required this.prediction,
    required this.hueCalculation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimpleSpeciesBloc, SimpleSpeciesState>(
        builder: (context, state) {
      if (state is SimpleSpeciesLoading || state is SimpleSpeciesInitial) {
        return const ListTile(
          leading: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is SimpleSpeciesError) {
        return ListTile(
          leading: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.error),
          ),
          title: Text(state.message),
        );
      } else if (state is SimpleSpeciesLoaded) {
        return ListTile(
          leading: state.species.image == null
              ? null
              : SpeciesImageDisplay(
                  image: state.species.image,
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
          title: Text(
            state.species.commonName?.name ?? state.species.species,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: state.species.commonName != null
              ? Text(state.species.species)
              : null,
          trailing: CircularPredictionIndicator(
            probability: prediction.probability,
            hueCalculation: hueCalculation,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
