import 'package:permission_handler/permission_handler.dart';

class PermissionServices {
  /// Request necessary permissions
  Future<bool> requestPermissions() async {
    final statuses = await [Permission.camera, Permission.storage].request();

    if (await Permission.camera.isPermanentlyDenied) {
      openAppSettings();
    }

    return statuses.values.every((status) => status.isGranted);
  }
}
