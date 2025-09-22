// import 'package:geolocator/geolocator.dart';

// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission locationPermission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();

//   if (!serviceEnabled) {
//     return Future.error("Location Services are not Enabled");
//   }

//   locationPermission = await Geolocator.requestPermission();
//   if (locationPermission == LocationPermission.denied) {
//     locationPermission = await Geolocator.requestPermission();
//     if (locationPermission == LocationPermission.denied) {
//       return Future.error("Location Permission is denied");
//     }
//   }
//   if (locationPermission == LocationPermission.deniedForever) {
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.',
//     );
//   }

//   return await Geolocator.getCurrentPosition();
// }
