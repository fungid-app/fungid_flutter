import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/species_explorer_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/filtered_predictions_widget.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class SpeciesExplorerView extends StatelessWidget {
  const SpeciesExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeciesExplorerBloc, SpeciesExplorerState>(
      builder: (context, state) {
        if (state is SpeciesExplorerLoading ||
            state is SpeciesExplorerInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SpeciesExplorerLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  UiHelpers.header(context, "Observation Database Explorer"),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Text("Ranked by number of global observations"),
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
          );
        } else if (state is SpeciesExplorerError) {
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
