import 'dart:developer';
import 'dart:io';

import 'package:fungid_flutter/domain.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class UserObservationImageFileSystemProvider {
  UserObservationImageFileSystemProvider() {
    _init();
  }
  Directory fileDirectory = Directory('');

  // https://stackoverflow.com/questions/55220612/how-to-save-a-text-file-in-external-storage-in-ios-using-flutter
  void _init() async {
    fileDirectory = Platform.isAndroid
        ? await getAndroidDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS

    if (!fileDirectory.existsSync()) {
      fileDirectory.createSync(recursive: true);
    }
  }

  var baseDirectoryName = "FungID";

  Future<Directory> getAndroidDirectory() async {
    Directory? directory = await getExternalStorageDirectory();

    if (directory == null) {
      throw Exception("Could not get directory for saving images");
    } else {
      return Directory("${directory.path}/$baseDirectoryName");
    }
  }

  Future<String> saveImage(UserObservationImage img) async {
    String path = "${fileDirectory.path}/${img.id}.jpg";
    log("Saving image from ${img.filename} to $path");
    if (path != img.filename) {
      await File(img.filename).copy(path);
      await ImageGallerySaver.saveFile(path);
    }

    return path;
  }

  Future<void> deleteImage(String imagePath) async {
    var file = File(imagePath);
    log("Deleting image $imagePath");
    await file.delete();
  }
}
