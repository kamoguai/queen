import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

///
///device 權限申請
class PermissionHelper {
  static VoidCallback defaultCall = () {};

  static void check(List<Permission> permissionList,
      {String? errMsg,
      VoidCallback? onSuccess,
      VoidCallback? onFailed,
      VoidCallback? onOpenSetting}) async {
    bool flag = true;
    for (var value in permissionList) {
      var status = await value.status;
      if (!status.isGranted) {
        flag = false;
        break;
      }
    }
    if (!flag) {
      PermissionStatus permissionStatus =
          await requestPermission(permissionList);
      if (permissionStatus.isGranted) {
        onSuccess != null ? onSuccess() : defaultCall();
      } else if (permissionStatus.isDenied) {
        onFailed != null ? onFailed() : defaultCall();
      } else if (permissionStatus.isPermanentlyDenied) {
        onOpenSetting != null ? onOpenSetting() : defaultCall();
      } else if (permissionStatus.isRestricted) {
        ///ios
        onOpenSetting != null ? onOpenSetting() : defaultCall();
      } else if (permissionStatus.isLimited) {
        ///ios
        onOpenSetting != null ? onOpenSetting() : defaultCall();
      }
    }
  }

  static Future<PermissionStatus> requestPermission(
      List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }
}
