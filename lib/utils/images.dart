import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

Image? resizeFromFile(String path, int maxSize) {
  // Read a jpeg image from file.
  File file = File(path);

  if (!file.existsSync()) return null;

  Image? image = decodeJpg(file.readAsBytesSync());

  if (image == null) return null;

  if (image.width < maxSize && image.height < maxSize) {
    return image;
  }

  if (image.width > image.height) {
    return copyResize(image, width: maxSize);
  }

  return copyResize(image, height: maxSize);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Uint8List? prepareImageFile(String path, int maxSize) {
  Image? image = resizeFromFile(path, maxSize);
  if (image == null) return null;
  return image.getBytes();
}

Uint8List? getBytesFromFile(String path) {
  File file = File(path);
  if (!file.existsSync()) return null;
  return file.readAsBytesSync();
}
