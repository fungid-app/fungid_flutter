//https://stackoverflow.com/questions/55413525/flutter-carousel-image-slider-open-separate-page-during-on-tap-event-is-called
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/observations.dart';

class ViewObservationImagePage extends StatefulWidget {
  final UserObservationImage image;
  final Function(String)? onImageDeleted;
  const ViewObservationImagePage({
    Key? key,
    required this.image,
    this.onImageDeleted,
  }) : super(key: key);

  @override
  MyImageScreen createState() => MyImageScreen();
}

class MyImageScreen extends State<ViewObservationImagePage> {
  MyImageScreen();
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (widget.onImageDeleted != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            deleteImage(context, widget.onImageDeleted!, widget.image.id);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          constrained: true,
          clipBehavior: Clip.none,
          maxScale: 10,
          child: Image.file(
            widget.image.getFile(),
            fit: BoxFit.contain,
          ),
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
                  onImageDeleted(id);
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: const Text('Delete')),
          ],
        );
      });
}
