import 'package:bloc_2/wether%20app/provider/weatherprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starsview/config/MeteoriteConfig.dart';
import 'package:starsview/config/StarsConfig.dart';
import 'package:starsview/starsview.dart';

class Moon extends StatelessWidget {
  const Moon({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shadowColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color(0XFF0c0727),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        spreadRadius: Provider.of<ProviderData>(context)
                                .GetWeatherData!
                                .moonillumination
                                .toDouble() /
                            7,
                        blurRadius: 30,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: Provider.of<ProviderData>(context)
                                .GetWeatherData!
                                .moonillumination
                                .toDouble() /
                            1.2,
                        blurRadius: 100,
                        offset: const Offset(0, 0),
                      )
                    ]),
              ),
              StarsView(
                fps: 45,
                meteoriteConfig: const MeteoriteConfig(
                  enabled: true,
                  colors: [
                    Colors.deepPurple,
                    Color(0XFFd3af37),
                    Color(0XFF48dd87),
                    Color(0XFF8c93e2),
                  ],
                  maxMeteoriteSize: 2,
                  minMeteoriteSize: 0.5,
                  maxMeteoriteSpeed: 3,
                  minMeteoriteSpeed: 1.5,
                ),
                starsConfig: StarsConfig(
                  starCount: 500,
                  maxStarSize: 1.5,
                  minStarSize: 0.5,
                  colors: [Colors.red[200]!, Colors.indigo, Colors.white],
                ),
              ),
              Image.asset(
                Provider.of<ProviderData>(context)
                    .GetWeatherData!
                    .getMoonPhase(),
                width: 235,
                height: 235,
              )
            ],
          ),
        ),
      ),
    );
  }
}
