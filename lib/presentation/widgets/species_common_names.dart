import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';

class SpeciesCommonNamesView extends StatelessWidget {
  final List<CommonName> names;

  const SpeciesCommonNamesView({
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Common Name(s)",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          ListTile(
            title: Text(
              names
                  .where((element) => element.language == 'en')
                  .map((e) => e.name)
                  .join(', '),
            ),
          )
        ],
      ),
    );
  }
}
