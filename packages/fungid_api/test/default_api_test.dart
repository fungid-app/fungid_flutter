import 'package:test/test.dart';
import 'package:fungid_api/fungid_api.dart';


/// tests for DefaultApi
void main() {
  final instance = FungidApi().getDefaultApi();

  group(DefaultApi, () {
    // Healthcheck
    //
    //Future<JsonObject> healthcheckHealthcheckGet() async
    test('test healthcheckHealthcheckGet', () async {
      // TODO
    });

  });
}
