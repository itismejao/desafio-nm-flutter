import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(6, 5, 145, 1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('img/LOGO_ANIMATION.gif'),
              //height: 100,
              //width: 200,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
