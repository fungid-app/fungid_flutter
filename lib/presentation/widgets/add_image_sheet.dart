import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void createAddImageSheet({
  required BuildContext context,
  required Function(List<String>) onImagesSelected,
}) {
  ImagePicker imagePicker = ImagePicker();

  Future<List<String>> getImages(ImageSource source) async {
    List<XFile> images = [];
    if (source == ImageSource.camera) {
      XFile? image = await imagePicker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        images.add(image);
      }
    } else {
      List<XFile>? imageList = await imagePicker.pickMultiImage();
      if (imageList != null) {
        images.addAll(imageList);
      }
    }

    return images.map((e) => e.path).toList();
  }

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20)),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 25,
                ),
                onPressed: () async {
                  var images = await getImages(ImageSource.camera);
                  if (images.isNotEmpty) {
                    onImagesSelected(images);
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20)),
                child: const Icon(
                  Icons.photo_library,
                  size: 25,
                ),
                onPressed: () async {
                  var nav = Navigator.of(context);
                  nav.pop();
                  var images = await getImages(ImageSource.gallery);
                  if (images.isNotEmpty) {
                    onImagesSelected(images);
                  }
                },
              ),
            ],
          ),
        );
      });
}
