import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';

class PredictionsRepository {
  const PredictionsRepository({
    required SavedPredictionsSharedPrefProvider savedPredictionsProvider,
    required OnlinePredictionsProvider onlinePredictionsProvider,
    required OfflinePredictionsProvider offlinePredictionsProvider,
  })  : _savedPredictionsProvider = savedPredictionsProvider,
        _onlinePredictionsProvider = onlinePredictionsProvider,
        _offlinePredictionsProvider = offlinePredictionsProvider;

  final OnlinePredictionsProvider _onlinePredictionsProvider;
  final SavedPredictionsSharedPrefProvider _savedPredictionsProvider;
  final OfflinePredictionsProvider _offlinePredictionsProvider;

  Future<Predictions> getOnlinePredictions(UserObservation observation) async {
    var preds = _savedPredictionsProvider.getPredictions(observation.id);

    if (preds == null) {
      return await getNewOnlinePredictions(observation);
    }

    return preds;
  }

  Future<void> deleteOnlinePredictions(String id) async {
    // Delete old images
    return _savedPredictionsProvider.deletePredictions(id);
  }

  Future<Predictions> getNewOnlinePredictions(
      UserObservation observation) async {
    var preds = await _onlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.location.lat,
      observation.location.lng,
      observation.images,
    );

    await _savedPredictionsProvider.savePredictions(preds);
    return preds;
  }

  Future<Predictions> getOfflinePredictions(UserObservation observation) async {
    var preds = _savedPredictionsProvider.getPredictions(observation.id);

    if (preds == null) {
      return await getNewOnlinePredictions(observation);
    }

    return preds;
  }

  Future<void> deleteOfflinePredictions(String id) async {
    // Delete old images
    return _savedPredictionsProvider.deletePredictions(id);
  }

  Future<Predictions> getNewOfflinePredictions(
    UserObservation observation,
    Set<String>? localSpecies,
  ) async {
    var preds = await _offlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.images,
      localSpecies,
    );

    await _savedPredictionsProvider.savePredictions(preds);
    return preds;
  }
}
