// @dart=2.10
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/viewmodels/tweet_model.dart';

// constants
const kPrimaryColor = Color(0xFF976FA2);
const kSecondaryColor = Color(0xFFBAA7E3);
const kLightColor = Color(0xFF868686);
const kDarkColor = Color(0xFF3D3041);
const kBackgroundColor = Color(0xFF050405);
const kAccentColor = Color(0xFF664CF5);

class TweetTextField extends StatefulWidget {
  @override
  _TweetTextFieldState createState() => _TweetTextFieldState();
}

class _TweetTextFieldState extends State<TweetTextField> {
  TextEditingController _tweetController = TextEditingController();
  FocusNode tweetFieldFocus;

  @override
  void initState() {
    tweetFieldFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    tweetFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TweetModel tweetModel = Provider.of(context);

    return Container(
      color: kBackgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 20, right: 10),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    counterStyle: TextStyle(color: kSecondaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryColor),
                    ),
                    labelText: 'Tweet Here',
                    labelStyle: TextStyle(
                        color: kSecondaryColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        fontWeight: FontWeight.w400)),
                focusNode: tweetFieldFocus,
                controller: _tweetController,
                maxLength: 280,
                minLines: 1,
                maxLines: 3,
                onChanged: (String value) {
                  tweetModel.tweetText = value;
                },
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (_tweetController.text.characters.isNotEmpty) {
                  tweetFieldFocus.unfocus();
                  _tweetController.clear();
                  tweetModel.sendTweet();
                }
              },
              icon: Icon(
                Icons.send_rounded,
                color: kPrimaryColor,
                size: 30,
              )),
        ],
      ),
    );
  }
}
