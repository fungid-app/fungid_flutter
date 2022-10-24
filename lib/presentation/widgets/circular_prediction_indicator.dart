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
              backgroundColor: Theme.of(context).backgroundColor,
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
              '${(probability * 100).round()}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
