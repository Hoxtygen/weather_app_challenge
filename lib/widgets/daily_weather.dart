import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class DailyWeather extends StatelessWidget {
   const DailyWeather(this.weather, {Key? key}) : super(key: key);
  final HourlyForecast weather;
  convert(date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
  }

  @override
  Widget build(BuildContext context) {
    final hour = convert(weather.time);
    final hourlyTime = DateFormat.Hm().format(hour);
    final temp = weather.temperature.toInt();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.white30,
            width: 2.0,
          ),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hourlyTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              mapIconToImage(weather.icon),
              Text(
                normaliseName(weather.description),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Padding(
                 padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "${temp.toString()}\u00B0\u1d9c",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
