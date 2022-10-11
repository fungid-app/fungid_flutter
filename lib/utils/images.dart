import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

Future<Image> resizeFromFile(Map<String, dynamic> values) async {
  // Read a jpeg image from file.
  var path = values['path'] as String;
  var maxSize = values['maxSize'] as int;

  File file = File(path);

  if (!(await file.exists())) return throw Exception('Image file not found');

  var bytes = await file.readAsBytes();

  log('Read ${bytes.length} bytes from $path');

  Image image = decodeJpg(bytes)!;

  if (image.width < maxSize && image.height < maxSize) {
    log('Image is already smaller than $maxSize');
    return image;
  }

  if (image.width > image.height) {
    var img = copyResize(image, width: maxSize);
    log('Resized image to ${img.width}x${img.height}, ${img.getBytes().length} bytes');
    return img;
  }

  Image img = copyResize(image, height: maxSize);
  log('Resized image to ${img.width}x${img.height}, ${img.getBytes().length} bytes');

  return img;
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Future<List<String>> prepareImageFiles(
    Iterable<String> paths, Directory tmpDir, int maxSize) async {
  return await Future.wait(
    paths.map(
      (path) async {
        var name = path.split('/').last;

        var args = {
          'path': path,
          'maxSize': maxSize,
        };

        var img = await compute(resizeFromFile, args);
        File file = File('${tmpDir.path}/$name');
        await file.writeAsBytes(encodePng(img));
        return file.path;
      },
    ).toList(),
  );
}

Future<Uint8List?> getBytesFromFile(String path) async {
  File file = File(path);
  if (!(await file.exists())) return null;
  return await file.readAsBytes();
}
