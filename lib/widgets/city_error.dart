import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';

class CityError extends StatelessWidget {
  const CityError({Key? key, 
   required this.error,
    required this.cityName,
  }) : super(key: key);
  final String error;
  final CityModel cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 100,
      width: (MediaQuery.of(context).size.width / 1.2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
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
              cityName.cityName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(error),
          ],
        ),
      ),
    );
  }
}
