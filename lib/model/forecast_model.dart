import 'package:weather_app_challenge/model/weather_model.dart';

class ForecastModel {
  ForecastModel({
    required this.lastUpdated,
    required this.longitude,
    required this.latitude,
    this.daily: const [],
    required this.current,
    this.city,
    required this.isDayTime,
  });
  final DateTime lastUpdated;
  final double longitude;
  final double latitude;
  final List<WeatherModel> daily;
  final WeatherModel current;
  final bool isDayTime;
  String? city;

  static ForecastModel fromJson(dynamic json) {
    var weather = json["current"]["weather"][0];
    var date = DateTime.fromMillisecondsSinceEpoch(json["current"]["dt"] * 1000,
        isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);
    // get the forecast for the next 3 days, excluding the current day
    bool hasDaily = json['daily'] != null;
    var tempDaily = [];
    if (hasDaily) {
      List items = json['daily'];
      tempDaily = items
          .map((item) => WeatherModel.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
    }

    var currentForcast = WeatherModel(
        cloudiness: int.parse(json['current']['clouds'].toString()),
        temp: json['current']['temp'].toDouble(),
        condition: WeatherModel.mapStringToWeatherCondition(
            weather['main'], int.parse(json['current']['clouds'].toString())),
        description: weather['description'],
        feelLikeTemp: json['current']['feels_like'],
        date: date);

    return ForecastModel(
      lastUpdated: DateTime.now(),
      current: currentForcast,
      latitude: json['lat'].toDouble(),
      longitude: json['lon'].toDouble(),
      // daily: tempDaily,
      isDayTime: isDay,
    );
  }
}
