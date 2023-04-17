import 'package:flutter/material.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/styles/styles.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({super.key, required this.city, required this.hourData});

  final List<Hour> hourData;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              city,
              style: locationNameTextStyle,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hourData.length,
              itemBuilder: (context, i) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              hourData[i].time!.substring(11),
                              style: valueOnDailyScreenTextStyle,
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.temp_c),
                                  Text("${hourData[i].tempC}\u2103"),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!
                                      .feelslike_c),
                                  Text("${hourData[i].feelslikeC}\u2103"),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.windSpeed),
                                  Text(hourData[i].windKph.toString() +
                                      AppLocalizations.of(context)!.kmh),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.precip),
                                  Text('${hourData[i].precipMm} mm'),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.humidity),
                                  Text('${hourData[i].humidity} %'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
