import 'dart:math';

abstract class HueCalculation {
  double getHue(num probability);
}

class ConservativeHueCalculation implements HueCalculation {
  @override
  double getHue(num probability) {
    return 100 * (pow(2 * probability, 3) / pow(2, 3));
  }
}

class BasicHueCalculation implements HueCalculation {
  @override
  double getHue(num probability) {
    return 100 * probability * 1.0;
  }
}
