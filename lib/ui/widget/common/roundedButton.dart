import 'package:flutter/material.dart';

// constants
const kPrimaryColor = Color(0xFF976FA2);
const kSecondaryColor = Color(0xFFBAA7E3);
const kLightColor = Color(0xFF868686);
const kDarkColor = Color(0xFF3D3041);
const kBackgroundColor = Color(0xFF373847);
const kAccentColor = Color(0xFF664CF5);

class RoundedButton extends StatelessWidget {
  const RoundedButton(this.buttonText, this.onPressed);
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 300, height: 40),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(10),
            backgroundColor: MaterialStateProperty.all<Color>(kSecondaryColor)),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: kDarkColor, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
