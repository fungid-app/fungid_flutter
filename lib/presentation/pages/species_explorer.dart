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
              padding: UiHelpers.pagePadding,
              child: Column(
                children: [
                  const SizedBox(height: UiHelpers.sectionSpacing),
                  UiHelpers.sectionHeader(
                      context, "Observation Database Explorer"),
                  Text(
                    "Ranked by number of global observations",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: UiHelpers.itemSpacing),
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
