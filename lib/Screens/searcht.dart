import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'weather.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:atmo/navigation.dart';

class SearchT extends StatefulWidget {
  @override
  _SearchTState createState() => _SearchTState();
}

class _SearchTState extends State<SearchT> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation myanimation;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialpage = 0;
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    myanimation =
        ColorTween(begin: Colors.pink, end: Colors.green).animate(controller);
    controller.forward();
    myanimation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        controller.reverse(from: 1);
      else if (status == AnimationStatus.dismissed) controller.forward();
    });
    controller.addListener(() {
      setState(() {});
    });
  }

  String searchedCity;
  String searchlatitude;
  String searchlongitude;
  String errormessage = '';
  Color errorcolor = Colors.transparent;
  Response cordinatesrespone;
  Response weatherresponse;
  var jsonconverted;
  var jsonweatherconverted;
  void fetchlocation() async {
    try {
      cordinatesrespone = await get('https://geocode.xyz/$searchedCity?json=1');
    } catch (e) {
      setState(() {
        errorcolor = Colors.white;
        progress = false;
        errormessage = 'Opps! Something went wrong, try again later.';
      });
    }
    jsonconverted = jsonDecode(cordinatesrespone.body);
    if (jsonconverted['error'] != null) {
      setState(() {
        progress = false;
        errorcolor = Colors.white;
        errormessage = 'City not found in database, try something else.';
      });
    } else {
      searchlatitude = jsonconverted['latt'];
      searchlongitude = jsonconverted['longt'];
      try {
        weatherresponse = await get(
            'https://api.openweathermap.org/data/2.5/onecall?lat=$searchlatitude&lon=$searchlongitude&%20,daily&appid=6fd385c80e79ad3ff4341df13d6c8b94&units=metric');
        print(weatherresponse.body);
        jsonweatherconverted = jsonDecode(weatherresponse.body);
        assignvariables();
        Navigator.popAndPushNamed(context, 'navigation');
      } catch (e) {
        setState(() {
          errorcolor = Colors.white;
          progress = false;
          errormessage = 'Opps! Something went wrong, try again later.';
        });
      }
    }
  }

  void assignvariables() {
    temperature = jsonweatherconverted['current']['temp'].round();
    windspeed = jsonweatherconverted['current']['wind_speed'].round();
    humidity = jsonweatherconverted['current']['humidity'].round();
    city = jsonconverted['standard']['city'];
    country = jsonconverted['standard']['prov'];
    description = jsonweatherconverted['current']['weather'][0]['description'];
    weathericon = weathericonseector();
    feelslike = jsonweatherconverted['current']['feels_like'].round();
    cloud = jsonweatherconverted['current']['clouds'].round();
    visibility =
        ((jsonweatherconverted['current']['visibility'] ?? 16000) / 1000)
            .toStringAsFixed(0);
    uvi = (jsonweatherconverted['current']['uvi'] ?? 0).round();
    sunrise = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['current']['sunrise'] * 1000)
        .toString();
    sunset = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['current']['sunset'] * 1000)
        .toString();
    background = jsonweatherconverted['current']['weather'][0]['icon'];
    d1img = jsonweatherconverted['daily'][1]['weather'][0]['icon'];
    d1max = jsonweatherconverted['daily'][1]['temp']['max'].round();
    d1min = jsonweatherconverted['daily'][1]['temp']['min'].round();
    d1speed = jsonweatherconverted['daily'][1]['wind_speed'].round();
    d1humid = jsonweatherconverted['daily'][1]['humidity'].round();
    d1prb = (jsonweatherconverted['daily'][1]['rain'] ?? 0).round();
    d2img = jsonweatherconverted['daily'][2]['weather'][0]['icon'];
    d2max = jsonweatherconverted['daily'][2]['temp']['max'].round();
    d2min = jsonweatherconverted['daily'][2]['temp']['min'].round();
    d2speed = jsonweatherconverted['daily'][2]['wind_speed'].round();
    d2humid = jsonweatherconverted['daily'][2]['humidity'].round();
    d2prb = (jsonweatherconverted['daily'][2]['rain'] ?? 0).round();
    d3img = jsonweatherconverted['daily'][3]['weather'][0]['icon'];
    d3max = jsonweatherconverted['daily'][3]['temp']['max'].round();
    d3min = jsonweatherconverted['daily'][3]['temp']['min'].round();
    d3speed = jsonweatherconverted['daily'][3]['wind_speed'].round();
    d3humid = jsonweatherconverted['daily'][3]['humidity'].round();
    d3prb = (jsonweatherconverted['daily'][3]['rain'] ?? 0).round();
    d4img = jsonweatherconverted['daily'][4]['weather'][0]['icon'];
    d4max = jsonweatherconverted['daily'][4]['temp']['max'].round();
    d4min = jsonweatherconverted['daily'][4]['temp']['min'].round();
    d4speed = jsonweatherconverted['daily'][4]['wind_speed'].round();
    d4humid = jsonweatherconverted['daily'][4]['humidity'].round();
    d4prb = (jsonweatherconverted['daily'][4]['rain'] ?? 0).round();
    d5img = jsonweatherconverted['daily'][5]['weather'][0]['icon'];
    d5max = jsonweatherconverted['daily'][5]['temp']['max'].round();
    d5min = jsonweatherconverted['daily'][5]['temp']['min'].round();
    d5speed = jsonweatherconverted['daily'][5]['wind_speed'].round();
    d5humid = jsonweatherconverted['daily'][5]['humidity'].round();
    d5prb = (jsonweatherconverted['daily'][5]['rain'] ?? 0).round();
    date2 = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['daily'][2]['dt'] * 1000)
        .toString();
    date3 = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['daily'][3]['dt'] * 1000)
        .toString();
    date4 = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['daily'][4]['dt'] * 1000)
        .toString();
    date5 = DateTime.fromMillisecondsSinceEpoch(
            jsonweatherconverted['daily'][5]['dt'] * 1000)
        .toString();
    situation = 1;
  }

  FaIcon weathericonseector() {
    if (jsonweatherconverted['current']['weather'][0]['id'] == 800)
      return FaIcon(
        Icons.wb_sunny,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 801)
      return FaIcon(
        FontAwesomeIcons.cloud,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 800)
      return FaIcon(
        FontAwesomeIcons.cloudSun,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 700)
      return FaIcon(
        FontAwesomeIcons.soundcloud,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 599)
      return FaIcon(
        FontAwesomeIcons.snowflake,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 501)
      return FaIcon(
        FontAwesomeIcons.cloudRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 499)
      return FaIcon(
        FontAwesomeIcons.cloudSunRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 299)
      return FaIcon(
        FontAwesomeIcons.cloudRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonweatherconverted['current']['weather'][0]['id'] > 199)
      return FaIcon(
        FontAwesomeIcons.bolt,
        size: 35,
        color: Colors.white,
      );
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.3,
      inAsyncCall: progress,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, myanimation.value],
                begin: Alignment.topLeft),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    searchedCity = value;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      icon: FaIcon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 50,
                      ),
                      hintText: 'Enter city to search',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
                        situation = 0;
                        Navigator.popAndPushNamed(context, 'navigation');
                      },
                      splashColor: Colors.blue,
                      color: Colors.blue[800],
                      shape: CircleBorder(),
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      child: FaIcon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: OutlineButton(
                        onPressed: () {
                          setState(() {
                            progress = true;
                          });
                          fetchlocation();
                        },
                        splashColor: Colors.blue,
                        color: Colors.blue[800],
                        shape: StadiumBorder(),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.search,
                              color: Colors.white,
                            ),
                            Text(
                              '   Search',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: errorcolor,
                      size: 40,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '$errormessage',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
