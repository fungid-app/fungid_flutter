import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/pages/view_species_images_page.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';

class SpeciesImageCarousel extends StatefulWidget {
  final List<SpeciesImage> images;

  const SpeciesImageCarousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<SpeciesImageCarousel> createState() => _SpeciesImageCarouselState();
}

class _SpeciesImageCarouselState extends State<SpeciesImageCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              if (index < widget.images.length - 1) {
                precacheImage(
                    CachedNetworkImageProvider(
                        widget.images[index + 1].fungidUrl),
                    context);
              }
              return GestureDetector(
                child: SpeciesImageDisplay(
                  fit: BoxFit.cover,
                  image: widget.images[index],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewSpeciesImagesPage(
                      images: widget.images,
                      idx: index,
                    ),
                  ),
                ),
              );
            },
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black26],
                  ),
                ),
                child: widget.images.length > 7
                    ? Center(
                        child: Text(
                          '${_currentPage + 1} / ${widget.images.length}',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.images.length,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
