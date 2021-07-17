import 'package:flutter/material.dart';
import 'package:weather_app_challenge/services/weather.dart';
import 'package:weather_app_challenge/widgets/city.dart';

class CityWidget extends StatefulWidget {
  CityWidget(this.cityName);
  final cityName;

  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  late Future cityWeatherData;

  getCityWeather() {
    WeatherModel weatherModel = WeatherModel();
    var cityWeather = weatherModel.getCityWeather(widget.cityName);
    return cityWeather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return City(weatherResult: snapshot.data, cityName: widget.cityName);
        } else {
          return Container(
            height: 20.0,
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
      },
      future: getCityWeather(),
    );
  }
}
