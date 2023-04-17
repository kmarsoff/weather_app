import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_screen/bloc/weather_cubit.dart';
import 'package:weather/weather_screen/bloc/weather_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/weather_screen/view/daily_weather_widget.dart';
import 'package:weather/weather_screen/view/hourly_weather_widget.dart';

class WeatherScreenWidget extends StatelessWidget {
  const WeatherScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbfbfb),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'WEATHER APP',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: BlocBuilder<WeatherCubit, WeatherState>(
                  bloc: WeatherCubit(),
                  builder: (context, state) {
                    return DropdownButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text(AppLocalizations.of(context)!.daily),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text(AppLocalizations.of(context)!.hourly),
                          )
                        ],
                        onChanged: (v) {
                          context.read<WeatherCubit>().setIsDaily(v!);
                        });
                  }),
            ),
          )
        ],
      ),
      body: BlocBuilder(
          bloc: WeatherCubit(),
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedWeatherState) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: PageView(
                  controller: context.watch<WeatherCubit>().controller,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: i != 0
                                ? GestureDetector(
                                    onTap: () {
                                      context
                                          .read<WeatherCubit>()
                                          .navigateToPage(i, true);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 300,
                                      child: const Icon(
                                        Icons.chevron_left,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 84,
                              child: Column(
                                children: [
                                  Text(
                                    context.read<WeatherCubit>().getDay(i, context),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: context
                                              .read<WeatherCubit>()
                                              .getIsDaily()
                                          ? DailyWeatherWidget(
                                              index: i,
                                              city: state
                                                  .weatherData!.location!.name!,
                                              day: state.weatherData!.forecast!
                                                  .forecastday![i].day!)
                                          : HourlyWeatherWidget(
                                              city: state
                                                  .weatherData!.location!.name!,
                                              hourData: state
                                                  .weatherData!
                                                  .forecast!
                                                  .forecastday![i]
                                                  .hour!,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: i != 2
                                  ? GestureDetector(
                                      onTap: () {
                                        context
                                            .watch<WeatherCubit>()
                                            .navigateToPage(i, false);
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 300,
                                        child: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : const SizedBox()),
                        ],
                      )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('ERROR PAGE MUST BE HERE'));
            }
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  
}
