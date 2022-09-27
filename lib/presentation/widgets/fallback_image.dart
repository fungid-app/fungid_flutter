import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FallbackImage extends StatelessWidget {
  const FallbackImage({
    Key? key,
    required this.url,
    required this.fallbackUrl,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String url;
  final String fallbackUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    var fallback = _getCachedNetworkImage(
      fallbackUrl,
      const Icon(Icons.error),
      height,
      width,
      fit,
    );

    var img = _getCachedNetworkImage(
      url,
      fallback,
      height,
      width,
      fit,
    );

    return img;
  }

  Widget _getCachedNetworkImage(String url, Widget errorWidget, double? height,
      double? width, BoxFit? fit) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      placeholder: (context, url) => const Center(
          child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: CircularProgressIndicator(),
      )),
      errorWidget: (context, url, error) => errorWidget,
      width: width,
      height: height,
    );
  }
}
