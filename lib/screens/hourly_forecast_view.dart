import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';
import 'package:weather_app_challenge/widgets/circle_tab.dart';

class HourlyForecastView extends StatelessWidget {
  const HourlyForecastView({
    Key? key,
    required this.todayHourly,
    required this.tomorrowTempHourly,
  }) : super(key: key);
  final List<HourlyForecast> todayHourly;
  final List<HourlyForecast> tomorrowTempHourly;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  indicator:
                      CircleTabIndicator(color: Colors.greenAccent, radius: 5),
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
        ),
      ),
    );
  }
}
