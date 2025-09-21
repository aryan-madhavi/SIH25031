import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AppControllers {
  final ImagePicker _picker = ImagePicker();
  // final permissionServices = PermissionServices();

  /// Pick a file from device storage
  Future<File?> pickFileFromStorage() async {
    //if (!await permissionServices.requestPermissions()) return null;

    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  /// Capture image from camera
  Future<File?> pickImageFromCamera() async {
    //if (!await permissionServices.requestPermissions()) return null;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
