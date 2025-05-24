// ignore_for_file: use_build_context_synchronously

import 'package:bloc_2/wether%20app/provider/weatherprovider.dart';
import 'package:bloc_2/wether%20app/searchcity.dart';
import 'package:bloc_2/wether%20app/services/location_service.dart';
import 'package:bloc_2/wether%20app/services/weather_service.dart';
import 'package:bloc_2/wether%20app/weatherpage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late Future<Position> pos;
  late Position position;

  @override
  void initState() {
    super.initState();
    pos = determinePosition(context);
    setPosition();
  }

  void setPosition() async {
    position = await pos;
    setlocat();
    print('${position.latitude}, ${position.longitude}');
  }

  void setlocat() async {
    // String locat =
    //     await getArea('${position.latitude}', '${position.longitude}');
    // context.read<ProviderData>().SetLocation = locat;
    WeatherData weather = await WeatherService()
        .getWeather(location: '${position.latitude}, ${position.longitude}');
    context.read<ProviderData>().SetWeather = weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Provider.of<ProviderData>(context).GetWeatherData == null
            ? AppBar(
                backgroundColor: const Color(0XFFeef2f4),
              )
            : AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 6,
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Citypage())),
                      icon: const Icon(
                        Icons.saved_search_rounded,
                        size: 35,
                      ))
                ],
                shadowColor: Colors.blueGrey,
                title: const Text('Weather app'),
              ),
        body: context.watch<ProviderData>().GetWeatherData == null
            ? Container(
                color: const Color(0XFFeef2f4),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'images/loader2.gif',
                        height: 500,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                      const Text(
                        'loading ...',
                        style: TextStyle(
                            fontSize: 25,
                            // fontFamily: 'SUSE',
                            fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 3)),
                        builder: (context, snapshot) {
                          return const Text(
                            'Getting your location ...',
                            style: TextStyle(
                                fontSize: 25,
                                // fontFamily: 'SUSE',
                                fontWeight: FontWeight.bold),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : const WeatherBody());
  }
}
