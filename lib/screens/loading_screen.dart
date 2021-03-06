import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    try {
      WeatherModel weatherModel = WeatherModel();
      var weatherData = await weatherModel.getLocationWeather();
      var oneCallData = await weatherModel.getLocationWeatherOneCall();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen(weatherData, oneCallData);
      }));
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xff6300B4),
      ),
    );
  }
}
