import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 15),
            child: Text(
              ' About',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'The App:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AutoSizeText(
                      'Provides current weather conditions, forecasts, Air quality and Air composition.\nAll the units on weather screen are metric.\nAQI is a unit less number between range 0-500.',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      minFontSize: 10,
                      stepGranularity: 5,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Color(0xFFF00B51), Color(0xFF730062)],
                      begin: Alignment.topLeft),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: Offset(6.0, 6.0),
                    )
                  ]),
              height: MediaQuery.of(context).size.height / 4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () async {
                    const url = 'https://aqicn.org/scale/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.tachometerAlt,
                          color: Colors.white,
                          size:
                              (4 * MediaQuery.of(context).size.width / 9) - 90,
                        ),
                        Text(
                          'Aqi Ranges',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                            colors: [Color(0xFFFF5B94), Color(0xFF8441A4)],
                            begin: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                            offset: Offset(6.0, 6.0),
                          )
                        ]),
                    height: 4 * MediaQuery.of(context).size.width / 9,
                    width: 4 * MediaQuery.of(context).size.width / 9,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () async {
                    const url =
                        'https://www.airnow.gov/aqi/aqi-basics/#:~:text=Think%20of%20the%20AQI%20as,300%20represents%20hazardous%20air%20quality.';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.book,
                          color: Colors.white,
                          size:
                              (4 * MediaQuery.of(context).size.width / 9) - 90,
                        ),
                        Text(
                          'Working',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(colors: [
                          Colors.deepOrange[400],
                          Colors.pinkAccent[700]
                        ], begin: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                            offset: Offset(6.0, 6.0),
                          )
                        ]),
                    height: 4 * MediaQuery.of(context).size.width / 9,
                    width: 4 * MediaQuery.of(context).size.width / 9,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Data provided by:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        'images/aqicn.png',
                        height: (MediaQuery.of(context).size.height / 4) - 110,
                      ),
                      Image.asset(
                        'images/ow.png',
                        height: (MediaQuery.of(context).size.height / 4) - 110,
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.green, Colors.blue],
                      begin: Alignment.topLeft),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: Offset(6.0, 6.0),
                    )
                  ]),
              height: MediaQuery.of(context).size.height / 4,
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Made with  '),
              FaIcon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
                size: 20,
              ),
              Text('  by Aditya Shukla.'),
            ],
          ),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
