import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';


WeatherData? getOldDataFromSharedPreferences(String? string) {
  if (string != null) {
    var map = jsonDecode(string);
    var data = WeatherData.fromJson(map);
    return data;
  }
  return null;
}

void saveDataToSharedPrefernces(Map<String, dynamic> json, SharedPreferences prefs) async {
  String dataToStore = jsonEncode(WeatherData.fromJson(json));
  prefs.setString('lastData', dataToStore);
}