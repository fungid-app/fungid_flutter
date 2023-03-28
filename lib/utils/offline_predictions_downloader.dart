import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fungid_flutter/utils/filesystem.dart';
import 'package:pytorch_mobile_v2/model.dart';
import 'package:pytorch_mobile_v2/pytorch_mobile_v2.dart';

class OfflinePredictionsDownloader {
  final String _dataPath;
  String currentVersion = "0.4.1";
  List<String>? labels;
  Model? imageModel;

  bool get isInitialized => imageModel != null && labels != null;
  String get _modelName => "$currentVersion.ptl";
  String get _labelsName => "$currentVersion.csv";
  Future<String> get _modelPath => getLocalFilePath("$_dataPath/$_modelName");
  Future<String> get _labelsPath => getLocalFilePath("$_dataPath/$_labelsName");
  Future<String> get _fullDataPath => getLocalFilePath(_dataPath);

  ReceivePort? port;

  OfflinePredictionsDownloader({
    required String dataPath,
  }) : _dataPath = dataPath;

  Future<bool> modelExists() async {
    return await File(await _modelPath).exists();
  }

  Future<bool> labelsExist() async {
    return await File(await _labelsPath).exists();
  }

  Future<void> disable({
    bool deleteFiles = false,
  }) async {
    await FlutterDownloader.cancelAll();
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    for (var element in await FlutterDownloader.loadTasks() ?? []) {
      await FlutterDownloader.remove(
          taskId: element.taskId, shouldDeleteContent: deleteFiles);
    }

    imageModel = null;
    labels = null;

    port?.close();
  }

  Stream<OfflinePredictionsDownloadStatus> enable() async* {
    if (await modelExists() && await labelsExist()) {
      await _loadData();
    }

    if (isInitialized) {
      yield OfflinePredictionsDownloadStatus(
          status: OfflinePredictionsDownloadStatusEnum.success);

      return;
    }

    await disable(
      deleteFiles: true,
    );

    // Ensure directory exists
    await Directory(await _fullDataPath).create(recursive: true);

    if (!(await modelExists()) || !(await labelsExist())) {
      port = ReceivePort();
      IsolateNameServer.registerPortWithName(
          port!.sendPort, 'downloader_send_port');
      FlutterDownloader.registerCallback(downloadCallback);

      var tasks = await startTasks();

      List<DownloadTaskStatus> failures = [
        DownloadTaskStatus.failed,
        DownloadTaskStatus.canceled,
        DownloadTaskStatus.undefined,
      ];

      List<DownloadTaskStatus> working = [
        DownloadTaskStatus.complete,
        DownloadTaskStatus.running,
      ];

      await for (dynamic data in port!) {
        try {
          String id = data[0];
          tasks[id] = data;

          if (tasks.entries
              .any((e) => e.value != null && failures.contains(e.value![1]))) {
            yield OfflinePredictionsDownloadStatus(
              status: OfflinePredictionsDownloadStatusEnum.failed,
              message: "Download failed",
            );
            await disable(deleteFiles: true);
            break;
          } else if (tasks.entries.every((e) =>
              e.value != null && e.value![1] == DownloadTaskStatus.complete)) {
            yield OfflinePredictionsDownloadStatus(
              status: OfflinePredictionsDownloadStatusEnum.success,
            );

            await _loadData();
            break;
          } else {
            if (tasks.entries.every(
                (e) => e.value != null && working.contains(e.value![1]))) {
              yield OfflinePredictionsDownloadStatus(
                status: OfflinePredictionsDownloadStatusEnum.downloading,
                message: (tasks.entries
                            .map((e) => (e.value![2] as int).toDouble())
                            .reduce((value, element) => value + element) /
                        tasks.length)
                    .toString(),
              );
            }
          }
        } catch (e, stack) {
          yield OfflinePredictionsDownloadStatus(
            status: OfflinePredictionsDownloadStatusEnum.failed,
            message: "Download failed",
          );

          FirebaseCrashlytics.instance.recordError(e, stack);
          break;
        }
      }
    }
  }

  Future<Map<String, List<dynamic>?>> startTasks() async {
    Map<String, List<dynamic>?> tasks = {};

    if (!(await modelExists())) {
      String? modelID = await FlutterDownloader.enqueue(
        url: "https://images.fungid.app/fungid/mobile-model/$_modelName",
        savedDir: await _fullDataPath,
        fileName: _modelName,
        showNotification: true,
        openFileFromNotification: false,
      );

      if (modelID != null) {
        tasks.putIfAbsent(
          modelID,
          () => null,
        );
      }
    }

    if (!(await labelsExist())) {
      String? labelsID = await FlutterDownloader.enqueue(
        url: "https://images.fungid.app/fungid/mobile-model/$_labelsName",
        savedDir: await _fullDataPath,
        fileName: _labelsName,
        showNotification: true,
        openFileFromNotification: false,
      );

      if (labelsID != null) {
        tasks.putIfAbsent(
          labelsID,
          () => null,
        );
      }
    }

    return tasks;
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> _loadData() async {
    log('Loading model from $_dataPath');

    await Future.wait([
      PyTorchMobile.loadLocalModel(await _modelPath),
      File(await _labelsPath).readAsString(),
    ]).then((results) {
      imageModel = results[0] as Model;
      log('Model loaded');
      labels = (results[1] as String).split('\n');
      log('Found ${labels!.length} labels');
    });
  }
}

enum OfflinePredictionsDownloadStatusEnum {
  initialized,
  downloading,
  success,
  failed,
}

class OfflinePredictionsDownloadStatus {
  OfflinePredictionsDownloadStatusEnum status;
  String? message;

  OfflinePredictionsDownloadStatus({
    required this.status,
    this.message,
  });
}
