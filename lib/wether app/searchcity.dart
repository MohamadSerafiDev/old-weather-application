// ignore_for_file:, use_build_context_synchronously, use_build_context_synchronously

import 'package:bloc_2/wether%20app/provider/weatherprovider.dart';
import 'package:bloc_2/wether%20app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Citypage extends StatefulWidget {
  const Citypage({super.key});

  @override
  State<Citypage> createState() => _CitypageState();
}

class _CitypageState extends State<Citypage> {
  String cityname = 'syria';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            onChanged: (value) {
              cityname = value;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () async {
                    WeatherData weather =
                        await WeatherService().getWeather(location: cityname);
                    context.read<ProviderData>().SetWeather = weather;
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.saved_search_outlined,
                    size: 35,
                  )),
              border: const OutlineInputBorder(),
              hintText: 'Enter your city',
              label: const Text('Search'),
            ),
          ),
        ),
      ),
    );
  }
}
