import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/internet_cubit.dart';

class ConnectivityWarning extends StatelessWidget {
  const ConnectivityWarning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        return state is InternetConnected
            ? const SizedBox.shrink()
            : const ListTile(
                leading: Icon(Icons.warning),
                title: Text('No internet. Using offline predictions.'),
                dense: true,
              );
      },
    );
  }
}
