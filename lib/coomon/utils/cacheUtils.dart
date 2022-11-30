import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class Utils {
  ///訪問系統權限
  static Future<void> requestPermission(FileSystemEntity file) async {
    PermissionStatus status = await Permission.storage.status;

    await delDir(file);
  }

  ///刪除資料夾
  static Future<void> delDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity> children =
          file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
    } catch (e) {
      print(e);
    }
  }

  ///取得資料夾檔案大小
  static Future getTotalSizeOfFileInDir(final FileSystemEntity file) async {
    print(file.path);
    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List children = file.listSync();
      double total = 0.0;
      if (children.isNotEmpty) {
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFileInDir(child);
        }
        return total;
      }
    }
    return 0.0;
  }

  /// render 物件大小
  static String renderSize(value) {
    if (value == null) {
      return '0.0';
    }
    List<String> unitArr = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');

    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toString();
    return size + unitArr[index];
  }
}
