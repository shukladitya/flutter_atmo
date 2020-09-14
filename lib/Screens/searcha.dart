import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:atmo/navigation.dart';

import 'aqi.dart';

class Searcha extends StatefulWidget {
  @override
  _SearchaState createState() => _SearchaState();
}

class _SearchaState extends State<Searcha> with SingleTickerProviderStateMixin {
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
    initialpage = 1;
    page = 1;
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
  Response aqiresponse;
  var jsonconverted;
  var jsonaqiconverted;
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
        aqiresponse = await get(
            'https://api.waqi.info/feed/geo:$searchlatitude;$searchlongitude/?token=894b3da83e2b2bf3d998096570ee587f6be6eabc');
        print(aqiresponse.body);
        jsonaqiconverted = jsonDecode(aqiresponse.body);
        assignvariables();
        Navigator.popAndPushNamed(context, 'navigation');
      } catch (e) {
        setState(() {
          if (jsonaqiconverted['status'] == 'ok') {
            print('ok with errors in json');
            print('execption is: $e');
            if (jsonaqiconverted['data']['forecast'].toString() == '{}') {
              date1 = 'Forecast Unavailable';
              date2 = 'Forecast Unavailable';
              date3 = 'Forecast Unavailable';
              date4 = 'Forecast Unavailable';
              date5 = 'Forecast Unavailable';
              day1pm25 = 0;
              day1pm10 = 0;
              day1o3 = 0;
              day1uv = 0;
              day2pm25 = 0;
              day2pm10 = 0;
              day2o3 = 0;
              day2uv = 0;
              day3pm25 = 0;
              day3pm10 = 0;
              day3o3 = 0;
              day3uv = 0;
              day4pm25 = 0;
              day4pm10 = 0;
              day4o3 = 0;
              day4uv = 0;
              day5pm25 = 0;
              day5pm10 = 0;
              day5o3 = 0;
              day5uv = 0;
              print('no forecast');
              progress = false;
              Navigator.popAndPushNamed(context, 'navigation');
            } else if (jsonaqiconverted['data']['forecast'].toString() !=
                '{}') {
              date1 =
                  jsonaqiconverted['data']['forecast']['daily']['o3'][0]['day'];
              date2 =
                  jsonaqiconverted['data']['forecast']['daily']['o3'][1]['day'];
              date3 =
                  jsonaqiconverted['data']['forecast']['daily']['o3'][2]['day'];
              date4 =
                  jsonaqiconverted['data']['forecast']['daily']['o3'][3]['day'];
              date5 =
                  jsonaqiconverted['data']['forecast']['daily']['o3'][4]['day'];
              day1pm25 = jsonaqiconverted['data']['forecast']['daily']['pm25']
                      [0]['max']
                  .round();
              day1pm10 = jsonaqiconverted['data']['forecast']['daily']['pm10']
                      [0]['max']
                  .round();
              day1o3 = jsonaqiconverted['data']['forecast']['daily']['o3'][0]
                      ['max']
                  .round();
              day1uv = jsonaqiconverted['data']['forecast']['daily']['uvi'][0]
                      ['max']
                  .round();
              day2pm25 = jsonaqiconverted['data']['forecast']['daily']['pm25']
                      [1]['max']
                  .round();
              day2pm10 = jsonaqiconverted['data']['forecast']['daily']['pm10']
                      [1]['max']
                  .round();
              day2o3 = jsonaqiconverted['data']['forecast']['daily']['o3'][1]
                      ['max']
                  .round();
              day2uv = jsonaqiconverted['data']['forecast']['daily']['uvi'][1]
                      ['max']
                  .round();
              day3pm25 = jsonaqiconverted['data']['forecast']['daily']['pm25']
                      [2]['max']
                  .round();
              day3pm10 = jsonaqiconverted['data']['forecast']['daily']['pm10']
                      [2]['max']
                  .round();
              day3o3 = jsonaqiconverted['data']['forecast']['daily']['o3'][2]
                      ['max']
                  .round();
              day3uv = jsonaqiconverted['data']['forecast']['daily']['uvi'][2]
                      ['max']
                  .round();
              day4pm25 = (jsonaqiconverted['data']['forecast']['daily']['pm25']
                          .length <
                      7)
                  ? 0
                  : jsonaqiconverted['data']['forecast']['daily']['pm25'][3]
                      ['max'];
              day4pm10 = (jsonaqiconverted['data']['forecast']['daily']['pm10']
                          .length <
                      7)
                  ? 0
                  : jsonaqiconverted['data']['forecast']['daily']['pm10'][3]
                      ['max'];
              day4o3 =
                  (jsonaqiconverted['data']['forecast']['daily']['o3'].length <
                          7)
                      ? 0
                      : jsonaqiconverted['data']['forecast']['daily']['o3'][3]
                          ['max'];
              day4uv =
                  (jsonaqiconverted['data']['forecast']['daily']['uvi'].length <
                          7)
                      ? 0
                      : jsonaqiconverted['data']['forecast']['daily']['uvi'][3]
                          ['max'];
              day5pm25 = (jsonaqiconverted['data']['forecast']['daily']['pm25']
                          .length <
                      8)
                  ? 0
                  : jsonaqiconverted['data']['forecast']['daily']['pm25'][4]
                      ['max'];
              day5pm10 = (jsonaqiconverted['data']['forecast']['daily']['pm10']
                          .length <
                      8)
                  ? 0
                  : jsonaqiconverted['data']['forecast']['daily']['pm10'][4]
                      ['max'];
              day5o3 =
                  (jsonaqiconverted['data']['forecast']['daily']['o3'].length <
                          8)
                      ? 0
                      : jsonaqiconverted['data']['forecast']['daily']['o3'][4]
                          ['max'];
              day5uv =
                  (jsonaqiconverted['data']['forecast']['daily']['uvi'].length <
                          8)
                      ? 0
                      : jsonaqiconverted['data']['forecast']['daily']['uvi'][4]
                          ['max'];
              Navigator.popAndPushNamed(context, 'navigation');
            }
          }

          ////real exception
          else {
            print('execption is: $e');
            errorcolor = Colors.white;
            progress = false;
            errormessage = 'Opps! Something went wrong, try again later.';
          }
        });
      }
    }
  }

  void assignvariables() {
    situation = 1;
    city = jsonconverted['standard']['city'];
    country = jsonconverted['standard']['prov'];

    pm25 = jsonaqiconverted['data']['aqi'].round();

    pm10 = (jsonaqiconverted['data']['iaqi']['pm10'] == null)
        ? ' - -'
        : jsonaqiconverted['data']['iaqi']['pm10']['v'].toString();

    statement = assignstatement();
    cardcolor = assigncolor();
    station = jsonaqiconverted['data']['city']['name'];
    attribution = jsonaqiconverted['data']['attributions'][0]['name'];
    co = jsonaqiconverted['data']['iaqi']['co'] == null
        ? 00
        : jsonaqiconverted['data']['iaqi']['co']['v'].round();

    no2 = jsonaqiconverted['data']['iaqi']['no2'] == null
        ? 00
        : jsonaqiconverted['data']['iaqi']['no2']['v'].round();

    o3 = jsonaqiconverted['data']['iaqi']['o3'] == null
        ? 00
        : jsonaqiconverted['data']['iaqi']['o3']['v'].round();

    so2 = jsonaqiconverted['data']['iaqi']['so2'] == null
        ? 00
        : jsonaqiconverted['data']['iaqi']['so2']['v'].round();
    date1 = jsonaqiconverted['data']['forecast']['daily']['o3'][3]['day'];
    date2 = jsonaqiconverted['data']['forecast']['daily']['o3'][4]['day'];
    date3 = jsonaqiconverted['data']['forecast']['daily']['o3'][5]['day'];
    date4 = jsonaqiconverted['data']['forecast']['daily']['o3'][6]['day'];
    date5 = jsonaqiconverted['data']['forecast']['daily']['o3'][7]['day'];
    day1pm25 =
        jsonaqiconverted['data']['forecast']['daily']['pm25'][3]['max'].round();
    day1pm10 =
        jsonaqiconverted['data']['forecast']['daily']['pm10'][3]['max'].round();
    day1o3 =
        jsonaqiconverted['data']['forecast']['daily']['o3'][3]['max'].round();
    day1uv =
        jsonaqiconverted['data']['forecast']['daily']['uvi'][3]['max'].round();
    day2pm25 =
        jsonaqiconverted['data']['forecast']['daily']['pm25'][4]['max'].round();
    day2pm10 =
        jsonaqiconverted['data']['forecast']['daily']['pm10'][4]['max'].round();
    day2o3 =
        jsonaqiconverted['data']['forecast']['daily']['o3'][4]['max'].round();
    day2uv =
        jsonaqiconverted['data']['forecast']['daily']['uvi'][4]['max'].round();
    day3pm25 =
        jsonaqiconverted['data']['forecast']['daily']['pm25'][5]['max'].round();
    day3pm10 =
        jsonaqiconverted['data']['forecast']['daily']['pm10'][5]['max'].round();
    day3o3 =
        jsonaqiconverted['data']['forecast']['daily']['o3'][5]['max'].round();
    day3uv =
        jsonaqiconverted['data']['forecast']['daily']['uvi'][5]['max'].round();
    day4pm25 =
        (jsonaqiconverted['data']['forecast']['daily']['pm25'].length < 7)
            ? 0
            : jsonaqiconverted['data']['forecast']['daily']['pm25'][6]['max'];
    day4pm10 =
        (jsonaqiconverted['data']['forecast']['daily']['pm10'].length < 7)
            ? 0
            : jsonaqiconverted['data']['forecast']['daily']['pm10'][6]['max'];
    day4o3 = (jsonaqiconverted['data']['forecast']['daily']['o3'].length < 7)
        ? 0
        : jsonaqiconverted['data']['forecast']['daily']['o3'][6]['max'];
    day4uv = (jsonaqiconverted['data']['forecast']['daily']['uvi'].length < 7)
        ? 0
        : jsonaqiconverted['data']['forecast']['daily']['uvi'][6]['max'];
    day5pm25 =
        (jsonaqiconverted['data']['forecast']['daily']['pm25'].length < 8)
            ? 0
            : jsonaqiconverted['data']['forecast']['daily']['pm25'][7]['max'];
    day5pm10 =
        (jsonaqiconverted['data']['forecast']['daily']['pm10'].length < 8)
            ? 0
            : jsonaqiconverted['data']['forecast']['daily']['pm10'][7]['max'];
    day5o3 = (jsonaqiconverted['data']['forecast']['daily']['o3'].length < 8)
        ? 0
        : jsonaqiconverted['data']['forecast']['daily']['o3'][7]['max'];
    day5uv = (jsonaqiconverted['data']['forecast']['daily']['uvi'].length < 8)
        ? 0
        : jsonaqiconverted['data']['forecast']['daily']['uvi'][7]['max'];
  }

  String assignstatement() {
    if (pm25 > 300)
      return 'Health alert: everyone may experience serious health effects';
    else if (pm25 > 200)
      return 'Emergency conditions, the entire population is likely to be affected.';
    else if (pm25 > 150)
      return 'Everyone can experience health effects, sensitive groups experience serious effects.';
    else if (pm25 > 100)
      return 'Sensitive groups experience health effects, General public is not likely to be affected.';
    else if (pm25 > 50)
      return 'Acceptable, moderate health concern for people sensitive to air pollution.';
    else
      return 'Satisfactory, air pollution poses little or no risk.';
  }

  List<Color> assigncolor() {
    if (pm25 > 300)
      return [Color(0xFFF00B51), Color(0xFF730062)];
    else if (pm25 > 200)
      return [Colors.purple[300], Colors.purple[900]];
    else if (pm25 > 150)
      return [Color(0xFFFF5B94), Color(0xFF8441A4)];
    else if (pm25 > 100)
      return [Colors.deepOrange[400], Colors.pinkAccent[700]];
    else if (pm25 > 50)
      return [Color(0xFFFFA62E), Color(0xFFEA4D2C)];
    else
      return [Colors.blue, Colors.green];
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
