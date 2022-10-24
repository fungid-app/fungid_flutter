import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/observation_image_cubit.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class ObservationListView extends StatelessWidget {
  const ObservationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Directory imageStorageDirectory = context
        .select((ObservationImageCubit bloc) => bloc.state.storageDirectory);

    return BlocBuilder<ObservationListBloc, ObservationListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.observations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _observationCard(context, state.observations[index],
                        imageStorageDirectory);
                  },
                  separatorBuilder: (context, index) => UiHelpers.basicDivider,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

ListTile _observationCard(
  BuildContext context,
  UserObservation observation,
  Directory imageStorageDirectory,
) {
  return ListTile(
    leading: SizedBox(
      width: 60,
      child: observation.images.isNotEmpty
          ? Image.file(
              observation.images.first.getFile(imageStorageDirectory),
              fit: BoxFit.cover,
              cacheWidth: 100,
            )
          : const SizedBox.shrink(),
    ),
    minLeadingWidth: 0,
    title: Text(observation.dayObserved()),
    subtitle: Text(observation.location.placeName),
    onTap: () => Navigator.push(
        context,
        ViewObservationPage.route(
          id: observation.id,
        )),
  );
}
