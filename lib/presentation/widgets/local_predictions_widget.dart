import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/cubit/local_predictions_view_cubit.dart';
import 'package:fungid_flutter/presentation/widgets/basic_predictions_widgets.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class LocalPredictionsView extends StatelessWidget {
  final List<LocalPrediction> basicPredictions;
  final HueCalculation hueCalculation;
  final bool isInline;
  final bool showLocalPredictions;
  final String? title;

  const LocalPredictionsView({
    Key? key,
    required this.basicPredictions,
    required this.hueCalculation,
    this.isInline = false,
    this.showLocalPredictions = true,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("buidling local predictions view");
    log("showLocalPredictions = $showLocalPredictions");
    return BlocProvider(
      create: (context) {
        log("creating cubit");
        return LocalPredictionsViewCubit(
          predictions: basicPredictions,
          showOnlyLocal: showLocalPredictions,
        );
      },
      child: _LocalPredictionsView(
        hueCalculation: hueCalculation,
        isInline: isInline,
        title: title,
      ),
    );
  }
}

class _LocalPredictionsView extends StatelessWidget {
  final HueCalculation hueCalculation;
  final bool isInline;
  final String? title;

  const _LocalPredictionsView({
    Key? key,
    required this.hueCalculation,
    required this.isInline,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalPredictionsViewCubit, LocalPredictionsViewState>(
      builder: (context, state) {
        List<Widget> rows = [];

        if (title != null) {
          rows.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: UiHelpers.sectionHeader(
                    context,
                    "${state.showOnlyLocal ? "Local" : "Global"} ${title!} (${state.visiblePredictions.length})",
                  ),
                ),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: true,
                      label: Text('Local'),
                      icon: Icon(Icons.gps_fixed_outlined, size: 16),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text('Global'),
                      icon: Icon(Icons.public, size: 16),
                    ),
                  ],
                  selected: {state.showOnlyLocal},
                  onSelectionChanged: (value) {
                    context
                        .read<LocalPredictionsViewCubit>()
                        .toggleShowOnlyLocal();
                  },
                  style: SegmentedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    textStyle: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          );
        }
        var predList = BasicPredictionsList(
          basicPredictions: state.visiblePredictions,
          hueCalculation: hueCalculation,
          physics: isInline ? const NeverScrollableScrollPhysics() : null,
        );

        if (isInline) {
          rows.add(predList);
        } else {
          rows.add(
            Expanded(
              child: predList,
            ),
          );
        }

        if (!isInline) {
          rows += [
            UiHelpers.basicDivider,
            SwitchListTile(
              secondary: Icon(state.showOnlyLocal
                  ? Icons.gps_fixed_outlined
                  : Icons.gps_not_fixed_outlined),
              dense: true,
              title: const Text('Location Adjusted Predictions'),
              value: state.showOnlyLocal,
              onChanged: (_) {
                context
                    .read<LocalPredictionsViewCubit>()
                    .toggleShowOnlyLocal();
              },
            ),
          ];
        }

        return Column(
          children: rows,
        );
      },
    );
  }
}
