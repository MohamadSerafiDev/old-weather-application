import 'package:flutter/material.dart';

Gradient customgradient(int first, int middle, int last, MaterialColor color,
    Alignment start, Alignment end) {
  return LinearGradient(colors: [
    // proWeather.getWeatherTheme[50]!,
    color[first]!,
    // proWeather.getWeatherTheme[200]!,
    // proWeather.getWeatherTheme[300]!,
    color[middle]!,
    // proWeather.getWeatherTheme[600]!,
    color[last]!,
  ], begin: start, end: end);
}
