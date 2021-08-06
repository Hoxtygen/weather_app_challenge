import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/services/weather.dart';
import 'package:weather_app_challenge/widgets/city.dart';

import 'city_error.dart';

class CityWidget extends StatelessWidget {
  CityWidget(this.city);
  final CityModel city;

  getCityWeather() {
    WeatherModel weatherModel = WeatherModel();
    var cityWeather = weatherModel.getCityWeather(city);
    return cityWeather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return City(weatherResult: snapshot.data, cityName: city);
        } else {
          return Text("Fetching weather data ....");
        }
      },
      future: getCityWeather(),
    );
  }
}
