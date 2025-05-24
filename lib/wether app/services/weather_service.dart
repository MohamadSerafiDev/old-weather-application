import 'dart:convert';
import 'package:bloc_2/wether%20app/services/api_source.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  //base information

  String baseUrl = 'http://api.weatherapi.com/v1';
  //visit https://www.weatherapi.com/ to get ur api key
  String apikey = ApiSource.get;

  //main work
  Future<WeatherData> getWeather({required String location}) async {
    Uri url = Uri.parse(
        '$baseUrl/forecast.json?key=$apikey&q=$location&days=1&aqi=no&alerts=no');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherData weatherData;
    weatherData = WeatherData.fromJson(data);

    return weatherData;
  }
}

//data prossecing
class WeatherData {
  String date;
  String lastupdate;
  String condition;
  String location;
  String region;
  String sunrise;
  String sunset;
  String moonrise;
  String moonset;
  String moonphase;
  int moonillumination;
  int conditionCode;
  num maxtemp;
  num mintemp;
  num temp;
  int isDay;
  List everyhour;

  WeatherData(
      {required this.date,
      required this.temp,
      required this.lastupdate,
      required this.condition,
      required this.maxtemp,
      required this.mintemp,
      required this.location,
      required this.region,
      required this.everyhour,
      required this.isDay,
      required this.conditionCode,
      required this.moonillumination,
      required this.moonphase,
      required this.moonrise,
      required this.moonset,
      required this.sunrise,
      required this.sunset});

  factory WeatherData.fromJson(Map<String, dynamic> data) {
    List temp = [];
    List path = data['forecast']['forecastday'][0]['hour'];
    //get weather for every hour..!
    for (var i = 0; i < 24; i++) {
      temp.add({
        'time': path[i]['time'],
        'temp': path[i]['temp_c'],
        'is_day': path[i]['is_day'],
        'condition': path[i]['condition']['text'],
        'conditionCode': path[i]['condition']['code']
      });
    }
    // print(temp);
    //
    //forecast.forecastday[0].astro
    Map astro = data['forecast']['forecastday'][0]['astro'];
    return WeatherData(
      date: data['location']['localtime'],
      temp: data['current']['temp_c'],
      lastupdate: data['current']['last_updated'],
      condition: data['current']['condition']['text'],
      maxtemp: data['forecast']['forecastday'][0]['day']['maxtemp_c'],
      mintemp: data['forecast']['forecastday'][0]['day']['mintemp_c'],
      location: data['location']['name'],
      region: data['location']['region'],
      everyhour: temp,
      isDay: data['current']['is_day'],
      //astro
      moonillumination: astro['moon_illumination'],
      moonphase: astro['moon_phase'],
      moonrise: astro['moonrise'],
      moonset: astro['moonset'],
      sunrise: astro['sunrise'],
      sunset: astro['sunset'],
      conditionCode: data['current']['condition']['code'],
    );
  }

//   String getImage(int conditionCode, int isday) {
//   if (conditionCode == 1000) { // Sunny
//     return isday == 1 ? 'images/Sunny.gif' : 'images/Clear night.png';
//   }
//   if (conditionCode == 1003) { // Partly cloudy
//     return isday == 1 ? 'images/Partly cloudy.gif' : 'images/Cloudy night.png';
//   }
//   if (conditionCode == 1006 || conditionCode == 1009 || conditionCode == 1030 || conditionCode == 1135) { // Cloudy, Overcast, Mist, Fog
//     return isday == 1 ? 'images/Cloudy.gif' : 'images/Cloudy night.png';
//   }
//   if (conditionCode == 1063 || conditionCode == 1066 || conditionCode == 1069 || conditionCode == 1072 || conditionCode == 1150) { // Patchy rain possible, Patchy snow possible, Patchy sleet possible, Patchy freezing drizzle possible, Patchy light drizzle
//     return isday == 1 ? 'images/Black cloud.png' : 'images/Thinder night.png';
//   }
//   if (conditionCode == 1087 || conditionCode == 1273) { // Thundery outbreaks possible, Patchy light rain with thunder
//     return isday == 1 ? 'images/Lightning.gif' : 'images/Thinder night.png';
//   }
//   if (conditionCode == 1114 || conditionCode == 1117 || conditionCode == 1210 || conditionCode == 1213 || conditionCode == 1216 || conditionCode == 1219 || conditionCode == 1222 || conditionCode == 1225 || conditionCode == 1255 || conditionCode == 1258) { // Blowing snow, Blizzard, Patchy light snow, Light snow, Patchy moderate snow, Moderate snow, Patchy heavy snow, Heavy snow, Light snow showers, Moderate or heavy snow showers
//     return isday == 1 ? 'images/Snow.gif' : 'images/snowy night.png';
//   }
//   if (conditionCode == 1147 || conditionCode == 1204 || conditionCode == 1249) { // Freezing fog, Light sleet, Light sleet showers
//     return isday == 1 ? 'images/Winter.gif' : 'images/snowy night.png';
//   }
//   if (conditionCode == 1237 || conditionCode == 1261 || conditionCode == 1264) { // Ice pellets, Light showers of ice pellets, Moderate or heavy showers of ice pellets
//     return isday == 1 ? 'images/Hail.gif' : 'images/Rainy night.png';
//   }
//   if (conditionCode == 1153 || conditionCode == 1180 || conditionCode == 1183 || conditionCode == 1186 || conditionCode == 1189 || conditionCode == 1240 || conditionCode == 1243 || conditionCode == 1207 || conditionCode == 1252) { // Light drizzle, Patchy light rain, Light rain, Moderate rain at times, Moderate rain, Light rain shower, Moderate or heavy rain shower, Moderate or heavy sleet, Moderate or heavy sleet showers, Patchy rain nearby
//     return isday == 1 ? 'images/Raining.gif' : 'images/Rainy night.png';
//   }
//   if (conditionCode == 1192 || conditionCode == 1195 || conditionCode == 1246 || conditionCode == 1276) { // Heavy rain at times, Heavy rain, Torrential rain shower, Moderate or heavy rain with thunder
//     return isday == 1 ? 'images/Storm.gif' : 'images/Thinder night.png';
//   }
//   if (conditionCode == 1168 || conditionCode == 1171 || conditionCode == 1198 || conditionCode == 1201 || conditionCode == 1279 || conditionCode == 1282) { // Freezing drizzle, Heavy freezing drizzle, Light freezing rain, Moderate or heavy freezing rain, Patchy light snow with thunder, Moderate or heavy snow with thunder
//     return isday == 1 ? 'images/Snow with rain.gif' : 'images/snowy night.png';
//   }

//   return 'images/Clear.png';
// }

  String getImage(int conditionCode, int isday) {
    if (conditionCode == 1000) {
      return isday == 1
          ? 'images/test/Sunny.png'
          : 'images/test/Clear Night Moon.png';
    }
    if (conditionCode == 1006 ||
        conditionCode == 1009 ||
        conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1003) {
      return isday == 1
          ? 'images/test/Cloudy.png'
          : 'images/test/Cloud Night.png';
    }
    if (conditionCode == 1063 ||
        conditionCode == 1066 ||
        conditionCode == 1069 ||
        conditionCode == 1072 ||
        conditionCode == 1150) {
      return isday == 1
          ? 'images/test/Patchy Rain.png'
          : 'images/test/Thunder Night.png';
    }
    if (conditionCode == 1087 || conditionCode == 1273) {
      return isday == 1
          ? 'images/test/Thunder With Sun.png'
          : 'images/test/Thunder Night.png';
    }
    if (conditionCode == 1114 ||
        conditionCode == 1117 ||
        conditionCode == 1210 ||
        conditionCode == 1213 ||
        conditionCode == 1216 ||
        conditionCode == 1219 ||
        conditionCode == 1222 ||
        conditionCode == 1225 ||
        conditionCode == 1255 ||
        conditionCode == 1258) {
      return isday == 1 ? 'images/Winter.gif' : 'images/Clear Night Moon.png';
    }
    if (conditionCode == 1147 ||
        conditionCode == 1204 ||
        conditionCode == 1249 ||
        conditionCode == 1168 ||
        conditionCode == 1171 ||
        conditionCode == 1198 ||
        conditionCode == 1201 ||
        conditionCode == 1279 ||
        conditionCode == 1282) {
      return isday == 1 ? 'images/test/Freeze.png' : 'images/snowy night.png';
    }
    if (conditionCode == 1237 ||
        conditionCode == 1261 ||
        conditionCode == 1264) {
      return isday == 1
          ? 'images/test/Light Rain.png'
          : 'images/test/Light Rainy Night.png';
    }
    if (conditionCode == 1153 ||
        conditionCode == 1180 ||
        conditionCode == 1183 ||
        conditionCode == 1186 ||
        conditionCode == 1189 ||
        conditionCode == 1240 ||
        conditionCode == 1243 ||
        conditionCode == 1207 ||
        conditionCode == 1252) {
      return isday == 1
          ? 'images/test/Rain Shower.png'
          : 'images/test/Heavy Rainy Night.png';
    }
    if (conditionCode == 1192 ||
        conditionCode == 1195 ||
        conditionCode == 1246 ||
        conditionCode == 1276) {
      return isday == 1 ? 'images/Storm.gif' : 'images/Thinder night.png';
    }

    return 'images/Clear.png';
  }

  //

  //

  MaterialColor getWeatherTheme(int conditionCode, int isday) {
    switch (conditionCode) {
      case 1000: // Sunny
        return isday == 1 ? Colors.orange : Colors.cyan;
      case 1003: // Partly cloudy
        return Colors.grey;
      case 1006: // Cloudy
      case 1009: // Overcast
      case 1030: // Mist
      case 1135: // Fog
        return Colors.blueGrey;
      case 1063: // Patchy rain possible
      case 1066: // Patchy snow possible
      case 1069: // Patchy sleet possible
      case 1072: // Patchy freezing drizzle possible
      case 1150: // Patchy light drizzle
        return Colors.brown;
      case 1087: // Thundery outbreaks possible
      case 1273: // Patchy light rain with thunder
        return Colors.grey;
      case 1114: // Blowing snow
      case 1117: // Blizzard
      case 1210: // Patchy light snow
      case 1213: // Light snow
      case 1216: // Patchy moderate snow
      case 1219: // Moderate snow
      case 1222: // Patchy heavy snow
      case 1225: // Heavy snow
      case 1255: // Light snow showers
      case 1258: // Moderate or heavy snow showers
        return Colors.lightBlue;
      case 1147: // Freezing fog
      case 1204: // Light sleet
      case 1249: // Light sleet showers
        return Colors.blue;
      case 1237: // Ice pellets
      case 1261: // Light showers of ice pellets
      case 1264: // Moderate or heavy showers of ice pellets
        return Colors.indigo;
      case 1153: // Light drizzle
      case 1180: // Patchy light rain
      case 1183: // Light rain
      case 1186: // Moderate rain at times
      case 1189: // Moderate rain
      case 1240: // Light rain shower
      case 1243: // Moderate or heavy rain shower
      case 1207: // Moderate or heavy sleet
      case 1252: // Moderate or heavy sleet showers
        return Colors.blue;
      case 1192: // Heavy rain at times
      case 1195: // Heavy rain
      case 1246: // Torrential rain shower
      case 1276: // Moderate or heavy rain with thunder
        return Colors.brown;
      case 1168: // Freezing drizzle
      case 1171: // Heavy freezing drizzle
      case 1198: // Light freezing rain
      case 1201: // Moderate or heavy freezing rain
      case 1279: // Patchy light snow with thunder
      case 1282: // Moderate or heavy snow with thunder
        return Colors.cyan;
      default:
        return Colors.teal;
    }
  }

  String getMoonPhase() {
    switch (moonphase) {
      case 'New Moon':
        return 'moon phases/New Moon.png';
      case 'Waxing Crescent':
        return 'moon phases/Waxing Crescent.png';
      case 'First Quarter':
        return 'moon phases/First Quarter.png';
      case 'Waxing Gibbous':
        return 'moon phases/Waxing Gibbous.png';
      case 'Full Moon':
        return 'moon phases/Full Moon.png';
      case 'Waning Gibbous':
        return 'moon phases/Waning Gibbous.png';
      case 'Last Quarter':
        return 'moon phases/Last Quarter.png';
      case 'Waning Crescent':
        return 'moon phases/Waning Crescent.png';
      default:
        return 'moon phases/else.gif';
    }
  }
}
