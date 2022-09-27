import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/widgets/fallback_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return FallbackImage(
      url: image!.fungidUrl,
      fallbackUrl: image!.externalUrl,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
