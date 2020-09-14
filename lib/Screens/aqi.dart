import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'splashscreen.dart';

String city;
String country;
int pm25;
String pm10;
String statement;
List<Color> cardcolor;
String station;
String attribution;
int co;
int no2;
int o3;
int so2;
String date1 = 'Yesterday';
String date2 = 'Today';
String date3 = 'Tomorrow';
String date4;
String date5;
int day1pm25;
int day1pm10;
int day1o3;
int day1uv;
int day2pm25;
int day2pm10;
int day2o3;
int day2uv;
int day3pm25;
int day3pm10;
int day3o3;
int day3uv;
int day4pm25;
int day4pm10;
int day4o3;
int day4uv;
int day5pm25;
int day5pm10;
int day5o3;
int day5uv;
int situation = 0;

class Aqi extends StatefulWidget {
  @override
  _AqiState createState() => _AqiState();
}

class _AqiState extends State<Aqi> {
  Widget scrollcard(String day, int pm25, int pm10, int o3, int uv) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '$day',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'PM 2.5: $pm25',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'PM10:$pm10   O3:$o3   UV:$uv',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              colors: [Colors.pinkAccent[700], Color(0xFF8441A4)],
              begin: Alignment.topLeft),
        ),
        width: 6 * MediaQuery.of(context).size.width / 9,
      ),
    );
  }

  ///////////////////////////

  ////////////////////

  //////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (situation == 0) assignvalue();
  }

  var aqijson = jsonDecode(aqidata.body);
  var placejson = jsonDecode(citycountry.body);

  void assignvalue() {
    city = placejson['city'];
    country = placejson['prov'];

    pm25 = aqijson['data']['aqi'].round();

    pm10 = (aqijson['data']['iaqi']['pm10'] == null)
        ? ' - -'
        : aqijson['data']['iaqi']['pm10']['v'].toString();

    statement = assignstatement();
    cardcolor = assigncolor();
    station = aqijson['data']['city']['name'];
    attribution = aqijson['data']['attributions'][0]['name'];
    co = aqijson['data']['iaqi']['co'] == null
        ? 00
        : aqijson['data']['iaqi']['co']['v'].round();

    no2 = aqijson['data']['iaqi']['no2'] == null
        ? 00
        : aqijson['data']['iaqi']['no2']['v'].round();

    o3 = aqijson['data']['iaqi']['o3'] == null
        ? 00
        : aqijson['data']['iaqi']['o3']['v'].round();

    so2 = aqijson['data']['iaqi']['so2'] == null
        ? 00
        : aqijson['data']['iaqi']['so2']['v'].round();
    date1 = aqijson['data']['forecast']['daily']['pm25'][3]['day'];
    date2 = aqijson['data']['forecast']['daily']['pm25'][4]['day'];
    date3 = aqijson['data']['forecast']['daily']['pm25'][5]['day'];
    date4 = aqijson['data']['forecast']['daily']['pm25'][6]['day'];
    date5 = aqijson['data']['forecast']['daily']['pm25'][7]['day'];
    day1pm25 = aqijson['data']['forecast']['daily']['pm25'][3]['max'].round();
    day1pm10 = aqijson['data']['forecast']['daily']['pm10'][3]['max'].round();
    day1o3 = aqijson['data']['forecast']['daily']['o3'][3]['max'].round();
    day1uv = aqijson['data']['forecast']['daily']['uvi'][3]['max'].round();
    day2pm25 = aqijson['data']['forecast']['daily']['pm25'][4]['max'].round();
    day2pm10 = aqijson['data']['forecast']['daily']['pm10'][4]['max'].round();
    day2o3 = aqijson['data']['forecast']['daily']['o3'][4]['max'].round();
    day2uv = aqijson['data']['forecast']['daily']['uvi'][4]['max'].round();
    day3pm25 = aqijson['data']['forecast']['daily']['pm25'][5]['max'].round();
    day3pm10 = aqijson['data']['forecast']['daily']['pm10'][5]['max'].round();
    day3o3 = aqijson['data']['forecast']['daily']['o3'][5]['max'].round();
    day3uv = aqijson['data']['forecast']['daily']['uvi'][5]['max'].round();
    day4pm25 = (aqijson['data']['forecast']['daily']['pm25'].length < 7)
        ? 0
        : aqijson['data']['forecast']['daily']['pm25'][6]['max'];
    day4pm10 = (aqijson['data']['forecast']['daily']['pm10'].length < 7)
        ? 0
        : aqijson['data']['forecast']['daily']['pm10'][6]['max'];
    day4o3 = (aqijson['data']['forecast']['daily']['o3'].length < 7)
        ? 0
        : aqijson['data']['forecast']['daily']['o3'][6]['max'];
    day4uv = (aqijson['data']['forecast']['daily']['uvi'].length < 7)
        ? 0
        : aqijson['data']['forecast']['daily']['uvi'][6]['max'];
    day5pm25 = (aqijson['data']['forecast']['daily']['pm25'].length < 8)
        ? 0
        : aqijson['data']['forecast']['daily']['pm25'][7]['max'];
    day5pm10 = (aqijson['data']['forecast']['daily']['pm10'].length < 8)
        ? 0
        : aqijson['data']['forecast']['daily']['pm10'][7]['max'];
    day5o3 = (aqijson['data']['forecast']['daily']['o3'].length < 8)
        ? 0
        : aqijson['data']['forecast']['daily']['o3'][7]['max'];
    day5uv = (aqijson['data']['forecast']['daily']['uvi'].length < 8)
        ? 0
        : aqijson['data']['forecast']['daily']['uvi'][7]['max'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black12, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0,
                spreadRadius: 5.0,
                offset: Offset(0, 10),
              )
            ]),
            height: 6 * MediaQuery.of(context).size.height / 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15),
                  child: Text(
                    'Air Quality Index',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 15, top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.black45,
                          ),
                          (city.length < 12)
                              ? Text(
                                  '$city, $country'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black45),
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      '$city'.substring(0, 12).toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black45),
                                    ),
                                    Text(
                                      ',$country'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black45),
                                    ),
                                  ],
                                )
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'searcha');
                        },
                        shape: StadiumBorder(),
                        color: Colors.lightBlueAccent,
                        splashColor: Colors.blue[600],
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.search,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              ' Search',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                            colors: cardcolor, begin: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                            offset: Offset(6.0, 6.0),
                          )
                        ]),
                    height: MediaQuery.of(context).size.height / 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$pm25',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      ' PM 2.5: $pm25',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text('PM 10: $pm10',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                '$statement',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    FaIcon(FontAwesomeIcons.tachometerAlt),
                                    Text('   Monitoring Station'),
                                  ],
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Nearest monitoring station from the location of interest is found at: ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        '$station.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, left: 15, bottom: 25),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: FaIcon(
                                    FontAwesomeIcons.tachometerAlt,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Monitoring Station',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                Colors.blue[800],
                                Colors.deepPurple[500]
                              ], begin: Alignment.topLeft),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(6.0, 6.0),
                                )
                              ]),
                          height: MediaQuery.of(context).size.height / 12,
                          width: 4 * MediaQuery.of(context).size.width / 9,
                        ),
                      ),
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
                                    FaIcon(FontAwesomeIcons.clipboardCheck),
                                    Text('   EPA Attribution'),
                                  ],
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'All the data for this location is provided by: ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        '$attribution.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, right: 15, bottom: 25),
                        child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.clipboardCheck,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        'EPA Attribution',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(colors: [
                                  Colors.blue[800],
                                  Colors.deepPurple[500]
                                ], begin: Alignment.topLeft),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(6.0, 6.0),
                                  )
                                ]),
                            height: MediaQuery.of(context).size.height / 12,
                            width: 4 * MediaQuery.of(context).size.width / 9),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 4 * MediaQuery.of(context).size.height / 10,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    'Individual AQI :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  '$o3',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 75,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'O3',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer()
                              ],
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage('images/air1.jpg'),
                          ),
                        ),
                        height: 4 * MediaQuery.of(context).size.width / 9,
                        width: 4 * MediaQuery.of(context).size.width / 9,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  '$no2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 75,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'NO2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer()
                              ],
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage('images/air2.jpg'),
                          ),
                        ),
                        height: 4 * MediaQuery.of(context).size.width / 9,
                        width: 4 * MediaQuery.of(context).size.width / 9,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                '$co',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 75,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'CO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            image: AssetImage('images/air3.jpg')),
                      ),
                      height: 4 * MediaQuery.of(context).size.width / 9,
                      width: 4 * MediaQuery.of(context).size.width / 9,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                '$so2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 75,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'SO2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            image: AssetImage('images/air4.jpg')),
                      ),
                      height: 4 * MediaQuery.of(context).size.width / 9,
                      width: 4 * MediaQuery.of(context).size.width / 9,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Forecast :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 4 * MediaQuery.of(context).size.width / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        scrollcard(date1, day1pm25, day1pm10, day1o3, day1uv),
                        scrollcard(date2, day2pm25, day2pm10, day2o3, day2uv),
                        scrollcard(date3, day3pm25, day3pm10, day3o3, day3uv),
                        scrollcard(
                            '$date4', day4pm25, day4pm10, day4o3, day4uv),
                        scrollcard(
                            '$date5', day5pm25, day5pm10, day5o3, day5uv),
                        SizedBox(
                          width: 17,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
