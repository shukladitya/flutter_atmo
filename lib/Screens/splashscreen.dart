import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Response response;
Response citycountry;
Response aqidata;

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void getlocationandJSON() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
    } catch (e) {
      setState(() {
        errormessage =
            "We need Location data to fetch your current weather conditions. Please restart the app and Allow.";
      });
    }
    try {
      response = await get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&%20,daily&appid=6fd385c80e79ad3ff4341df13d6c8b94&units=metric');
    } catch (e) {
      setState(() {
        errormessage = 'Something went wrong. Check connection and try again.';
      });
    }
    try {
      citycountry =
          await get('https://geocode.xyz/$latitude,$longitude?geoit=json');
    } catch (e) {
      setState(() {
        errormessage = 'Something went wrong. Check connection and try again.';
      });
    }
    try {
      aqidata = await get(
          'https://api.waqi.info/feed/geo:$latitude;$longitude/?token=894b3da83e2b2bf3d998096570ee587f6be6eabc');
    } catch (e) {
      setState(() {
        errormessage = 'Something went wrong. Check connection and try again.';
      });
    }
  }

  putdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('visiting', true);
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyvisited = preferences.getBool('visiting') ?? false;
    return alreadyvisited;
  }

  gettonextpage() async {
    bool visitingflag = await getdata();
    if (visitingflag == false) {
      putdata();
      Navigator.pushNamed(context, 'firsttime');
    } else if (visitingflag == true) {
      Navigator.pushNamed(context, 'navigation');
    }
  }

  String errormessage = '';
  double latitude;
  double longitude;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationandJSON();

    Timer ticker;
    ticker = Timer.periodic(Duration(seconds: 8), (timer) {
      try {
        if (response.statusCode == 200) {
          ticker.cancel();
          print(response.body);
          print(citycountry.body);

          gettonextpage();
        }
      } catch (e) {
        print(e);
        setState(() {
          errormessage =
              'Internet is too slow or not connected. Check network or wait.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/logo2.gif'),
                      fit: BoxFit.contain)),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    '$errormessage',
                    style: TextStyle(fontSize: 17, color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                )),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/banner.png'),
                      fit: BoxFit.contain)),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
