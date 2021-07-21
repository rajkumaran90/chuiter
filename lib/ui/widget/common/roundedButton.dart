import 'package:flutter/material.dart';

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
            elevation: MaterialStateProperty.all<double>(10),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade200)),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
