import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/seasonal_species_bloc.dart';
import 'package:fungid_flutter/presentation/pages/seasonal_observation_map.dart';
import 'package:fungid_flutter/presentation/widgets/filtered_predictions_widget.dart';
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
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  UiHelpers.header(context, "Mushrooms In Season Locally"),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Text("Ranked by number of in-season local observations"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FilteredPredictionsView(
                    basicPredictions: state.predictions,
                    hueCalculation: BasicHueCalculation(),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => const SeasonalObservationMapView(),
                ),
              ),
              child: const Icon(Icons.map),
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
