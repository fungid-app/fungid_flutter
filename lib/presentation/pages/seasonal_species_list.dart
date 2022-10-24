import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/seasonal_species_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/basic_predictions_widgets.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class SeasonalSpeciesListView extends StatelessWidget {
  const SeasonalSpeciesListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonalSpeciesBloc, SeasonalSpeciesState>(
      builder: (context, state) {
        if (state is SeasonalSpeciesLoading ||
            state is SeasonalSpeciesInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SeasonalSpeciesLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.predictions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BasicPredictionTile(
                        prediction: state.predictions[index],
                        hueCalculation: BasicHueCalculation(),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        UiHelpers.basicDivider,
                  ),
                ),
              ],
            ),
          );
        } else if (state is SeasonalSpeciesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}
