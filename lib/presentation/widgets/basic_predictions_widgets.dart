import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/bloc/simple_species_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/circular_prediction_indicator.dart';
import 'package:fungid_flutter/presentation/widgets/inline_species_properties_icons.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class BasicPredictionsView extends StatelessWidget {
  final List<BasicPrediction> basicPredictions;
  final HueCalculation hueCalculation;
  final String? title;
  final ScrollPhysics? physics;

  const BasicPredictionsView({
    Key? key,
    required this.basicPredictions,
    this.title,
    this.physics,
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
        BasicPredictionsList(
          basicPredictions: basicPredictions,
          hueCalculation: hueCalculation,
          physics: physics ?? const NeverScrollableScrollPhysics(),
        )
      ],
    );
  }
}

class BasicPredictionsList extends StatelessWidget {
  final List<BasicPrediction> basicPredictions;
  final HueCalculation hueCalculation;
  final ScrollPhysics? physics;

  const BasicPredictionsList({
    Key? key,
    required this.basicPredictions,
    required this.hueCalculation,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: physics,
      separatorBuilder: (BuildContext context, int index) =>
          UiHelpers.basicDivider,
      itemCount: basicPredictions.length,
      itemBuilder: (context, index) {
        var pred = basicPredictions[index];
        var bp = BasicPrediction(
          specieskey: pred.specieskey,
          probability: pred.probability,
        );

        return _BasicPredictionTile(
          key: ValueKey(pred.specieskey),
          prediction: bp,
          hueCalculation: hueCalculation,
        );
      },
    );
  }
}

class _BasicPredictionTile extends StatelessWidget {
  final BasicPrediction prediction;
  final HueCalculation hueCalculation;

  const _BasicPredictionTile({
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
        var edible = state.species.properties.howEdible;

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
          subtitle: Row(
            children: [
              InlineSpeciesPropertiesIcons(
                properties: edible,
                padding: const EdgeInsets.only(right: 10, top: 5),
              ),
              state.species.commonName != null
                  ? Expanded(
                      child: Text(
                        state.species.species,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
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
