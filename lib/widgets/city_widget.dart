import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/services/weather.dart';
import 'package:weather_app_challenge/widgets/city.dart';
import 'package:weather_app_challenge/widgets/city_error.dart';

class CityWidget extends StatelessWidget {
  const CityWidget(this.city, {Key? key}) : super(key: key);
  final CityModel city;

  getCityWeather() {
    WeatherModel weatherModel = WeatherModel();
    var cityWeather = weatherModel.getCityWeather(city);
    return cityWeather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context,
          AsyncSnapshot<CurrentCityWeatherModel> snapshot) {
        if (snapshot.hasError) {
          return CityError(error: snapshot.error.toString(), cityName: city);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return City(weatherResult: snapshot.data, cityName: city);
          default:
            return Container();
        }
      },
      future: getCityWeather(),
    );
  }
}
