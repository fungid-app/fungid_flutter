import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/edit_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/location_picker.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/presentation/widgets/image_carousel.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    _ImageField(),
                    _DateField(),
                    _LocationField(),
                    _NotesField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _DateField extends StatelessWidget {
  const _DateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = context
            .select((EditObservationBloc bloc) => bloc.state.observationDate) ??
        DateTime.now();
    final displayDate =
        context.select((EditObservationBloc bloc) => bloc.state.formattedDate);

    return ListTile(
      leading: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.calendar_month),
      ),
      minLeadingWidth: 0,
      title: Text(displayDate),
      onTap: () async {
        var bloc = context.read<EditObservationBloc>();

        final newDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (newDate != null) {
          bloc.add(EditObservationDateChanged(date: newDate));
        }
      },
    );
  }
}

class _ImageField extends StatelessWidget {
  const _ImageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images =
        context.select((EditObservationBloc bloc) => bloc.state.images) ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageCarousel(
          key: Key('${images.length}-image-carousel'),
          images: images,
          onImagesAdded: (images) => context
              .read<EditObservationBloc>()
              .add(EditObservationAddImages(images: images)),
          onImageDeleted: (imageID) => context
              .read<EditObservationBloc>()
              .add(EditObservationDeleteImage(imageID: imageID)),
        ),
      ],
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes =
        context.select((EditObservationBloc bloc) => bloc.state.notes) ?? "";

    log(notes);
    return ListTile(
      leading: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.notes),
      ),
      minLeadingWidth: 0,
      title: TextFormField(
        initialValue: notes,
        decoration: const InputDecoration(
          labelText: "Notes",
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
        onChanged: (value) => context
            .read<EditObservationBloc>()
            .add(EditObservationNotesChanged(notes: value)),
      ),
    );
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

    return Column(children: [
      ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.location_on),
        ),
        minLeadingWidth: 0,
        title: Text(
          state.location!.placeName,
        ),
        subtitle: Text('${state.location!.lat}, ${state.location!.lng}'),
        onTap: () =>
            _navigateToMap(context, state.location!.lat, state.location!.lng),
      ),
      // _getMap(context, state.location!),
    ]);
  }

  // ListTile _getMap(BuildContext context, ObservationLocation location) {
  //   var pos = LatLng(location.lat, location.lng);

  //   var marker = Marker(
  //     markerId: MarkerId(location.placeName),
  //     position: pos,
  //     onTap: () => _navigateToMap(context, location.lat, location.lng),
  //   );

  //   CameraPosition kCurrentLocation = CameraPosition(
  //     target: pos,
  //     zoom: 14.4746,
  //   );

  //   return ListTile(
  //     leading: const SizedBox(
  //       height: double.infinity,
  //       child: Icon(Icons.map),
  //     ),
  //     minLeadingWidth: 0,
  //     onTap: () => _navigateToMap(context, location.lat, location.lng),
  //     title: SizedBox(
  //       height: 200,
  //       child: GoogleMap(
  //         key: Key('map-${location.lat}-${location.lng}'),
  //         initialCameraPosition: kCurrentLocation,
  //         markers: {
  //           marker,
  //         },
  //         mapType: MapType.normal,
  //         scrollGesturesEnabled: false,
  //         zoomGesturesEnabled: false,
  //         zoomControlsEnabled: false,
  //         onTap: (_) => _navigateToMap(context, location.lat, location.lng),
  //       ),
  //     ),
  //   );
  // }

  void _navigateToMap(BuildContext context, double latitute, double longitude) {
    Navigator.push(
      context,
      LocationPicker.route(
        latitude: latitute,
        longitude: longitude,
        onLocationChanged: (lat, long) =>
            context.read<EditObservationBloc>().add(
                  EditObservationLocationChanged(
                    latitude: lat,
                    longitude: long,
                  ),
                ),
      ),
    );
  }
}
