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
        if (state is InternetConnected) return const SizedBox.shrink();
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: colorScheme.errorContainer,
          child: Row(
            children: [
              Icon(Icons.wifi_off_rounded,
                  size: 18, color: colorScheme.onErrorContainer),
              const SizedBox(width: 8),
              Text(
                'No internet. Using offline predictions.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
