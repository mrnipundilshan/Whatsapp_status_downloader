import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constant.dart';
import 'package:device_info/device_info.dart';

bool A = false;

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  List<FileSystemEntity> itemss = [];
  List<FileSystemEntity> items = [];
  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {
    var photosStatus = await Permission.photos.status;
    var storageStatus = await Permission.manageExternalStorage.status;

    Future<void> createFolder() async {
      if (await Directory(AppContants.WHATSAPP_BUSI_PATH).exists()) {
      } else {
        await Directory(AppContants.WHATSAPP_BUSI_PATH).create(recursive: true);
      }
      if (await Directory(AppContants.WHATSAPP_PATH).exists()) {
      } else {
        await Directory(AppContants.WHATSAPP_PATH).create(recursive: true);
      }
    }

    createFolder();

    var directory = Directory(AppContants.WHATSAPP_PATH);
    var directory2 = Directory(AppContants.WHATSAPP_BUSI_PATH);

    if (directory.existsSync() || directory2.existsSync()) {
      if (directory.existsSync()) {
        itemss.addAll(directory.listSync());
      }
      if (directory2.existsSync()) {
        itemss.addAll(directory2.listSync());
      }

      if (itemss.isNotEmpty) {
        A = true;
      }
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var androidVersion = 'Android ${androidInfo.version.release}';
    // ignore: unrelated_type_equality_checks

    if (androidVersion == "Android 12" ||
        androidVersion == "Android 12L" ||
        androidVersion == "Android 11") {
      var status1 = await Permission.storage.request();
    }

    if (androidVersion == "Android 13" || androidVersion == "Android 14") {
      if (!photosStatus.isGranted) {
        photosStatus = await Permission.photos.request();

        if (!photosStatus.isGranted) {
          return;
        }
      }
    }

    if (A == false) {
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.manageExternalStorage.request();
        if (!storageStatus.isDenied) {
          A = true;
        }
        if (!storageStatus.isGranted) {
          return;
        }
      }
    }

    final directoryy = Directory(AppContants.WHATSAPP_PATH);
    final directoryy2 = Directory(AppContants.WHATSAPP_BUSI_PATH);

    if (directoryy.existsSync() || directoryy2.existsSync()) {
      Set<String> uniquePaths = {};
      if (directoryy.existsSync()) {
        uniquePaths
            .addAll(directoryy.listSync().map((element) => element.path));
      }
      if (directoryy2.existsSync()) {
        uniquePaths
            .addAll(directoryy2.listSync().map((element) => element.path));
      }

      items = uniquePaths.map((path) => File(path)).toList();
      items
          .sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));

      if (ext == ".mp4") {
        _getVideos =
            items.where((element) => element.path.endsWith(".mp4")).toList();

        notifyListeners();
      }
      if (ext == ".jpg") {
        _getImages =
            items.where((element) => element.path.endsWith(".jpg")).toList();

        notifyListeners();
      }
      _isWhatsappAvailable = true;
      notifyListeners();

      // log(items.toString());
    } else {
      _isWhatsappAvailable = false;
      notifyListeners();
    }
  }
}
