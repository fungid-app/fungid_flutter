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
          final commonName = state.species.commonNames
              .where((n) => n.language == 'en')
              .map((n) => n.name)
              .firstOrNull;
          return Scaffold(
              appBar: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (commonName != null)
                      Text(
                        commonName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    Text(
                      state.species.species,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: speciesView(context, state));
        } else if (state is SpeciesDetailFailure) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text('Error'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48,
                        color: Theme.of(context).colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.tonal(
                      onPressed: () {
                        context.read<SpeciesDetailBloc>().add(
                              SpeciesDetailInitalizeEvent(
                                speciesName: speciesName,
                                specieskey: speciesKey,
                              ),
                            );
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
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
            padding: UiHelpers.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpeciesCommonNamesView(names: state.species.commonNames),
                const SizedBox(height: UiHelpers.sectionSpacing),
                SpeciesPropertiesView(properties: state.species.properties),
                const SizedBox(height: UiHelpers.sectionSpacing),
                SpeciesSeasonalityView(stats: state.species.stats),
                const SizedBox(height: UiHelpers.sectionSpacing),
                SpeciesLinksView(species: state.species.species),
                const SizedBox(height: UiHelpers.sectionSpacing),
                UiHelpers.sectionHeader(context, "Local Observations"),
                SpeciesObservationMapView(species: state.species.species),
                if (state.wikipediaArticle != null) ...[
                  const SizedBox(height: UiHelpers.sectionSpacing),
                  UiHelpers.basicDivider,
                  const SizedBox(height: UiHelpers.itemSpacing),
                  WikipediaArticleView(article: state.wikipediaArticle!),
                ],
                const SizedBox(height: UiHelpers.sectionSpacing),
                UiHelpers.basicDivider,
                const SizedBox(height: UiHelpers.itemSpacing),
                SpeciesLookalikesView(lookalikes: state.similarSpecies),
                const SizedBox(height: UiHelpers.sectionSpacing),
                UiHelpers.basicDivider,
                const SizedBox(height: UiHelpers.itemSpacing),
                SpeciesStatsView(stats: state.species.stats),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
