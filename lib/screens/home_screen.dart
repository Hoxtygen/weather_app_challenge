import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/screens/location_screen.dart';
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
      temperature = weatherInfo.temp;
      cityName = weatherInfo.cityName;
      weatherDescription = weatherInfo.description;
      date = weatherInfo.date;
    });
  }

  convert(date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
  }

  updateOneCallWeatherReport(ForecastModel oneCallWeatherInfo) {
    print(oneCallWeatherInfo);
    setState(() {
      var now = DateTime.now();
      var nextMidnight = DateTime(now.year, now.month, now.day + 1);
      List items = oneCallWeatherInfo.hourly;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                          child: Text("Manage Cities"),
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
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${temperature.toString()}\u00B0\u1d9c",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white38,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(-1.5, -1.5),
                            color: Color(0xffBFA6E8),
                          ),
                          Shadow(
                            offset: Offset(1.5, -1.5),
                            color: Color(0xffBFA6E8),
                          ),
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            color: Color(0xff7E59C9),
                          ),
                          Shadow(
                            offset: Offset(-1.5, 1.5),
                            color: Color(0xff7E59C9),
                          ),
                        ],
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
