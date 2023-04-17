import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../repository/repository.dart';
import 'weather_states.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(LoadingWeatherState()) {
    fetchWeather();
  }

  bool isDaily = true;
  WeatherData? weatherData;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }

  Future<void> fetchWeather() async {
    weatherData = await getWeatherData();
    if (weatherData != null) {
      emit(LoadedWeatherState(weatherData!));
    } else {
      emit(ErrorWeatherState());
    }
  }

  void setIsDaily(bool v) {
    isDaily = v;
    emit(LoadingWeatherState());
  }

  bool getIsDaily() {
    emit(LoadedWeatherState(weatherData));
    return isDaily;
  }

  void navigateToPage(int i, bool isForward) {
    if(isForward){
      controller.animateToPage(i - 1,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      controller.animateToPage(i + 1,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  String getDay(int i, BuildContext context) {
    switch (i) {
      case 0:
        return AppLocalizations.of(context)!.today;
      case 1:
        return AppLocalizations.of(context)!.tomorrow;
      case 2:
        return AppLocalizations.of(context)!.aftertomorrow;
      default:
        return '';
    }
  }
}
