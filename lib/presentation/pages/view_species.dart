import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/species_detail_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/species_seasonality_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_carousel.dart';
import 'package:fungid_flutter/presentation/widgets/species_links_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_properties_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_stats_view.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';

class ViewSpeciesPage extends StatelessWidget {
  final String speciesName;

  const ViewSpeciesPage({
    required this.speciesName,
    Key? key,
  }) : super(key: key);

  static Route<void> route({
    required String species,
    UserObservation? observation,
  }) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<SpeciesDetailBloc>(
                create: (context) => SpeciesDetailBloc(
                      speciesRepository: context.read<SpeciesRepository>(),
                    )..add(SpeciesDetailInitalizeEvent(
                        speciesName: species,
                        observation: observation,
                      ))),
          ],
          child: ViewSpeciesPage(
            speciesName: species,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(speciesName),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<SpeciesDetailBloc, SpeciesDetailState>(
        builder: (context, state) {
          if (state is SpeciesDetailReady) {
            return speciesView(context, state);
          } else if (state is SpeciesDetailFailure) {
            return Text(state.message);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget speciesView(BuildContext context, SpeciesDetailReady state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpeciesImageCarousel(images: state.species.images),
            SpeciesPropertiesView(properties: state.species.properties),
            SpeciesLinksView(species: state.species.species),
            SpeciesSeasonalityView(stats: state.species.stats),
            SpeciesStatsView(stats: state.species.stats)
          ],
        ),
      ),
    );
  }
}
