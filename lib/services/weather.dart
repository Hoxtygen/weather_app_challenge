import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';

// final apiKey = DotEnv().env["weather_api_key"];
final apiKey = "087bd0e058e42120e899391144db8f16";
final openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
final openWeatherMapUrlOneCall = "https://api.openweathermap.org/data/2.5/onecall";
// ?lat=16.7666&lon=-3.0026&appid=087bd0e058e42120e899391144db8f16&exclude=minutely&units=metric

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    final url =
        Uri.parse("$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    final url = Uri.parse(
        "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    // print(weatherData);
    return weatherData;
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

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
