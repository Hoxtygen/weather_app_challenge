import 'package:flutter/material.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class CurrentWeatherView extends StatelessWidget {
  const CurrentWeatherView({
    Key? key,
    required this.temperature,
    required this.currentDate,
    required this.description,
  }) : super(key: key);
  final num temperature;
  final String description;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                normaliseName(description),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  currentDate,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${temperature.toString()}\u00B0\u1d9c",
            style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w700,
              color: Colors.white38,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(-1.5, -1.5),
                  color: Color(0xffBFA6E8),
                ),
                Shadow(
                  offset: Offset(1.5, -1.5),
                  color: Color(0xffBFA6E8),
                ),
                Shadow(
                  offset: Offset(1.5, 1.5),
                  color: Color(0xff7E59C9),
                ),
                Shadow(
                  offset: Offset(-1.5, 1.5),
                  color: Color(0xff7E59C9),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
