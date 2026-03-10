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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hue = hueCalculation.getHue(probability);
    final color = HSLColor.fromAHSL(
      1,
      hue,
      0.75,
      isDark ? 0.65 : 0.40,
    ).toColor();

    return Semantics(
      label: '${(probability * 100).round()} percent probability',
      child: ExcludeSemantics(
        child: SizedBox(
          height: 44,
          width: 44,
          child: Stack(
            children: [
              Center(
                child: CircularProgressIndicator(
                  value: probability as double,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  strokeWidth: 3.5,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Center(
                child: MediaQuery.withClampedTextScaling(
                  maxScaleFactor: 1.0,
                  child: Text(
                    _getProbText(probability),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getProbText(num probability) {
    if (probability < .1) {
      return '${(probability * 100).toStringAsFixed(1)}%';
    } else {
      return '${(probability * 100).round()}%';
    }
  }
}
