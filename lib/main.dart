import 'package:atmo/Screens/firsttime.dart';
import 'package:atmo/Screens/searcha.dart';
import 'package:atmo/Screens/searcht.dart';
import 'package:atmo/Screens/splashscreen.dart';
import 'package:atmo/Screens/weather.dart';
import 'package:atmo/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Atmo());
}

class Atmo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splashscreen(),
      routes: {
        'weather': (context) => Weather(),
        'searcht': (context) => SearchT(),
        'searcha': (context) => Searcha(),
        'navigation': (context) => Navigation(),
        'firsttime': (context) => Firsttime(),
      },
    );
  }
}
