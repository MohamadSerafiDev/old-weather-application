// ignore_for_file: prefer_const_constructors

import 'package:bloc_2/wether%20app/componants/astro_row.dart';
import 'package:bloc_2/wether%20app/componants/customcard.dart';
import 'package:bloc_2/wether%20app/componants/customgradient.dart';
import 'package:bloc_2/wether%20app/provider/weatherprovider.dart';
import 'package:bloc_2/wether%20app/services/weather_service.dart';
import 'package:bloc_2/wether%20app/componants/moon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class WeatherBody extends StatefulWidget {
  const WeatherBody({super.key});

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}

class _WeatherBodyState extends State<WeatherBody> {
  late Future<Position> pos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WeatherData proWeather = Provider.of<ProviderData>(context).GetWeatherData!;
    // DateTime dateTime = DateTime.parse(proWeather.lastupdate);
    return Container(
      decoration: BoxDecoration(
          gradient: customgradient(
              200,
              500,
              900,
              proWeather.getWeatherTheme(
                  proWeather.conditionCode, proWeather.isDay),
              Alignment.topCenter,
              Alignment.bottomCenter)),
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                proWeather.lastupdate.toString().substring(0, 11),
                style: const TextStyle(
                  fontSize: 35,
                ),
              ),
              Text(
                'Updated at     ${proWeather.lastupdate.toString().substring(11)}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              // LOOK --------> Main Card
              customcard(
                300,
                800,
                200,
                proWeather.getWeatherTheme(
                    proWeather.conditionCode, proWeather.isDay),
                Alignment.bottomLeft,
                Alignment.topRight,
                double.infinity,
                30,
                10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            proWeather.condition,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${proWeather.temp.toInt()}°C',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'max : ${proWeather.temp > proWeather.maxtemp ? proWeather.temp.toInt() : proWeather.maxtemp.toInt()}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    'min : ${proWeather.mintemp.toInt()}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 3,
                          left: 0,
                          child: Image.asset(
                            proWeather.getImage(
                                proWeather.conditionCode, proWeather.isDay),
                            width: 150,
                            height: 150,
                            color: Colors.black45,
                          ),
                        ),
                        Image.asset(
                          proWeather.getImage(
                              proWeather.conditionCode, proWeather.isDay),
                          width: 150,
                          height: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Text(
                '${proWeather.region} - ${proWeather.location} ',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: proWeather.everyhour.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            // LOOK -------->  every hour card
                            //
                            child: customcard(
                              300,
                              700,
                              200,
                              proWeather.getWeatherTheme(
                                  proWeather.everyhour[index]['conditionCode'],
                                  proWeather.isDay),
                              Alignment.bottomCenter,
                              Alignment.topRight,
                              100,
                              7,
                              0,
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(proWeather.everyhour[index]['time']
                                      .toString()
                                      .substring(11)),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Image.asset(
                                          proWeather.getImage(
                                              proWeather.everyhour[index]
                                                  ['conditionCode'],
                                              proWeather.everyhour[index]
                                                  ['is_day']),
                                          width: 70,
                                          height: 70,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      Image.asset(
                                        proWeather.getImage(
                                            proWeather.everyhour[index]
                                                ['conditionCode'],
                                            proWeather.everyhour[index]
                                                ['is_day']),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    proWeather.everyhour[index]['condition'],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  Text(
                                      '${proWeather.everyhour[index]['temp'].toInt()} °C'),
                                ],
                              ),
                            ));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //LOOK --------> astro card
              customcard(
                300,
                700,
                200,
                proWeather.getWeatherTheme(
                    proWeather.conditionCode, proWeather.isDay),
                Alignment.bottomLeft,
                Alignment.topRight,
                double.infinity,
                30,
                10,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      astroRow('Sun Rise', proWeather.sunrise),
                      astroRow('Sun Set', proWeather.sunset),
                      astroRow('Moon Rise', proWeather.moonrise),
                      astroRow('Moon Set', proWeather.moonset),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Moon',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  )),
              //Moon Moon Moon Moon Moon Moon Moon Moon Moon
              const Moon(),
              //Moon Moon Moon Moon Moon Moon Moon Moon Moon
              const SizedBox(
                height: 5,
              ),
              Text(
                'phase : ${proWeather.moonphase}',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              //
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return customcard(
                      200,
                      600,
                      300,
                      proWeather.getWeatherTheme(
                          proWeather.conditionCode, proWeather.isDay),
                      Alignment.bottomCenter,
                      Alignment.topCenter,
                      150,
                      10,
                      5,
                      Column(
                        children: [
                          Center(
                            child: Text('hello world'),
                          )
                        ],
                      ));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
