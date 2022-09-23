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
      SpeciesProperties.stringToEnum(string, StipeCharacterOption.values),
      equals(StipeCharacterOption.ringAndVolva),
    );
  });

  test('Test massaging of db prop values #2', () {
    var string = 'purple-black';

    expect(
      SpeciesProperties.massageDBValue(string),
      equals('purpleBlack'),
    );

    expect(
      SpeciesProperties.stringToEnum(string, SporePrintColorOption.values),
      equals(SporePrintColorOption.purpleBlack),
    );
  });

  test('Test massaging of db prop values "NA"', () {
    var string = 'NA';

    expect(
      SpeciesProperties.massageDBValue(string),
      equals('na'),
    );

    expect(
      SpeciesProperties.stringToEnum(string, StipeCharacterOption.values),
      equals(StipeCharacterOption.na),
    );
  });
}
