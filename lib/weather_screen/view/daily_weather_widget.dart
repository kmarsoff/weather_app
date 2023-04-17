import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/weather_screen/model/weather_data_model.dart';
import 'package:weather/styles/styles.dart';


class DailyWeatherWidget extends StatefulWidget {
  const DailyWeatherWidget(
      {super.key, required this.day, required this.city, required this.index});
  final Day day;
  final String city;
  final int index;

  @override
  State<DailyWeatherWidget> createState() => _DailyWeatherWidgetState();
}

class _DailyWeatherWidgetState extends State<DailyWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDayDetails(widget.day),
      child: Center(
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 17,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.city.toUpperCase(),
                      style: locationNameTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.maxTemp,
                        style: keyOnDailyScreenTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.day.maxtempC} \u2103",
                        style: valueOnDailyScreenTextStyle
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.minTemp,
                        style: keyOnDailyScreenTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.day.mintempC} \u2103",
                        style: valueOnDailyScreenTextStyle
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  showDayDetails(Day day) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.maxTemp),
                          Text("${day.maxtempC}\u2103"),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.minTemp),
                          Text("${day.mintempC}\u2103"),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.windSpeed),
                          Text(day.maxwindKph.toString() +
                              AppLocalizations.of(context)!.kmh),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.precip),
                          Text('${day.totalprecipMm} mm'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.humidity),
                          Text('${day.avghumidity} %'),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
