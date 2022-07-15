import 'package:test/test.dart';
import 'package:fungid_api/fungid_api.dart';


/// tests for ObservationsApi
void main() {
  final instance = FungidApi().getObservationsApi();

  group(ObservationsApi, () {
    // Get All Observations
    //
    //Future<PageGbifObservation> getAllObservationsObservationsGet({ int page, int size }) async
    test('test getAllObservationsObservationsGet', () async {
      // TODO
    });

    // Get Image By Id
    //
    //Future<GbifObservationImage> getImageByIdObservationsImagesImageIdGet(int imageId) async
    test('test getImageByIdObservationsImagesImageIdGet', () async {
      // TODO
    });

    // Get Observation Images By Observation Id
    //
    //Future<PageGbifObservationImage> getObservationImagesByObservationIdObservationsObservationIdImagesGet(int observationId, { int page, int size }) async
    test('test getObservationImagesByObservationIdObservationsObservationIdImagesGet', () async {
      // TODO
    });

    // Get Observation Images
    //
    //Future<PageGbifObservationImage> getObservationImagesObservationsImagesGet({ int page, int size }) async
    test('test getObservationImagesObservationsImagesGet', () async {
      // TODO
    });

    // Get Observations By Id
    //
    //Future<GbifObservation> getObservationsByIdObservationsIdGet(int id) async
    test('test getObservationsByIdObservationsIdGet', () async {
      // TODO
    });

  });
}
