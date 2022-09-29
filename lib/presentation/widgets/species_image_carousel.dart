import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image.dart';

class SpeciesImageCarousel extends StatelessWidget {
  final List<SpeciesImage> images;

  const SpeciesImageCarousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return SpeciesImageDisplay(
                image: images[index],
              );
            },
          ),
        ),
      );
    }
  }
}
