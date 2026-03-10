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
      if (imageList != null && imageList.isNotEmpty) {
        images.addAll(imageList);
      }
    }

    return images.map((e) => e.path).toList();
  }

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Photos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ImageSourceButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () async {
                    Navigator.of(context).pop();
                    var images = await getImages(ImageSource.camera);
                    if (images.isNotEmpty) {
                      onImagesSelected(images);
                    }
                  },
                ),
                _ImageSourceButton(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: () async {
                    Navigator.of(context).pop();
                    var images = await getImages(ImageSource.gallery);
                    if (images.isNotEmpty) {
                      onImagesSelected(images);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _ImageSourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton.tonal(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
