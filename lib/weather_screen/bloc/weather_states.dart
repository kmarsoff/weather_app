import 'package:equatable/equatable.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';

abstract class WeatherState extends Equatable{}

class LoadingWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class LoadedWeatherState extends WeatherState {
  LoadedWeatherState(this.weatherData);
  final WeatherData? weatherData;

  @override
  List<Object> get props => [];
}

class ErrorWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}
