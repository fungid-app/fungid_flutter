enum CapShape {
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

enum EcologicalType {
  na,
  mycorrhizal,
  parasitic,
  saprotrophic,
}

enum HowEdible {
  na,
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

enum HymeniumType {
  na,
  gills,
  gleba,
  pores,
  ridges,
  smooth,
  teeth,
}

enum SporePrintColor {
  na,
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

enum StipeCharacter {
  na,
  bare,
  cortina,
  ring,
  ringAndVolva,
  volva,
}

enum WhichGills {
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
  final List<CapShape> capShape;
  final List<EcologicalType> ecologicalType;
  final List<HowEdible> howEdible;
  final List<HymeniumType> hymeniumType;
  final List<SporePrintColor> sporePrintColor;
  final List<StipeCharacter> stipeCharacter;
  final List<WhichGills> whichGills;

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

  static String iconUrl<T extends Enum>(T value) {
    return 'https://api.fungid.app/static/properties/${value.toString().split('.').join('/')}.png'
        .toLowerCase();
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
