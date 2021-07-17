import 'package:flutter/material.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class City extends StatefulWidget {
  City({
    this.weatherResult,
    this.cityName,
  });
  final weatherResult;
  final cityName;

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  late int temperature;
  late String weatherDescription;
  @override
  void initState() {
    super.initState();
    upddateUI(widget.weatherResult);
  }

  upddateUI(dynamic weatherInfo) {
    setState(() {
      if (weatherInfo != null) {
        double temp = weatherInfo["main"]["temp"];
        temperature = temp.toInt();
        weatherDescription = weatherInfo["weather"][0]["description"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 100,
      width: (MediaQuery.of(context).size.width / 1.2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(35)),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.cityName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mapIconToImage(widget.weatherResult["weather"][0]["icon"]),
                    Text(
                      temperature.toString() + "\u00B0\u1d9c",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  normaliseName(weatherDescription),
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                     fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
