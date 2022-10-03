import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';
import 'package:fungid_flutter/presentation/pages/view_image_page.dart';

class ObservationImageCarousel extends StatelessWidget {
  const ObservationImageCarousel({
    Key? key,
    required this.images,
    this.onImagesAdded,
    this.onImageDeleted,
  }) : super(key: key);

  final List<UserObservationImage> images;
  final Function(List<String>)? onImagesAdded;
  final Function(String)? onImageDeleted;

  @override
  Widget build(BuildContext context) {
    return ObservationImageCarouselView(
      onImagesAdded: onImagesAdded,
      onImageDeleted: onImageDeleted,
      images: images,
    );
  }
}

class ObservationImageCarouselView extends StatelessWidget {
  const ObservationImageCarouselView({
    Key? key,
    required this.onImagesAdded,
    required this.onImageDeleted,
    required this.images,
  }) : super(key: key);
  final Function(List<String>)? onImagesAdded;
  final Function(String)? onImageDeleted;
  final List<UserObservationImage> images;

  @override
  Widget build(BuildContext context) {
    var imageLen = images.length;

    var items = (images)
        .map(
          (image) => Builder(
            builder: (BuildContext context) {
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                      child: Image.file(
                        image.getFile(),
                        fit: BoxFit.cover,
                        cacheWidth: 250,
                      ),
                      onTap: () {
                        Navigator.push<Widget>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewObservationImagePage(
                              selected: image.id,
                              images: images,
                              onImageDeleted: onImageDeleted,
                            ),
                          ),
                        );
                      }));
            },
          ),
        )
        .toList();

    if (onImagesAdded != null) {
      items.add(Builder(
        builder: (BuildContext context) {
          return Center(
            child: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {
                createAddImageSheet(
                  context: context,
                  onImagesSelected: (images) {
                    onImagesAdded!(images);
                  },
                );
              },
            ),
          );
        },
      ));
    }

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        initialPage: imageLen - 1,
        disableCenter: true,
        aspectRatio: 1,
        viewportFraction: .3,
        // enlargeCenterPage: true,

        padEnds: false,
        height: 100,
        enableInfiniteScroll: false,
      ),
    );
  }
}
