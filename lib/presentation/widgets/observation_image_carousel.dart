import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/cubit/observation_image_cubit.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';
import 'package:fungid_flutter/presentation/pages/view_image_page.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class ObservationImageCarousel extends StatelessWidget {
  const ObservationImageCarousel({
    Key? key,
    required this.images,
    this.onImagesAdded,
    this.onImageDeleted,
  }) : super(key: key);

  final List<UserObservationImageBase> images;
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
  final List<UserObservationImageBase> images;

  @override
  Widget build(BuildContext context) {
    Directory imageStorageDirectory = context
        .select((ObservationImageCubit bloc) => bloc.state.storageDirectory);

    final carouselHeight = MediaQuery.of(context).size.height * 0.28;

    var items = (images)
        .map(
          (image) => Builder(
            builder: (BuildContext context) {
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(UiHelpers.cardBorderRadius),
                        child: Image.file(
                          image.getFile(imageStorageDirectory),
                          fit: BoxFit.cover,
                          cacheWidth: 500,
                        ),
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
          final colorScheme = Theme.of(context).colorScheme;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(UiHelpers.cardBorderRadius),
                color: colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: colorScheme.outlineVariant,
                  width: 1.5,
                ),
              ),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(UiHelpers.cardBorderRadius),
                onTap: () {
                  createAddImageSheet(
                    context: context,
                    onImagesSelected: (images) {
                      onImagesAdded!(images);
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 32,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add Photo',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ));
    }

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        initialPage: 0,
        disableCenter: true,
        aspectRatio: 1,
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        padEnds: true,
        height: carouselHeight.clamp(160, 280),
        enableInfiniteScroll: false,
      ),
    );
  }
}
