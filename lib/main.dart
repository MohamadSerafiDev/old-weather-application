import 'dart:ui';

import 'package:bloc_2/wether%20app/mainpage.dart';
import 'package:bloc_2/wether%20app/provider/weatherprovider.dart';
import 'package:bloc_2/wether%20app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProviderData(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Provider.of<ProviderData>(context).GetWeatherData == null
            ? Colors.amber
            : Provider.of<ProviderData>(context)
                .GetWeatherData!
                .getWeatherTheme(
                    Provider.of<ProviderData>(context)
                        .GetWeatherData!
                        .conditionCode,
                    Provider.of<ProviderData>(context).GetWeatherData!.isDay),
        primaryColor: Provider.of<ProviderData>(context).GetWeatherData == null
            ? const Color(0XFFfece45)
            : Provider.of<ProviderData>(context)
                .GetWeatherData!
                .getWeatherTheme(
                    Provider.of<ProviderData>(context)
                        .GetWeatherData!
                        .conditionCode,
                    Provider.of<ProviderData>(context).GetWeatherData!.isDay),
      ),
      home: const Mainpage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//
//
//
//
//
// ignore
class _MyHomePageState extends State<MyHomePage> {
  void refresh() {
    setState(() {
      isfavorite = !isfavorite;
    });
  }

  bool isfavorite = false;
  String imagepath = 'images/sneakers.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
          child: CustomPrudoctStack(
              imagepath: imagepath, isfav: isfavorite, refresh: refresh)),
    );
  }
}

Widget CustomPrudoctStack(
    {required String imagepath,
    required isfav,
    required VoidCallback refresh}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 400,
        height: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, Colors.deepPurple.shade600]),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 5))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'hi',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  Text('new product!!',
                      style: TextStyle(fontSize: 30, color: Colors.teal))
                ],
              ),
              IconButton(
                  onPressed: () {
                    refresh();
                  },
                  icon: Icon(
                    isfav ? Icons.favorite : Icons.favorite_border_outlined,
                    color: isfav ? Colors.red : null,
                    size: 40,
                  ))
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 178,
        left: 90,
        child: Image.asset(
          imagepath,
          width: 3,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      //main photo
      Positioned(
        bottom: 190,
        left: 90,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Image.asset(
              imagepath,
              width: 330,
            ),
          ),
        ),
      ),
    ],
  );
}
