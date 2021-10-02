import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';
import 'dart:io';



final apiKey = dotenv.env['weather_api_key'];
const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

class HomeScreenViewModel extends ChangeNotifier {
  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocationCoordinate();
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
}
