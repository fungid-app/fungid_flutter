//https://stackoverflow.com/questions/55413525/flutter-carousel-image-slider-open-separate-page-during-on-tap-event-is-called

import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image_display.dart';

class ViewSpeciesImagesPage extends StatefulWidget {
  final List<SpeciesImage> images;
  final int idx;

  const ViewSpeciesImagesPage({
    Key? key,
    required this.images,
    required this.idx,
  }) : super(key: key);

  @override
  ViewSpeciesImagesPageState createState() => ViewSpeciesImagesPageState();
}

class ViewSpeciesImagesPageState extends State<ViewSpeciesImagesPage> {
  int _current = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    _current = widget.idx;
    controller = PageController(initialPage: _current);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Image ${_current + 1} of ${widget.images.length}'),
        actions: actions,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    constrained: true,
                    clipBehavior: Clip.hardEdge,
                    maxScale: 10,
                    child: SpeciesImageDisplay(
                      fit: BoxFit.contain,
                      image: widget.images[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
