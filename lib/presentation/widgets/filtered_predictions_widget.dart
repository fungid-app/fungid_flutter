import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/bloc/filtered_predictions_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/basic_predictions_widgets.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class FilteredPredictionsView extends StatelessWidget {
  final List<BasicPrediction> basicPredictions;
  final HueCalculation hueCalculation;

  const FilteredPredictionsView({
    Key? key,
    required this.basicPredictions,
    required this.hueCalculation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        log("creating cubit");
        return FilteredPredictionsBloc(
          predictions: basicPredictions,
          speciesRepository: context.read<SpeciesRepository>(),
        );
      },
      child: _FilteredPredictionsView(
        hueCalculation: hueCalculation,
      ),
    );
  }
}

class _FilteredPredictionsView extends StatelessWidget {
  final HueCalculation hueCalculation;

  const _FilteredPredictionsView({
    Key? key,
    required this.hueCalculation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPredictionsBloc, FilteredPredictionsState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search Names',
                        ),
                        onChanged: (value) {
                          context.read<FilteredPredictionsBloc>().add(
                                SearchTextChangedEvent(searchText: value),
                              );
                        },
                      ),
                    ),
                    // Edible Chip Toggle
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        ChoiceChip(
                          selected: state.showEdible,
                          label: const Text("Edible"),
                          onSelected: (value) {
                            FocusScope.of(context).unfocus();
                            context.read<FilteredPredictionsBloc>().add(
                                  EdibleToggledEvent(),
                                );
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selected: state.showPoisonous,
                          label: const Text("Poisonous"),
                          onSelected: (value) {
                            FocusScope.of(context).unfocus();
                            context.read<FilteredPredictionsBloc>().add(
                                  PoisonousToggledEvent(),
                                );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              UiHelpers.basicDivider,
              Expanded(
                child: BasicPredictionsList(
                  basicPredictions: state.visiblePredictions,
                  hueCalculation: hueCalculation,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
