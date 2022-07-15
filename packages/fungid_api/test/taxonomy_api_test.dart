import 'package:test/test.dart';
import 'package:fungid_api/fungid_api.dart';


/// tests for TaxonomyApi
void main() {
  final instance = FungidApi().getTaxonomyApi();

  group(TaxonomyApi, () {
    // Read User
    //
    //Future<Species> readUserTaxonomySpeciesNameOrIdGet(String nameOrId) async
    test('test readUserTaxonomySpeciesNameOrIdGet', () async {
      // TODO
    });

    // Read Users
    //
    //Future<PageSpecies> readUsersTaxonomySpeciesGet({ int page, int size }) async
    test('test readUsersTaxonomySpeciesGet', () async {
      // TODO
    });

  });
}
