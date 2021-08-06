import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weather_app_challenge/model/city_model.dart';

class CityNotifier extends ChangeNotifier {
  List<CityModel> citiesList = [
    CityModel(cityName: "Bamako"),
    CityModel(cityName: "Barcelona"),
  ];
  UnmodifiableListView<CityModel> get cityList =>
      UnmodifiableListView(citiesList);

  addCity(String newCityName) {
    final city = CityModel(cityName: newCityName);
    citiesList.add(city);
    notifyListeners();
  }

  deleteCity(index) {
    citiesList.removeWhere((city) => city == citiesList[index]);
    notifyListeners();
  }
}
