import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:image_picker/image_picker.dart';

FloatingActionButton createObservationAction(
    BuildContext context, UserObservation? observation) {
  ImagePicker imagePicker = ImagePicker();

  Future<List<String>> _getImages(ImageSource source) async {
    List<XFile> images = [];
    if (source == ImageSource.camera) {
      XFile? image = await imagePicker.pickImage(
          source: source,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.rear);

      if (image != null) {
        images.add(image);
      }
    } else {
      List<XFile>? imageList = await imagePicker.pickMultiImage(
        imageQuality: 50,
      );
      if (imageList != null) {
        images.addAll(imageList);
      }
    }

    return images.map((e) => e.path).toList();
  }

  return FloatingActionButton(
    onPressed: () {
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
                      var nav = Navigator.of(context);
                      nav.pop();
                      var images = await _getImages(ImageSource.camera);
                      if (images.isNotEmpty) {
                        nav.push(
                          EditObservationPage.route(
                              initialImages: images,
                              initialObservation: observation),
                        );
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
                      var images = await _getImages(ImageSource.gallery);
                      if (images.isNotEmpty) {
                        nav.push(
                          EditObservationPage.route(
                              initialImages: images,
                              initialObservation: observation),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          });
    },
    child: const Icon(Icons.add),
  );
}
