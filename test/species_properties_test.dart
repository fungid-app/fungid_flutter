import 'package:fungid_flutter/domain/species_properties.dart';
import 'package:test/test.dart';

void main() {
  test('Test massaging of db prop values', () {
    var string = 'ring and volva';

    expect(
      SpeciesProperties.massageDBValue(string),
      equals('ringAndVolva'),
    );

    expect(
      SpeciesProperties.stringToEnum(string, StipeCharacter.values),
      equals(StipeCharacter.ringAndVolva),
    );
  });

  test('Test massaging of db prop values #2', () {
    var string = 'purple-black';

    expect(
      SpeciesProperties.massageDBValue(string),
      equals('purpleBlack'),
    );

    expect(
      SpeciesProperties.stringToEnum(string, SporePrintColor.values),
      equals(SporePrintColor.purpleBlack),
    );
  });

  test('Test massaging of db prop values "NA"', () {
    var string = 'NA';

    expect(
      SpeciesProperties.massageDBValue(string),
      equals('na'),
    );

    expect(
      SpeciesProperties.stringToEnum(string, StipeCharacter.values),
      equals(StipeCharacter.na),
    );
  });

  test('Test Icon Conversion', () {
    expect(
      SpeciesProperties.iconUrl(StipeCharacter.bare),
      equals(
          'https://api.fungid.app/static/properties/stipecharacter/bare.png'),
    );
  });
}
