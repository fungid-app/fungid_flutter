import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/seasonal_species_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/internet_cubit.dart';
import 'package:fungid_flutter/presentation/cubit/observation_image_cubit.dart';
import 'package:fungid_flutter/presentation/pages/home.dart';
import 'package:fungid_flutter/repositories/app_settings_repository.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: DioProperties(
      pubName: 'fungid_api',
      pubAuthor: 'Michael Weishuhn',
    ),
    inputSpecFile: 'tmp/fungid-openapi.json',
    generatorName: Generator.dio,
    alwaysRun: true,
    outputDirectory: 'packages/fungid_api')
class FungIDApp extends StatelessWidget {
  const FungIDApp({
    super.key,
    required this.observationsRepsoitory,
    required this.locationRepository,
    required this.predictionsRepository,
    required this.speciesRepository,
    required this.appSettingsRepository,
  });

  final UserObservationsRepository observationsRepsoitory;
  final LocationRepository locationRepository;
  final PredictionsRepository predictionsRepository;
  final SpeciesRepository speciesRepository;
  final AppSettingsRepository appSettingsRepository;
  // final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: observationsRepsoitory,
        ),
        RepositoryProvider.value(
          value: locationRepository,
        ),
        RepositoryProvider.value(
          value: predictionsRepository,
        ),
        RepositoryProvider.value(
          value: speciesRepository,
        ),
        RepositoryProvider.value(
          value: appSettingsRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InternetCubit(connectivity: Connectivity()),
          ),
          BlocProvider(
            create: (context) => ObservationImageCubit(
                userObservationsRepository:
                    RepositoryProvider.of<UserObservationsRepository>(context)),
          ),
          BlocProvider(
            create: (context) => SeasonalSpeciesBloc(
              predictionsRepository:
                  RepositoryProvider.of<PredictionsRepository>(context),
              locationRepository:
                  RepositoryProvider.of<LocationRepository>(context),
            )..add(SeasonalSpeciesLoad(date: DateTime.now())),
          ),
          BlocProvider(
            create: (context) => AppSettingsBloc(
              settingsRepository:
                  RepositoryProvider.of<AppSettingsRepository>(context),
              isSystemThemeDark:
                  Theme.of(context).brightness == Brightness.dark,
              predictionsRepository:
                  RepositoryProvider.of<PredictionsRepository>(context),
            )..add(AppSettingsLoad()),
          ),
        ],
        child: const AppView(),
      ),
      // child: DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const AppView(), // Wrap your app
      //   tools: [
      //     ...DevicePreview.defaultTools,
      //   ],
      // ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AppSettingsBloc>(context),
      builder: (context, state) {
        if (state is AppSettingsLoaded) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'FungID',
            theme: UiHelpers.lightTheme,
            darkTheme: UiHelpers.darkTheme,
            themeMode:
                state.effectiveIsDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
