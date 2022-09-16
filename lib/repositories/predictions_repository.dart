import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/providers/fungid_api_provider.dart';
import 'package:fungid_flutter/providers/predictions_provider.dart';

class PredictionsRepository {
  const PredictionsRepository({
    required PredictionsSharedPrefProvider predictionsProvider,
    required FungidApiProvider fungidApiProvider,
  })  : _predictionsProvider = predictionsProvider,
        _fungidApiProvider = fungidApiProvider;

  final FungidApiProvider _fungidApiProvider;
  final PredictionsSharedPrefProvider _predictionsProvider;

  Future<Predictions> getPredictions(UserObservation observation) async {
    var preds = _predictionsProvider.getPredictions(observation.id);

    if (preds == null) {
      return await getNewPredictions(observation);
    }

    return preds;
  }

  Future<void> deletePredictions(String id) async {
    // Delete old images
    return _predictionsProvider.deletePredictions(id);
  }

  Future<Predictions> getNewPredictions(UserObservation observation) async {
    var preds = await _fungidApiProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.location.lat,
      observation.location.lng,
      observation.images,
    );

    await _predictionsProvider.savePredictions(preds);
    return preds;
  }
}
