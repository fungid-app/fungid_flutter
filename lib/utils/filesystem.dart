import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';

Future<String> getLocalFilePath(String fileName) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  return path.join(documentsDirectory.path, fileName);
}
