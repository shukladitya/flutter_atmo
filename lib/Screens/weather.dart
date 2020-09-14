import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'splashscreen.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

int randomno; //for pictures
int counter = 0; //that animates the temperature
int temperature;
int windspeed;
int humidity;
int feelslike;
int cloud;
String visibility;
int uvi;
String city;
String country;
String description;
FaIcon weathericon;
String sunrise;
String sunset;
String background;
String d1img;
int d1max;
int d1min;
int d1speed;
int d1humid;
int d1prb;
String d2img;
int d2max;
int d2min;
int d2speed;
int d2humid;
int d2prb;
String d3img;
int d3max;
int d3min;
int d3speed;
int d3humid;
int d3prb;
String d4img;
int d4max;
int d4min;
int d4speed;
int d4humid;
int d4prb;
String d5img;
int d5max;
int d5min;
int d5speed;
int d5humid;
int d5prb;
String date2;
String date3;
String date4;
String date5;
int situation = 0; //for selection data at refrashing state

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Widget buildbottomsheet(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Current report :',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.thermometerHalf),
                              Text('   Feels like $feelslike° C.'),
                            ],
                          ),
                        );
                      });
                },
                child: statictile('images/${randomno}5.png',
                    FontAwesomeIcons.thermometerHalf, '$feelslike°'),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.cloud),
                              Text('   Cloudiness $cloud %.'),
                            ],
                          ),
                        );
                      });
                },
                child: statictile('images/${randomno}4.png',
                    FontAwesomeIcons.cloud, '$cloud'),
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.eye),
                                Text('   Visibility $visibility Km.'),
                              ],
                            ),
                          );
                        });
                  },
                  child: statictile('images/${randomno}3.png',
                      FontAwesomeIcons.eye, '$visibility')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FaIcon(Icons.wb_sunny),
                                Text('   UV index is $uvi.'),
                              ],
                            ),
                          );
                        });
                  },
                  child: statictile(
                      'images/${randomno}2.png', Icons.wb_sunny, '$uvi')),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.sun),
                              Text(
                                  '   Sunrise at ${sunrise[12]}:${sunrise[14]}${sunrise[15]} am.'),
                            ],
                          ),
                        );
                      });
                },
                child: statictile(
                    'images/${randomno}1.png',
                    FontAwesomeIcons.sun,
                    '${sunrise[12]}:${sunrise[14]}${sunrise[15]}'),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.solidSun),
                              Text(
                                  '   Sunset at ${(double.parse(sunset[12])).toInt() - 2}:${sunset[14]}${sunset[15]} pm.'),
                            ],
                          ),
                        );
                      });
                },
                child: statictile(
                    'images/${randomno}0.png',
                    FontAwesomeIcons.solidSun,
                    '${(double.parse(sunset[12])).toInt() - 2}:${sunset[14]}${sunset[15]}'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Five days forecast:',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                scrolltiles('images/$d1img.jpg', ' Tomorrow', d1max, d1min,
                    d1speed, d1humid, d1prb),
                scrolltiles(
                    'images/$d2img.jpg',
                    ' ${date2[8]}${date2[9]}-${date2[5]}${date2[6]}',
                    d2max,
                    d2min,
                    d2speed,
                    d2humid,
                    d2prb),
                scrolltiles(
                    'images/$d3img.jpg',
                    ' ${date3[8]}${date3[9]}-${date3[5]}${date3[6]}',
                    d3max,
                    d3min,
                    d3speed,
                    d3humid,
                    d3prb),
                scrolltiles(
                    'images/$d4img.jpg',
                    ' ${date4[8]}${date4[9]}-${date4[5]}${date4[6]}',
                    d4max,
                    d4min,
                    d4speed,
                    d4humid,
                    d4prb),
                scrolltiles(
                    'images/$d5img.jpg',
                    ' ${date5[8]}${date5[9]}-${date5[5]}${date5[6]}',
                    d5max,
                    d5min,
                    d5speed,
                    d5humid,
                    d5prb),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////static tile function
  Widget statictile(String image, IconData tileicon, String icontext) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: FaIcon(
                tileicon,
                color: Colors.white,
                size: 26,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                ' $icontext',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                minFontSize: 20,
                stepGranularity: 10,
              ),
            )
          ],
        ),
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.height / 8,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
    );
  }
//////////////////////////////////////////////////////////////////////////////////////scroll tile function

  Widget scrolltiles(String image, String day, int max, int min, int speed,
      int humid, int probabilty) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: MediaQuery.of(context).size.height / 6,
            width: 2 * MediaQuery.of(context).size.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '$day',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.thermometerFull,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      '$max° ',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    FaIcon(
                      FontAwesomeIcons.thermometerEmpty,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      '$min°',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.wind,
                        color: Colors.white,
                      ),
                      Text(
                        '$speed km/h  ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      FaIcon(
                        FontAwesomeIcons.grinBeamSweat,
                        color: Colors.white,
                      ),
                      Text(
                        '$humid %  ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      FaIcon(
                        FontAwesomeIcons.cloudRain,
                        color: Colors.white,
                      ),
                      Text(
                        '$probabilty mm  ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }

  int randomnogenerrator() {
    var x = Random().nextInt(8);
    return x;
  }

  var jsonresponse = json.decode(response.body);
  var jsoncitycountry = json.decode(citycountry.body);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (situation == 0) assignvales();
    starttemperature();
  }

  FaIcon weathericonseector() {
    if (jsonresponse['current']['weather'][0]['id'] == 800)
      return FaIcon(
        Icons.wb_sunny,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 801)
      return FaIcon(
        FontAwesomeIcons.cloud,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 800)
      return FaIcon(
        FontAwesomeIcons.cloudSun,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 700)
      return FaIcon(
        FontAwesomeIcons.soundcloud,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 599)
      return FaIcon(
        FontAwesomeIcons.snowflake,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 501)
      return FaIcon(
        FontAwesomeIcons.cloudRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 499)
      return FaIcon(
        FontAwesomeIcons.cloudSunRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 299)
      return FaIcon(
        FontAwesomeIcons.cloudRain,
        size: 35,
        color: Colors.white,
      );
    else if (jsonresponse['current']['weather'][0]['id'] > 199)
      return FaIcon(
        FontAwesomeIcons.bolt,
        size: 35,
        color: Colors.white,
      );
  }

  void assignvales() {
    temperature = jsonresponse['current']['temp'].round();
    windspeed = jsonresponse['current']['wind_speed'].round();
    humidity = jsonresponse['current']['humidity'].round();
    city = jsoncitycountry['city'];
    country = jsoncitycountry['prov'];
    description = jsonresponse['current']['weather'][0]['description'];
    weathericon = weathericonseector();
    feelslike = jsonresponse['current']['feels_like'].round();
    cloud = jsonresponse['current']['clouds'].round();
    visibility = ((jsonresponse['current']['visibility'] ?? 16000) / 1000)
        .toStringAsFixed(0);
    uvi = (jsonresponse['current']['uvi'] ?? 0).round();
    sunrise = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['current']['sunrise'] * 1000)
        .toString();
    sunset = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['current']['sunset'] * 1000)
        .toString();
    background = jsonresponse['current']['weather'][0]['icon'];
    d1img = jsonresponse['daily'][1]['weather'][0]['icon'];
    d1max = jsonresponse['daily'][1]['temp']['max'].round();
    d1min = jsonresponse['daily'][1]['temp']['min'].round();
    d1speed = jsonresponse['daily'][1]['wind_speed'].round();
    d1humid = jsonresponse['daily'][1]['humidity'].round();
    d1prb = (jsonresponse['daily'][1]['rain'] ?? 0).round();
    d2img = jsonresponse['daily'][2]['weather'][0]['icon'];
    d2max = jsonresponse['daily'][2]['temp']['max'].round();
    d2min = jsonresponse['daily'][2]['temp']['min'].round();
    d2speed = jsonresponse['daily'][2]['wind_speed'].round();
    d2humid = jsonresponse['daily'][2]['humidity'].round();
    d2prb = (jsonresponse['daily'][2]['rain'] ?? 0).round();
    d3img = jsonresponse['daily'][3]['weather'][0]['icon'];
    d3max = jsonresponse['daily'][3]['temp']['max'].round();
    d3min = jsonresponse['daily'][3]['temp']['min'].round();
    d3speed = jsonresponse['daily'][3]['wind_speed'].round();
    d3humid = jsonresponse['daily'][3]['humidity'].round();
    d3prb = (jsonresponse['daily'][3]['rain'] ?? 0).round();
    d4img = jsonresponse['daily'][4]['weather'][0]['icon'];
    d4max = jsonresponse['daily'][4]['temp']['max'].round();
    d4min = jsonresponse['daily'][4]['temp']['min'].round();
    d4speed = jsonresponse['daily'][4]['wind_speed'].round();
    d4humid = jsonresponse['daily'][4]['humidity'].round();
    d4prb = (jsonresponse['daily'][4]['rain'] ?? 0).round();
    d5img = jsonresponse['daily'][5]['weather'][0]['icon'];
    d5max = jsonresponse['daily'][5]['temp']['max'].round();
    d5min = jsonresponse['daily'][5]['temp']['min'].round();
    d5speed = jsonresponse['daily'][5]['wind_speed'].round();
    d5humid = jsonresponse['daily'][5]['humidity'].round();
    d5prb = (jsonresponse['daily'][5]['rain'] ?? 0).round();
    date2 = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['daily'][2]['dt'] * 1000)
        .toString();
    date3 = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['daily'][3]['dt'] * 1000)
        .toString();
    date4 = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['daily'][4]['dt'] * 1000)
        .toString();
    date5 = DateTime.fromMillisecondsSinceEpoch(
            jsonresponse['daily'][5]['dt'] * 1000)
        .toString();
  }

  void starttemperature() {
    Timer ticker;

    ticker = Timer.periodic(Duration(milliseconds: 66), (timer) {
      setState(() {
        if (counter < temperature)
          counter++;
        else if (counter > temperature)
          counter--;
        else
          ticker.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/$background.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'searcht');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.white,
                        ),
                        Flexible(
                          child: Text(
                            ' $city ,$country '.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  Text(
                    ' $counter°',
                    style: TextStyle(
                        fontSize: 170,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        weathericon,
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            ' $description'.toUpperCase(),
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    randomno = randomnogenerrator();
                    showModalBottomSheet(
                        context: context, builder: buildbottomsheet);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 17),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.wind,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' $windspeed km/h',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.grinBeamSweat,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' $humidity%',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.arrowUp,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' More',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
