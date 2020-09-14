import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Firsttime extends StatefulWidget {
  @override
  _FirsttimeState createState() => _FirsttimeState();
}

class _FirsttimeState extends State<Firsttime>
    with SingleTickerProviderStateMixin {
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

  Widget givewidget() {
    if (tap == 0)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hola.',
            style: TextStyle(
                fontSize: 150,
                color: Colors.white,
                fontWeight: FontWeight.w200),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Few things before you start, tap to continue.',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    if (tap == 1)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset('images/ins1.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Tap on the location at the top to search for a new city.',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset('images/ins2.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Tap on \'More\' to reveal further details about the weather.',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    if (tap == 2)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset(
              'images/ins3.jpg',
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Text(
              'Swipe left to go to the next page.',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
  }

  int tap = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (tap == 2) Navigator.pushNamed(context, 'navigation');
          setState(() {
            tap++;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, myanimation.value],
                begin: Alignment.topLeft),
          ),
          child: givewidget(),
        ),
      ),
    );
  }
}
