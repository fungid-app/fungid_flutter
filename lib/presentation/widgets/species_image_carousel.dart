import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/pages/view_species_images_page.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';

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
      return SizedBox(
        height: 200,
        child: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: SpeciesImageDisplay(
                fit: BoxFit.cover,
                image: images[index],
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewSpeciesImagesPage(
                      images: images,
                      idx: index,
                    ),
                  ),
                )
              },
            );
          },
        ),
      );
    }
  }
}
