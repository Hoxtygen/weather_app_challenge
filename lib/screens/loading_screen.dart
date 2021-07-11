import 'package:flutter/material.dart';
import 'package:weather_app_challenge/screens/home_screen.dart';
import 'package:weather_app_challenge/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    var oneCallData = await weatherModel.getLocationWeatherOneCall();


    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(weatherData, oneCallData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
