import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();

const String url = 'https://api.weatherapi.com';
const String apiPath = '/v1/forecast.json';
const String key = '2a1522d5b0694b36821200032231404';
int days = 3; 
late SharedPreferences sharedPreferences;