// @dart=2.10
import 'package:flutter/material.dart';
import 'package:twitter/ui/router.dart';
import 'package:twitter/ui/views/base_view.dart';
import 'package:twitter/ui/widget/tweet/tweet_card.dart';
import 'package:twitter/ui/widget/tweet/tweet_text_field.dart';
import 'package:twitter/viewmodels/tweet_model.dart';
import 'package:twitter/enums/view_state.dart';

class TweetScreen extends StatefulWidget {
  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  Widget tweetsListing(BuildContext context, TweetModel tweetModel) {
    return ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return TweetCard(tweetModel.tweetsList[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 20,
              thickness: 0.5,
              color: Colors.blueGrey,
            ),
        itemCount: tweetModel.tweetsList.length);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TweetModel>(
        onModelReady: (TweetModel tweetModel) => tweetModel.initial(),
        builder: (BuildContext context, TweetModel tweetModel, Widget child) {
          if (ViewState.Busy == tweetModel.state) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 22, 32, 42),
            bottomSheet: TweetTextField(),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 22, 32, 42),
              title: Text(
                'Tweets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              leading: Padding(
                padding: EdgeInsets.all(10),
                child: tweetModel.currentUser.photoURL != null
                    ? Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(tweetModel.currentUser.photoURL),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                        radius: 20,
                      ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      tweetModel.signOut();
                      Navigator.popAndPushNamed(
                          context, RouteScreen.welcomeScreen);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: tweetsListing(context, tweetModel),
            ),
          );
        });
  }
}
