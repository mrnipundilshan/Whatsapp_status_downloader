import 'dart:developer';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constant.dart';

bool A = false;

class GetSavedProvider extends ChangeNotifier {
  List<FileSystemEntity> _getSaved = [];

  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getSaved => _getSaved;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getSavedStatus() async {
    var photosStatus = await Permission.photos.status;
    var storageStatus = await Permission.manageExternalStorage.status;
    final directory = Directory(AppContants.Saved_PATH);
    if (directory.existsSync()) {
      final itemss = directory.listSync();
      if (itemss.isNotEmpty) {
        A = true;
      }
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var androidVersion = 'Android ${androidInfo.version.release}';

    if (androidVersion == "Android 12" ||
        androidVersion == "Android 12L" ||
        androidVersion == "Android 11") {
      var status1 = await Permission.storage.request();
    }

    if (androidVersion == "Android 13" || androidVersion == "Android 14") {
      if (!photosStatus.isGranted) {
        photosStatus = await Permission.photos.request();
        if (!photosStatus.isGranted) {
          //Handle denied permission if necessary
          log("Photos Permission Denied");
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
          // Handle denied permission if necessary
          log("Storage Permission Denied");
          return;
        }
      }
    }

    final directoryyy = Directory(AppContants.Saved_PATH);

    if (directoryyy.existsSync()) {
      final itemsss = directory.listSync();

      _getSaved = itemsss
          .where((element) =>
              element.path.endsWith(".mp4") || element.path.endsWith(".jpg"))
          .toList();
      _getSaved.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      notifyListeners();

      _isWhatsappAvailable = true;
      notifyListeners();

      log(itemsss.toString());
    } else {
      log("No Whatsapp found");
      _isWhatsappAvailable = false;
      notifyListeners();
    }
  }
}
