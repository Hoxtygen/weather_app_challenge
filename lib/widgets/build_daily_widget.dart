import 'package:flutter/cupertino.dart';
import 'package:weather_app_challenge/widgets/daily_weather.dart';

Widget buildHourlySummary(List hourlyForecast) {
  return Wrap(
      direction: Axis.horizontal,
      children: hourlyForecast.map((item) => DailyWeather(item)).toList());
}

Widget mapIconToImage(String icon) {
  Image image;
  switch (icon) {
    case "01n":
      image = Image.asset("assets/icons/01n.png");
      break;

    case "01d":
      image = Image.asset("assets/icons/01d.png");
      break;

    case "02n":
      image = Image.asset("assets/icons/02n.png");
      break;

    case "02d":
      image = Image.asset("assets/icons/02d.png");
      break;

    case "03d":
      image = Image.asset("assets/icons/03d.png");
      break;

    case "03n":
      image = Image.asset("assets/icons/03n.png");
      break;

    case "04d":
      image = Image.asset("assets/icons/04d.png");
      break;

    case "04n":
      image = Image.asset("assets/icons/04n.png");
      break;

    case "09d":
      image = Image.asset("assets/icons/09d.png");
      break;

    case "09n":
      image = Image.asset("assets/icons/09n.png");
      break;

    case "10d":
      image = Image.asset("assets/icons/10d.png");
      break;

    case "10n":
      image = Image.asset("assets/icons/10n.png");
      break;

    case "11d":
      image = Image.asset("assets/icons/11d.png");
      break;

    case "11n":
      image = Image.asset("assets/icons/11n.png");
      break;

    case "13d":
      image = Image.asset("assets/icons/13d.png");
      break;

    case "13n":
      image = Image.asset("assets/icons/13n.png");
      break;

    case "50d":
      image = Image.asset("assets/icons/50d.png");
      break;

    case "50n":
      image = Image.asset("assets/icons/50n.png");
      break;

    default:
      image = Image.asset("assets/icons/cloud.png");
  }
  return Padding(
    padding: EdgeInsets.all(5),
    child: image,
  );
}
