import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';

final apiKey = dotenv.env['weather_api_key'];
final openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
final openWeatherMapUrlOneCall =
    "https://api.openweathermap.org/data/2.5/onecall";

class WeatherModel {
  WeatherModel({this.latitude, this.longitude});
  double? latitude;
  double? longitude;
  Future<dynamic> getCityWeather(String cityName) async {
    final url =
        Uri.parse("$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      final position = await location.getCurrentLocation();
      print(position.latitude);
      print(position.longitude);
      latitude = position.latitude;
      longitude = position.longitude;
      final url = Uri.parse(
          "$openWeatherMapUrl?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric");

      NetworkHelper networkHelper = NetworkHelper(url);
      print("url: $url");
      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (error) {
      print("Location Denied Error:${error.toString()}");
      print("Location Denied Error Object:${error}");
    }
  }

  Future<dynamic> getLocationWeatherOneCall() async {
    Location location = Location();
    await location.getCurrentLocation();
    final oneCallUrl = Uri.parse(
        "$openWeatherMapUrlOneCall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(oneCallUrl);
    var oneCallWeatherData = await networkHelper.getData();
    return oneCallWeatherData;
  }
}
