import 'dart:io';
import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// you can remove the $apiKey variable and  uncomment line 10 and line 5 above
// to make use of the key in the env file. Note that you will have to create your
// own env file and put your api key
// final apiKey = dotenv.env['weather_api_key'];

// showing the api key is intentional, it's  so that anyone can test this
// app without having to register with openweathermap to get own api key.
final apiKey = "be7a9eaa123d662f550405bc335bc372";

final openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
final openWeatherMapUrlOneCall =
    "https://api.openweathermap.org/data/2.5/onecall";

class WeatherModel {
  // get the weathere condition of a given city
  Future<CurrentCityWeatherModel> getCityWeather(CityModel city) async {
    final cityName = city.cityName;
    final url =
        Uri.parse("$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return CurrentCityWeatherModel.fromDailyJson(weatherData);
  }

// get the weather condition of current location using longitude and latitude
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

// get daily/hourly data of current location using current longitude and latitude
  Future<dynamic> getLocationWeatherOneCall() async {
    Location location = Location();
    await location.getCurrentLocationCoordinate();
    final oneCallUrl = Uri.parse(
        "$openWeatherMapUrlOneCall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(oneCallUrl);
    var oneCallWeatherData = await networkHelper.getData();
    return oneCallWeatherData;
  }
}
