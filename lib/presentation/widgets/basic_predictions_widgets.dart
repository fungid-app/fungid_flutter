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
                    style: Theme.of(context).textTheme.headlineSmall,
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
        return const SizedBox(
          height: 72,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Image placeholder
                _ShimmerBox(width: 48, height: 48, borderRadius: 6),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ShimmerBox(width: 140, height: 14, borderRadius: 4),
                      SizedBox(height: 6),
                      _ShimmerBox(width: 100, height: 10, borderRadius: 4),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                _ShimmerBox(width: 44, height: 44, borderRadius: 22),
              ],
            ),
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
              : ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SpeciesImageDisplay(
                    image: state.species.image,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
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
          title: Text(
            state.species.commonName?.name ?? state.species.species,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.species.commonName != null)
                Text(
                  state.species.species,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              if (edible.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: InlineSpeciesPropertiesIcons(
                    properties: edible,
                    padding: EdgeInsets.zero,
                  ),
                ),
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

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
