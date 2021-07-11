import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';


class DailyWeather extends StatelessWidget {
  DailyWeather(this.weather);
  final weather;
  convert(date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
  }

  @override
  Widget build(BuildContext context) {
    final hour = convert(this.weather["dt"]);
    final hourlyTime = DateFormat.Hm().format(hour);
    final temp = this.weather["temp"].toInt();
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.white30,
            width: 2.0,
          ),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hourlyTime,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              mapIconToImage(this.weather["weather"][0]["icon"]),
              Text(
                this.weather["weather"][0]["description"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontWeight:FontWeight.w700,
                  fontSize:20,
                ),
              ),
              Text(
                "${temp.toString()}\u00B0\u1d9c",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
