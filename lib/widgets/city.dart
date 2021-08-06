import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class City extends StatelessWidget {
  City({
    this.weatherResult,
    required this.cityName,
  });
  final dynamic weatherResult;
  final CityModel cityName;

  @override
  Widget build(BuildContext context) {
    late int? temperature;

    if (weatherResult['cod'] == 200) {
      num temp = weatherResult["main"]["temp"];
      temperature = temp.toInt();
    }

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
              normaliseName(cityName.cityName),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            weatherResult['cod'] == 200
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          mapIconToImage(weatherResult["weather"][0]["icon"]),
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
                        normaliseName(weatherResult != null
                            ? weatherResult["weather"][0]["description"]
                            : "--"),
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  )
                : Text(
                    normaliseName(weatherResult["message"]),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
