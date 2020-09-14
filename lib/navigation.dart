import 'package:atmo/Screens/about.dart';
import 'package:atmo/Screens/aqi.dart';
import 'package:atmo/Screens/weather.dart';
import 'package:flutter/material.dart';

int initialpage = 0;
int page = 0;

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> bottomdots = [
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.adjust,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.brightness_1, color: Colors.white, size: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.brightness_1, color: Colors.white, size: 10),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(Icons.brightness_1, color: Colors.white, size: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Icons.adjust,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.brightness_1, color: Colors.white, size: 10),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(Icons.brightness_1, color: Colors.black45, size: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.brightness_1, color: Colors.black45, size: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.adjust, color: Colors.black45),
        ),
      ],
    )
  ];

  final mycontroller = PageController(initialPage: initialpage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mycontroller,
        onPageChanged: (index) {
          setState(() {
            page = index;
          });
        },
        children: <Widget>[Weather(), Aqi(), About()],
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 8),
          child: bottomdots[
              page]), //bottomdots contains list with difflet rows containing diffrent sets of bottom dots
    );
  }
}
