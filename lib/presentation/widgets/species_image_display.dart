import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';

class SpeciesImageDisplay extends StatelessWidget {
  final SpeciesImage? image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const SpeciesImageDisplay({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return FallbackImage(
  //     url: image!.fungidUrl,
  //     fallbackUrl: image!.externalUrl,
  //     width: width,
  //     height: height,
  //     fit: fit,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: image!.fungidUrl,
      placeholder: (context, url) => Center(
        child: SizedBox(
          width: width,
          height: height,
          child: const CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: width,
      height: height,
    );
  }
}
