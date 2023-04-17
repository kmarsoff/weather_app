import 'package:geolocator/geolocator.dart';

Future<List<double>> getLocation() async {
  try {
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return [position.latitude, position.longitude];
  } on Exception {
    //Kiyv location
    return [50.450001, 30.523333];
  }
}