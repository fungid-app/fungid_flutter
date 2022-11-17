import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/species_detail_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/species_common_names.dart';
import 'package:fungid_flutter/presentation/widgets/species_lookalikes.dart';
import 'package:fungid_flutter/presentation/widgets/species_observation_map.dart';
import 'package:fungid_flutter/presentation/widgets/species_seasonality_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_carousel.dart';
import 'package:fungid_flutter/presentation/widgets/species_links_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_properties_view.dart';
import 'package:fungid_flutter/presentation/widgets/species_stats_view.dart';
import 'package:fungid_flutter/presentation/widgets/wikipedia_article_view.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class ViewSpeciesPage extends StatelessWidget {
  final String? speciesName;
  final int? speciesKey;

  const ViewSpeciesPage({
    this.speciesName,
    this.speciesKey,
    Key? key,
  }) : super(key: key);

  static Route<void> route({
    required String? species,
    required int? specieskey,
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
                        specieskey: specieskey,
                        observation: observation,
                      ))),
          ],
          child: ViewSpeciesPage(
            speciesName: species,
            speciesKey: specieskey,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeciesDetailBloc, SpeciesDetailState>(
      builder: (context, state) {
        if (state is SpeciesDetailReady) {
          return Scaffold(
              appBar: AppBar(
                title: Text(state.species.species),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: speciesView(context, state));
        } else if (state is SpeciesDetailFailure) {
          return Text(state.message);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget speciesView(BuildContext context, SpeciesDetailReady state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SpeciesImageCarousel(images: state.species.images),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpeciesCommonNamesView(names: state.species.commonNames),
                SpeciesPropertiesView(properties: state.species.properties),
                SpeciesSeasonalityView(stats: state.species.stats),
                SpeciesLinksView(species: state.species.species),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Local Observations",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      SpeciesObservationMapView(species: state.species.species),
                    ],
                  ),
                ),
                if (state.wikipediaArticle != null) UiHelpers.basicDivider,
                if (state.wikipediaArticle != null)
                  WikipediaArticleView(article: state.wikipediaArticle!),
                UiHelpers.basicDivider,
                SpeciesLookalikesView(lookalikes: state.similarSpecies),
                UiHelpers.basicDivider,
                SpeciesStatsView(stats: state.species.stats)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
