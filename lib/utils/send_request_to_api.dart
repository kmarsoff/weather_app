import 'package:dio/dio.dart';
import 'package:weather/config.dart';
import 'package:weather/utils/save_read_data_from_prefs.dart';
import 'package:weather/weather_screen/repository/repository.dart';

final dio = Dio();

Future<Response?>? sendRequestToApi(List<double> coordinates) async {
  Response? response;
  try {
    response = await dio.get(
      '$url$apiPath',
      queryParameters: {
        'key': key,
        'q': '${coordinates[0].toString()},${coordinates[1].toString()}',
        'aqi': 'no',
        'alerts': 'no',
        'days': days,
      },
    );
  } catch (e) {
    data = getOldDataFromSharedPreferences(
        sharedPreferences.getString('lastData'));
  }
  return response;
}
