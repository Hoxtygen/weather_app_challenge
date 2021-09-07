import 'package:intl/intl.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.description,
    required this.date,
    required this.temp,
    required this.cityName
  });
  final String description;
  final num temp;
  final String date;
  final String cityName;

  static CurrentWeatherModel fromDailyJson(dynamic daily) {
    var weather = daily["weather"][0];
    var weatherDate =
        DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000, isUtc: true);
    return CurrentWeatherModel(
      description: normaliseName(weather['description']),
      temp: daily["main"]["temp"].toInt(),
      date: DateFormat.MMMMEEEEd().format(weatherDate),
      cityName: daily["name"],
    );
  }
}
