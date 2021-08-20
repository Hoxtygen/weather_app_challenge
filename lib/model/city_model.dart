class CityModel {
  CityModel({required this.cityName});
  String cityName;
}

class CurrentCityWeatherModel {
  CurrentCityWeatherModel({
    required this.temp,
    required this.description,
    required this.icon,
    required this.cod,
  });
  final num temp;
  final String description;
  final String icon;
  final int cod;

  static CurrentCityWeatherModel fromDailyJson(dynamic current) {
    var weather = current["weather"][0];
    return CurrentCityWeatherModel(
      temp: current["main"]["temp"].toInt(),
      description: weather["description"],
      icon: weather["icon"],
      cod: current["cod"],
    );
  }
}
