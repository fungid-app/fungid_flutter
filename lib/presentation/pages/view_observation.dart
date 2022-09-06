import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/bloc/view_observation_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/image_carousel.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class ViewObservationPage extends StatelessWidget {
  const ViewObservationPage({Key? key}) : super(key: key);

  static Route<void> route({required UserObservation observation}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => ViewObservationBloc(
          observation: observation,
          observationRepository: context.read<UserObservationsRepository>(),
        ),
        child: const ViewObservationView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ViewObservationView();
  }
}

class ViewObservationView extends StatelessWidget {
  const ViewObservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observation =
        context.select((ViewObservationBloc bloc) => bloc.state.observation);

    var predicitons = _getPredictions(context, observation.predictions);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text("Your Observation"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          ImageCarousel(
            images: observation.images,
          ),
          ListTile(
            title: Text(observation.location.placeName),
          ),
          ListTile(
            title: Text(observation.dateCreated.toString()),
          ),
          ListTile(
            title: Text(
              "Predictions",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ...predicitons,
        ],
      ),
    );
  }

  List<ListTile> _getPredictions(
    BuildContext context,
    Predictions? predictions,
  ) {
    if (predictions == null) {
      return [
        ListTile(
          title: const Text("No predictions available"),
          subtitle: const Text("Tap to generate"),
          onTap: () => context
              .read<ViewObservationBloc>()
              .add(const ViewObservationGetPredctions()),
        ),
      ];
    }

    return predictions.predictions
        .map((pred) => ListTile(
              title: Text(pred.species),
              subtitle: Text(pred.probability.toString()),
            ))
        .toList();
  }
}
