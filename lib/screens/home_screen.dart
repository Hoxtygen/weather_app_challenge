import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/screens/location_screen.dart';
import 'package:weather_app_challenge/utils/constants.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';
import 'package:weather_app_challenge/widgets/circle_tab.dart';
import 'package:weather_app_challenge/widgets/current_weather_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      this.locationWeatherReport, this.oneCallLocationWeatherReport,
      {Key? key})
      : super(key: key);
  final locationWeatherReport;
  final oneCallLocationWeatherReport;
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
    // print(oneCallWeatherInfo);
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
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          child: Text("Manage Cities"),
                          value: "Add cities",
                        )
                      ],
                      onSelected: (choice) {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationScreen()),
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
              Expanded(
                child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              labelColor: Colors.white,
                              indicator: CircleTabIndicator(
                                  color: Colors.greenAccent, radius: 5),
                              labelPadding: const EdgeInsets.all(12),
                              indicatorColor: Colors.yellowAccent,
                              isScrollable: true,
                              unselectedLabelColor: Colors.white60,
                              tabs: const [
                                Text(
                                  "Today",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Tomorrow",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                buildHourlySummary(todayHourly),
                                buildHourlySummary(tomorrowTempHourly),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
