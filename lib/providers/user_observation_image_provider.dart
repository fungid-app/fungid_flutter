import 'dart:developer';
import 'dart:io';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class UserObservationImageFileSystemProvider {
  var baseDirectoryName = "FungID";
  late Directory storageDirectory;

  UserObservationImageFileSystemProvider._();

  static Future<UserObservationImageFileSystemProvider> create() async {
    var provider = UserObservationImageFileSystemProvider._();

    await provider._init();

    return provider;
  }

  Future<void> _init() async {
    storageDirectory = await getDirectory();
  }

  Future<Directory> getAndroidDirectory() async {
    Directory? directory = await getExternalStorageDirectory();

    if (directory == null) {
      throw Exception("Could not get directory for saving images");
    } else {
      return Directory("${directory.path}/$baseDirectoryName");
    }
  }

  Future<Directory> getDirectory() async {
    var fileDirectory = Platform.isAndroid
        ? await getAndroidDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS

    if (!fileDirectory.existsSync()) {
      fileDirectory.createSync(recursive: true);
    }

    return fileDirectory;
  }

  Future<UserObservationImage> saveImage(UserObservationImageBase img) async {
    if (img is UserObservationImage) {
      return img;
    }

    UserObservationImage image = UserObservationImage(
      id: img.id,
      dateCreated: img.dateCreated,
    );

    var file = await (img.getFile(storageDirectory)).copy(
      image.getFilePath(storageDirectory),
    );
    await ImageGallerySaver.saveFile(file.path);

    return image;
  }

  Future<void> deleteImage(String imagePath) async {
    var file = File(imagePath);
    log("Deleting image $imagePath");
    await file.delete();
  }
}
