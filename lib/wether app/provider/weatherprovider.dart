// ignore_for_file: non_constant_identifier_names

import 'package:bloc_2/wether%20app/services/weather_service.dart';
import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  WeatherData? _weatherData;
  String? local;

  set SetWeather(WeatherData? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  WeatherData? get GetWeatherData => _weatherData;
}
