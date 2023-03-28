import 'package:flutter/material.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';

class CircularPredictionIndicator extends StatelessWidget {
  const CircularPredictionIndicator({
    Key? key,
    required this.probability,
    required this.hueCalculation,
  }) : super(key: key);

  final num probability;
  final HueCalculation hueCalculation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              value: probability as double,
              backgroundColor: Theme.of(context).colorScheme.background,
              valueColor: AlwaysStoppedAnimation<Color>(
                HSLColor.fromAHSL(
                  1,
                  hueCalculation.getHue(probability),
                  .75,
                  .5,
                ).toColor(),
              ),
            ),
          ),
          Center(
            child: Text(
              _getProbText(probability),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  String _getProbText(num probability) {
    if (probability < .1) {
      return (probability * 100).toStringAsFixed(1);
    } else {
      return '${(probability * 100).round()}';
    }
  }
}
