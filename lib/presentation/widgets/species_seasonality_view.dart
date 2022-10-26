import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';

class SpeciesSeasonalityView extends StatelessWidget {
  final SpeciesStats stats;

  const SpeciesSeasonalityView({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Seasonality",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            Flexible(
              child: getMonthGraph(context, stats.normalizedMonthStats),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMonthGraph(BuildContext context, List<SpeciesStat> stats) {
    var theme = Theme.of(context);

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: false,
        ),
        clipData: FlClipData.all(),
        lineBarsData: [
          getBarData(theme, stats),
        ],
        titlesData: titlesData(theme),
        borderData: borderData(theme),
        minX: 0.5,
        maxX: 12.5,
        minY: 0,
        maxY: 1.05,
      ),
    );
  }
}

FlBorderData borderData(ThemeData theme) => FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(color: theme.primaryColor, width: 4),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );

FlTitlesData titlesData(ThemeData theme) => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles(theme),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

SideTitles bottomTitles(ThemeData theme) => SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets(theme),
    );

SideTitleWidget Function(double, TitleMeta) bottomTitleWidgets(
    ThemeData theme) {
  return (double value, TitleMeta meta) {
    var style = theme.textTheme.bodyLarge;
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text('Feb', style: style);
        break;
      case 5:
        text = Text('May', style: style);
        break;
      case 8:
        text = Text('Aug', style: style);
        break;
      case 11:
        text = Text('Nov', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  };
}

LineChartBarData getBarData(ThemeData theme, List<SpeciesStat> stats) {
  stats.sort((a, b) => double.parse(a.value).compareTo(double.parse(b.value)));
  var adjusted = [
    SpeciesStat(
      value: "0",
      likelihood: stats.last.likelihood,
    ),
    ...stats,
    SpeciesStat(
      value: "13",
      likelihood: stats.first.likelihood,
    ),
  ];
  return LineChartBarData(
    isCurved: true,
    color: theme.toggleableActiveColor,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      color: theme.primaryColorLight,
    ),
    spots: adjusted
        .map(
          (e) => FlSpot(
            double.parse(e.value),
            e.likelihood,
          ),
        )
        .toList(),
  );
}
