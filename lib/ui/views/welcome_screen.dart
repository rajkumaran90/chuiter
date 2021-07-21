// @dart=2.10
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twitter/ui/router.dart';
import 'package:twitter/ui/widget/common/roundedButton.dart';

// constants
const kPrimaryColor = Color(0xFF976FA2);
const kSecondaryColor = Color(0xFFBAA7E3);
const kLightColor = Color(0xFF868686);
const kDarkColor = Color(0xFF3D3041);
const kBackgroundColor = Color(0xFF050405);
const kAccentColor = Color(0xFF664CF5);

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                color: kPrimaryColor,
              ),
            ),
          ),
          Text(
            'Welcome to Chuiter',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: RoundedButton('Thinking out loud? Tap me!',
                () => Navigator.pushNamed(context, RouteScreen.loginScreen)),
          )
        ],
      )),
    );
  }
}
