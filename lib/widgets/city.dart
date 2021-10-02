import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class City extends StatelessWidget {
  const City({Key? key, 
    required this.weatherResult,
    required this.cityName,
  }) : super(key: key);
  final weatherResult;
  final CityModel cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 100,
      width: (MediaQuery.of(context).size.width / 1.2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius:const BorderRadius.all(Radius.circular(35)),
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
              style: const TextStyle(
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
                    mapIconToImage(weatherResult.icon),
                    Text(
                      weatherResult.temp.toString() + "\u00B0\u1d9c",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  normaliseName(weatherResult.description),
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
