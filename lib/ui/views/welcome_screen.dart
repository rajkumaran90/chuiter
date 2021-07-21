// @dart=2.10
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twitter/ui/router.dart';
import 'package:twitter/ui/widget/common/roundedButton.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Image.asset(
                'assets/bird_1.png',
                scale: 1,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            'Welcome to Chuiter',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: RoundedButton('Enough of waiting. Tap me!',
                () => Navigator.pushNamed(context, RouteScreen.loginScreen)),
          )
        ],
      )),
    );
  }
}
