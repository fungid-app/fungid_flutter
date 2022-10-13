// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
// import 'package:fungid_flutter/presentation/cubit/observation_image_cubit.dart';
// import 'package:fungid_flutter/repositories/user_observation_repository.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ObservationListBloc(
//         repository: RepositoryProvider.of<UserObservationsRepository>(context),
//       )..add(const ObservationListSubscriptionRequested()),
//       child: const HomeView(),
//     );
//   }
// }

// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Directory imageStorageDirectory = context
//         .select((ObservationImageCubit bloc) => bloc.state.storageDirectory);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Observations'),
//       ),
//       floatingActionButton: createObservationAction(context, null),
//       body: BlocBuilder<ObservationListBloc, ObservationListState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     itemCount: state.observations.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return _observationCard(context,
//                           state.observations[index], imageStorageDirectory);
//                     },
//                     separatorBuilder: (context, index) => const Divider(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
