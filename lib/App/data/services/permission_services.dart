// import 'package:permission_handler/permission_handler.dart';

// class PermissionServices {
//   /// Request necessary permissions
//   Future<bool> requestPermissions() async {
//     final statuses = await [
//       Permission.camera,
//       Permission.photos,
//       Permission.videos,
//     ].request();

//     if (statuses[Permission.camera]?.isGranted != true) {
//       return false;
//     }

//     if (await Permission.photos.isGranted ||
//         await Permission.videos.isGranted) {
//       return true;
//     }

//     if (await Permission.storage.isGranted) {
//       return true;
//     }

//     return false;

//     // if (await Permission.camera.isPermanentlyDenied) {
//     //   openAppSettings();
//     // }

//     // return statuses.values.every((status) => status.isGranted);
//   }
// }
