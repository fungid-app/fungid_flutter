enum CapShapeOption {
  na,
  campanulate,
  conical,
  convex,
  depressed,
  flat,
  infundibuliform,
  offset,
  ovate,
  umbilicate,
  umbonate,
}

enum EcologicalTypeOption {
  mycorrhizal,
  parasitic,
  saprotrophic,
}

enum HowEdibleOption {
  allergenic,
  caution,
  choice,
  deadly,
  edible,
  inedible,
  poisonous,
  psychoactive,
  unknown,
  unpalatable,
}

enum HymeniumTypeOption {
  gills,
  gleba,
  pores,
  ridges,
  smooth,
  teeth,
}

enum SporePrintColorOption {
  black,
  blackishBrown,
  brown,
  buff,
  cream,
  green,
  ochre,
  olive,
  oliveBrown,
  pink,
  pinkishBrown,
  purple,
  purpleBlack,
  purpleBrown,
  reddishBrown,
  salmon,
  tan,
  white,
  whiteToYellow,
  yellow,
  yellowOrange,
}

enum StipeCharacterOption {
  na,
  bare,
  cortina,
  ring,
  ringAndVolva,
  volva,
}

enum WhichGillsOption {
  na,
  adnate,
  adnexed,
  decurrent,
  emarginate,
  free,
  no,
  seceding,
  sinuate,
  subdecurrent,
}

class SpeciesProperties {
  final List<CapShapeOption> capShape;
  final List<EcologicalTypeOption> ecologicalType;
  final List<HowEdibleOption> howEdible;
  final List<HymeniumTypeOption> hymeniumType;
  final List<SporePrintColorOption> sporePrintColor;
  final List<StipeCharacterOption> stipeCharacter;
  final List<WhichGillsOption> whichGills;

  SpeciesProperties({
    required this.capShape,
    required this.ecologicalType,
    required this.howEdible,
    required this.hymeniumType,
    required this.sporePrintColor,
    required this.stipeCharacter,
    required this.whichGills,
  });

  static T stringToEnum<T>(String str, Iterable<T> values) {
    return values.firstWhere(
      (v) => v.toString().split('.').last == massageDBValue(str),
    );
  }

  // The database values are not always the same as the enum values.
  // i.e. "ring and volva" tp "ringAndVolva"
  // and "purple black" to "purpleBlack"
  static String massageDBValue(String value) {
    value = value.toLowerCase().replaceAll("_", " ").replaceAll('-', ' ');
    return value.replaceAllMapped(
      RegExp(r'(\w+)(\s)(\w)'),
      (match) => match.group(1)! + (match.group(3) ?? "").toUpperCase(),
    );
  }
}
