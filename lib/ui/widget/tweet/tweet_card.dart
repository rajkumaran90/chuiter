// @dart=2.10

import 'package:flutter/material.dart';
import 'package:twitter/models/tweets.dart';
import 'package:provider/provider.dart';
import 'package:twitter/viewmodels/tweet_model.dart';
import 'package:twitter/models/user.dart';
import 'package:intl/intl.dart';

class TweetCard extends StatelessWidget {
  const TweetCard(this.tweet);

  final Tweets tweet;

  @override
  Widget build(BuildContext context) {
    TextEditingController _tweetEditController = TextEditingController();
    TweetModel tweetModel = Provider.of(context);

    _showDialog() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLength: 280,
                      minLines: 1,
                      maxLines: 5,
                      controller: _tweetEditController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Tweet',
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                ElevatedButton(
                    child: const Text('DONE'),
                    onPressed: () {
                      tweetModel.editTweet(_tweetEditController.text, tweet.id);
                      Navigator.pop(context);
                    })
              ],
            );
          });
    }

    Widget cardMenu() {
      return PopupMenuButton(
        color: Color.fromARGB(255, 22, 32, 42),
        initialValue: 2,
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 0,
              child: IconButton(
                  onPressed: () async {
                    _tweetEditController.text = tweet.tweet;
                    await _showDialog();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ),
            PopupMenuItem(
              value: 1,
              child: IconButton(
                  onPressed: () {
                    tweetModel.deleteTweet(tweet.id);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  )),
            ),
          ];
        },
      );
    }

    return Column(
      children: [
        FutureBuilder(
          future: tweetModel.getUserDetails(tweet.createdBy),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done ||
                snapshot.hasError ||
                snapshot.data == null) {
              return Container();
            }

            User tweetUser = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: tweetUser.photoUrl != null
                      ? Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(tweetUser.photoUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                          radius: 25,
                        ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tweetUser.displayName,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  color: Colors.grey[300]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '⬤  ' +
                                  DateFormat('h:mm a  dd MMMM ')
                                      .format(tweet.createdAt),
                              style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tweet.tweet,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                tweet.createdBy == tweetModel.currentUser.uid
                    ? cardMenu()
                    : IconButton(onPressed: () {}, icon: Container())
              ],
            );
          },
        )
      ],
    );
  }
}
