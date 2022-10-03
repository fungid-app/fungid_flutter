//https://stackoverflow.com/questions/55413525/flutter-carousel-image-slider-open-separate-page-during-on-tap-event-is-called
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/observations.dart';

class ViewObservationImagePage extends StatefulWidget {
  final List<UserObservationImage> images;
  final String selected;
  final Function(String)? onImageDeleted;

  const ViewObservationImagePage({
    Key? key,
    required this.images,
    required this.selected,
    this.onImageDeleted,
  }) : super(key: key);

  @override
  ViewObservationImagePageState createState() =>
      ViewObservationImagePageState();
}

class ViewObservationImagePageState extends State<ViewObservationImagePage> {
  int _current = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    _current =
        widget.images.indexWhere((element) => element.id == widget.selected);
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
    if (widget.onImageDeleted != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            deleteImage(
              context,
              widget.onImageDeleted!,
              widget.images[_current].id,
            );
          },
        ),
      );
    }

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
                    clipBehavior: Clip.none,
                    maxScale: 10,
                    child: Image.file(
                      widget.images[index].getFile(),
                      fit: BoxFit.contain,
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

void deleteImage(
  BuildContext context,
  Function(String) onImageDeleted,
  String id,
) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure you want to delete the image?'),
          actions: [
            TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  log("deleting image");
                  onImageDeleted(id);
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: const Text('Delete')),
          ],
        );
      });
}
