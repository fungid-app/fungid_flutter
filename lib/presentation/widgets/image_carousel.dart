import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    Key? key,
    required this.images,
    this.onImagesAdded,
    this.onImageDeleted,
  }) : super(key: key);

  final List<UserObservationImage> images;
  final Function(List<String>)? onImagesAdded;
  final Function(String)? onImageDeleted;

  @override
  State<StatefulWidget> createState() {
    return _ImageCarouselState();
  }
}

class _ImageCarouselState extends State<ImageCarousel> {
  _ImageCarouselState();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Function(String)? onImageDeleted;

    if (widget.onImageDeleted != null) {
      onImageDeleted = (String id) {
        widget.onImageDeleted!(id);
        setState(() {
          _current = _current - 1;
        });
      };
    }

    var items = (widget.images)
        .map(
          (image) => Builder(
            builder: (BuildContext context) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: GestureDetector(
                      child: Image.file(
                        image.getFile(),
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push<Widget>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageScreen(
                              image: image,
                              onImageDeleted: onImageDeleted,
                            ),
                          ),
                        );
                      }));
            },
          ),
        )
        .toList();

    if (widget.onImagesAdded != null) {
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
                    widget.onImagesAdded!(images);
                    _controller.jumpToPage(0);
                  },
                );
              },
            ),
          );
        },
      ));
    }

    return SizedBox(
      // height: 127,
      child: Column(children: [
        CarouselSlider(
          items: items,
          carouselController: _controller,
          options: CarouselOptions(
            disableCenter: true,
            aspectRatio: 1,
            viewportFraction: .3,
            enlargeCenterPage: true,
            height: 100,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

//https://stackoverflow.com/questions/55413525/flutter-carousel-image-slider-open-separate-page-during-on-tap-event-is-called
class ImageScreen extends StatefulWidget {
  final UserObservationImage image;
  final Function(String)? onImageDeleted;
  const ImageScreen({
    Key? key,
    required this.image,
    this.onImageDeleted,
  }) : super(key: key);

  @override
  MyImageScreen createState() => MyImageScreen();
}

class MyImageScreen extends State<ImageScreen> {
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
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          maxScale: 10,
          child: Image.file(
            widget.image.getFile(),
            fit: BoxFit.scaleDown,
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
