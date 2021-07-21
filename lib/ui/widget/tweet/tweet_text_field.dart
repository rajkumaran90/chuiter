// @dart=2.10
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/viewmodels/tweet_model.dart';

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
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 20, right: 10),
              child: TextField(
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
                tweetFieldFocus.unfocus();
                _tweetController.clear();
                tweetModel.sendTweet();
              },
              icon: Icon(Icons.send_rounded)),
        ],
      ),
    );
  }
}
