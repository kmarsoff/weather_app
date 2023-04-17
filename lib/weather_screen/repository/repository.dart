import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/config.dart';
import 'package:weather/utils/send_request_to_api.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';
import 'package:weather/utils/get_location.dart';
import 'package:weather/utils/save_read_data_from_prefs.dart';

Response? response;
WeatherData? data;

Future<WeatherData?> getWeatherData() async {
  sharedPreferences = await SharedPreferences.getInstance();
  List<double>? coordinates;
  LocationPermission? permission =
      await Geolocator.requestPermission().then((value) async {
    if (value.name != LocationPermission.denied &&
        value.name != LocationPermission.deniedForever &&
        value.name != LocationPermission.unableToDetermine) {
      coordinates = await getLocation();
    }
  });
  if (coordinates != null) {
    response = await sendRequestToApi(coordinates!);
    if (response != null) {
      data = WeatherData.fromJson(response!.data);
      saveDataToSharedPrefernces(data!.toJson(), sharedPreferences);
    }

    //Так как апи возвращает все только ан английском, предусмотрено использование гугл-переводчика

    //   await translator
    //     .translate(data!.location!.name!,
    //         from: 'en', to: 'ru')
    //     .then((value) {
    //   data!.location!.name = value.text;
    // });
    return data;
  }
}

