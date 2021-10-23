import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/current_weather_model.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/screens/hourly_forecast_view.dart';
import 'package:weather_app_challenge/screens/location_screen.dart';
import 'package:weather_app_challenge/utils/constants.dart';
import 'package:weather_app_challenge/widgets/current_weather_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      this.locationWeatherReport, this.oneCallLocationWeatherReport,
      {Key? key})
      : super(key: key);
  final CurrentWeatherModel locationWeatherReport;
  final ForecastModel oneCallLocationWeatherReport;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int temperature;
  late String cityName;
  late String weatherDescription;
  late String date;
  late List<HourlyForecast> todayHourly;
  late List<HourlyForecast> tomorrowTempHourly;

  @override
  void initState() {
    super.initState();
    updateWeatherReport(widget.locationWeatherReport);
    updateOneCallWeatherReport(widget.oneCallLocationWeatherReport);
  }

  updateWeatherReport(dynamic weatherInfo) {
    setState(() {
      temperature = weatherInfo.temp;
      cityName = weatherInfo.cityName;
      weatherDescription = weatherInfo.description;
      date = weatherInfo.date;
    });
  }

  convert(date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
  }

  updateOneCallWeatherReport(dynamic oneCallWeatherInfo) {
    setState(() {
      var now = DateTime.now();
      var nextMidnight = DateTime(now.year, now.month, now.day + 1);
      List<HourlyForecast> items = oneCallWeatherInfo.hourlyData;
      todayHourly = items
          .where((element) => convert(element.time).isBefore(nextMidnight))
          .toList()
          .skip(2)
          .take(3)
          .toList();

      tomorrowTempHourly = items
          .where((element) => convert(element.time).isAfter(nextMidnight))
          .toList()
          .take(3)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPurple,
                  kBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cityName.toUpperCase(),
                        style: TextStyle(
                          fontSize: width * 0.06,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      PopupMenuButton(
                        color: kPurple,
                        shape: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        iconSize: width * 0.06,
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Manage Cities",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width*0.03,
                                  ),
                                ),
                              ],
                            ),
                            value: "Add cities",
                          )
                        ],
                        onSelected: (choice) {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LocationScreen(),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
                CurrentWeatherView(
                  temperature: temperature,
                  currentDate: date,
                  description: weatherDescription,
                ),
                HourlyForecastView(
                  todayHourly: todayHourly,
                  tomorrowTempHourly: tomorrowTempHourly,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
