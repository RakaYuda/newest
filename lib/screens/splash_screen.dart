import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newest/screens/news_screen.dart';
import 'package:newest/style/style.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(NewsScreen.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: kPrimaryColor,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 86,
        ),
      ),
    ));
  }
}
