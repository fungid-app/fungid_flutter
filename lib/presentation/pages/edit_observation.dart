import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/bloc/edit_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/presentation/widgets/image_carousel.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditObservationPage extends StatelessWidget {
  const EditObservationPage({Key? key}) : super(key: key);

  static Route<void> route(
      {UserObservation? initialObservation, List<String>? initialImages}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditObservationBloc(
          intialObservation: initialObservation,
          observationRepository: context.read<UserObservationsRepository>(),
          locationRepository: context.read<LocationRepository>(),
        )..add(InitializeBloc(images: initialImages)),
        child: const EditObservationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditObservationBloc, EditObservationState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditObservationStatus.success,
      listener: (context, state) => state.intialObservation == null
          ? Navigator.pushAndRemoveUntil(
              context,
              ViewObservationPage.route(id: state.id!),
              ModalRoute.withName('/'),
            )
          : Navigator.pop(context),
      child: const EditObservationView(),
    );
  }
}

class EditObservationView extends StatelessWidget {
  const EditObservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((EditObservationBloc bloc) => bloc.state.status);

    if (status == EditObservationStatus.uninitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final isNewObservation = context
          .select((EditObservationBloc bloc) => bloc.state.isNewObservation);
      final images =
          context.select((EditObservationBloc bloc) => bloc.state.images) ?? [];

      final theme = Theme.of(context);
      final floatingActionButtonTheme = theme.floatingActionButtonTheme;
      final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
          theme.colorScheme.secondary;

      return Scaffold(
        appBar: AppBar(
          title: Text(
              isNewObservation ? "Create Observation" : "Edit Observation"),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Save Observation",
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          backgroundColor: status.isLoading
              ? fabBackgroundColor.withOpacity(0.5)
              : fabBackgroundColor,
          onPressed: status.isLoading
              ? null
              : () => context
                  .read<EditObservationBloc>()
                  .add(const EditObservationSubmitted()),
          child: status.isLoading
              ? const CircularProgressIndicator()
              : const Icon(Icons.check_rounded),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ImageCarousel(
                    images: images,
                    onImagesAdded: (images) => context
                        .read<EditObservationBloc>()
                        .add(EditObservationAddImages(images: images)),
                    onImageDeleted: (imageID) => context
                        .read<EditObservationBloc>()
                        .add(EditObservationDeleteImage(imageID: imageID)),
                  ),
                  const _LocationField(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditObservationBloc>().state;

    if (state.location == null) {
      return const SizedBox.shrink();
    }

    var pos = LatLng(state.location!.lat, state.location!.lng);

    var marker = Marker(
      markerId: MarkerId(state.location!.placeName),
      position: pos,
    );

    CameraPosition kCurrentLocation = CameraPosition(
      target: pos,
      zoom: 14.4746,
    );

    return Column(children: [
      Text(
        state.location!.placeName,
        key: const Key('location'),
      ),
      SizedBox(
        height: 200,
        child: GoogleMap(
          initialCameraPosition: kCurrentLocation,
          markers: {
            marker,
          },
          mapType: MapType.normal,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
        ),
      )
    ]);
  }
}
