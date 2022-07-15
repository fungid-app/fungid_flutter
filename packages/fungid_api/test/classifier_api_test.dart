import 'package:test/test.dart';
import 'package:fungid_api/fungid_api.dart';


/// tests for ClassifierApi
void main() {
  final instance = FungidApi().getClassifierApi();

  group(ClassifierApi, () {
    // Evaluate Full Classifier
    //
    //Future<BuiltMap<String, num>> evaluateFullClassifierClassifierFullPut(DateTime date, num lat, num lon, BuiltList<MultipartFile> images) async
    test('test evaluateFullClassifierClassifierFullPut', () async {
      // TODO
    });

    // Evaluate Image Classifier
    //
    //Future<BuiltMap<String, num>> evaluateImageClassifierClassifierImagePut(BuiltList<MultipartFile> images) async
    test('test evaluateImageClassifierClassifierImagePut', () async {
      // TODO
    });

    // Evaluate Location Classifier
    //
    //Future<BuiltMap<String, num>> evaluateLocationClassifierClassifierLocationGet(num lat, num lon) async
    test('test evaluateLocationClassifierClassifierLocationGet', () async {
      // TODO
    });

    // Evaluate Tabular Classifier
    //
    //Future<BuiltMap<String, num>> evaluateTabularClassifierClassifierTabularGet(DateTime date, num lat, num lon) async
    test('test evaluateTabularClassifierClassifierTabularGet', () async {
      // TODO
    });

  });
}
