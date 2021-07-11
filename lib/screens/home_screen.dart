import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_challenge/screens/location_screen.dart';
import 'package:weather_app_challenge/services/weather.dart';
import 'package:weather_app_challenge/utils/constants.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';
import 'package:weather_app_challenge/widgets/circle_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.locationWeatherReport, this.oneCallLocationWeatherReport);
  final locationWeatherReport;
  final oneCallLocationWeatherReport;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  WeatherModel oneCallWeather = WeatherModel();
  late int temperature;
  late String cityName;
  late String weatherDescription;
  late String weatherIcon;
  late List hourly;
  late String date;
  late List todayHourly;
  late List tomorrowTempHourly;

  @override
  void initState() {
    super.initState();
    updateWeatherReport(widget.locationWeatherReport);
    updateOneCallWeatherReport(widget.oneCallLocationWeatherReport);
  }

  updateWeatherReport(dynamic weatherInfo) {
    setState(() {
      double temp = weatherInfo["main"]["temp"];
      temperature = temp.toInt();
      cityName = weatherInfo["name"];
      var condition = weatherInfo["weather"][0]["id"];
      weatherIcon = weather.getWeatherIcon(condition);
      // weatherDescription = weather.getMessage(temperature);
      weatherDescription = weatherInfo["weather"][0]["description"];
      var weatherDate = DateTime.fromMillisecondsSinceEpoch(
          weatherInfo["dt"] * 1000,
          isUtc: false);
      date = DateFormat.MMMMEEEEd().format(weatherDate);
    });
  }

  convert(date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
  }

  updateOneCallWeatherReport(dynamic oneCallWeatherInfo) {
    setState(() {
      hourly = oneCallWeatherInfo["hourly"];
      bool hasHourly = oneCallWeatherInfo['hourly'] != null;
      var now = DateTime.now();
      var nextMidnight = DateTime(now.year, now.month, now.day + 1);

      if (hasHourly) {
        List items = oneCallWeatherInfo["hourly"];
        todayHourly = items
            .where((element) => convert(element["dt"]).isBefore(nextMidnight))
            .toList()
            .skip(2)
            .take(3)
            .toList();

        tomorrowTempHourly = items
            .where((element) => convert(element["dt"]).isAfter(nextMidnight))
            .toList()
            .take(3)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // color: Color(0xff6b58c9),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kPurple,
                kBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cityName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Text("Add Cities"),
                          value: "Add cities",
                        )
                      ],
                      onSelected: (choice) {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen()),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          normaliseName(weatherDescription),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            date,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize:16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${temperature.toString()}\u00B0\u1d9c",
                      style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white38,
                      ),
                    )
                  ],
                ),
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
                              labelPadding: EdgeInsets.all(12),
                              indicatorColor: Colors.yellowAccent,
                              isScrollable: true,
                              unselectedLabelColor: Colors.white60,
                              tabs: [
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
                              child: TabBarView(children: [
                            buildHourlySummary(todayHourly),
                            buildHourlySummary(tomorrowTempHourly),
                          ]))
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
