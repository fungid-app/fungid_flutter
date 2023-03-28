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
      List<XFile> imageList = await imagePicker.pickMultiImage();
      if (imageList.isNotEmpty) {
        images.addAll(imageList);
      }
    }

    return images.map((e) => e.path).toList();
  }

  ElevatedButton createButton(IconData icon, ImageSource source) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), padding: const EdgeInsets.all(20)),
      child: Icon(
        icon,
        size: 25,
      ),
      onPressed: () async {
        Navigator.of(context).pop();
        var images = await getImages(source);
        if (images.isNotEmpty) {
          onImagesSelected(images);
        }
      },
    );
  }

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(Icons.camera_alt_rounded, ImageSource.camera),
              createButton(Icons.photo_library, ImageSource.gallery),
            ],
          ),
        );
      });
}
