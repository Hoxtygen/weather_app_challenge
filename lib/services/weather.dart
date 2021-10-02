import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/model/current_weather_model.dart';
import 'package:weather_app_challenge/model/forecast_model.dart';
import 'package:weather_app_challenge/services/location.dart';
import 'package:weather_app_challenge/services/networking.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// you can remove the $apiKey variable and  uncomment line 11 and line 6 above
// to make use of the key in the env file. Note that you will have to create your
// own env file and put your api key
// final apiKey = dotenv.env['weather_api_key'];

// showing the api key is intentional, it's  so that anyone can test this
// app without having to register with openweathermap to get own api key.
const apiKey = "be7a9eaa123d662f550405bc335bc372";

const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
const openWeatherMapUrlOneCall =
    "https://api.openweathermap.org/data/2.5/onecall";

class WeatherModel {
  // get the weather condition of a given city
  Future<CurrentCityWeatherModel> getCityWeather(CityModel city) async {
    final cityName = city.cityName;
    final url =
        Uri.parse("$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return CurrentCityWeatherModel.fromDailyJson(weatherData);
  }

// get the weather condition of current location using longitude and latitude
  Future<CurrentWeatherModel> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocationCoordinate();
    final url = Uri.parse(
        "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return CurrentWeatherModel.fromDailyJson(weatherData);
  }

// get daily/hourly data of current location using current longitude and latitude
  Future<ForecastModel> getLocationWeatherOneCall() async {
    Location location = Location();
    await location.getCurrentLocationCoordinate();
    final oneCallUrl = Uri.parse(
        "$openWeatherMapUrlOneCall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(oneCallUrl);
    var oneCallWeatherData = await networkHelper.getData();
    return ForecastModel.fromJson(oneCallWeatherData);
  }
}
