import 'dart:io';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';

// final apiKey = dotenv.env['weather_api_key'];
final apiKey = "be7a9eaa123d662f550405bc335bc372";

final openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
final openWeatherMapUrlOneCall =
    "https://api.openweathermap.org/data/2.5/onecall";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      final url = Uri.parse(
          "$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
      NetworkHelper networkHelper = NetworkHelper(url);
      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      final url = Uri.parse(
          "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

      NetworkHelper networkHelper = NetworkHelper(url);
      var weatherData = await networkHelper.getData();

      return weatherData;
    } on SocketException catch (_) {
      throw Exception(
          "Connection timed out. Check your internet connection and try again");
    } catch (e) {
      return e.toString();
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
