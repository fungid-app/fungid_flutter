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
                Text(
                  "${state.showOnlyLocal ? "Local" : "Global"} ${title!} (${state.visiblePredictions.length})",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.gps_fixed_outlined),
                  onPressed: () {
                    context
                        .read<LocalPredictionsViewCubit>()
                        .toggleShowOnlyLocal();
                  },
                ),
                IconButton(
                  icon: Icon(state.showOnlyLocal
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank),
                  onPressed: () {
                    context
                        .read<LocalPredictionsViewCubit>()
                        .toggleShowOnlyLocal();
                  },
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
            GestureDetector(
              child: ListTile(
                leading: Icon(state.showOnlyLocal
                    ? Icons.gps_fixed_outlined
                    : Icons.gps_not_fixed_outlined),
                dense: true,
                title: const Text(
                  "Location Adjusted Predictions",
                ),
                trailing: Icon(state.showOnlyLocal
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank),
              ),
              onTap: () {
                context.read<LocalPredictionsViewCubit>().toggleShowOnlyLocal();
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
