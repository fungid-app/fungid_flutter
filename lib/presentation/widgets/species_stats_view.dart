import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/widgets/circular_prediction_indicator.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class SpeciesStatsView extends StatelessWidget {
  final SpeciesStats stats;

  const SpeciesStatsView({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Ecological Affinity",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          DefaultTabController(
            length: 4, // length of tabs
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const TabBar(
                  tabs: [
                    Tab(text: 'Landcover'),
                    Tab(text: 'Topology'),
                    Tab(text: 'Lithology'),
                    Tab(text: 'Climate'),
                  ],
                ),
                Container(
                  height: 580,
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(width: 0.5))),
                  child: TabBarView(
                    children: <Widget>[
                      getStatsTiles(stats.eluClass3Stats),
                      getStatsTiles(stats.eluClass1Stats),
                      getStatsTiles(stats.eluClass2Stats),
                      getStatsTiles(stats.kgStats),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getStatsTiles(List<SpeciesStat> stats) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          UiHelpers.basicDivider,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length > 10 ? 10 : stats.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(stats[index].value),
        trailing: CircularPredictionIndicator(
          probability: stats[index].likelihood,
          hueCalculation: BasicHueCalculation(),
        ),
      ),
    );
  }
}
