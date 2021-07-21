// @dart=2.10
import 'package:flutter/material.dart';
import 'package:twitter/ui/router.dart';
import 'package:twitter/ui/views/base_view.dart';
import 'package:twitter/ui/widget/tweet/tweet_card.dart';
import 'package:twitter/ui/widget/tweet/tweet_text_field.dart';
import 'package:twitter/viewmodels/tweet_model.dart';
import 'package:twitter/enums/view_state.dart';

// constants
const kPrimaryColor = Color(0xFF976FA2);
const kSecondaryColor = Color(0xFFBAA7E3);
const kLightColor = Color(0xFF868686);
const kDarkColor = Color(0xFF3D3041);
const kBackgroundColor = Color(0xFF050405);
const kAccentColor = Color(0xFF664CF5);

class TweetScreen extends StatefulWidget {
  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  Widget tweetsListing(BuildContext context, TweetModel tweetModel) {
    return Padding(
      padding: EdgeInsets.only(bottom: 85, top: 5),
      child: ListView.separated(
          itemBuilder: (BuildContext context, index) {
            return TweetCard(tweetModel.tweetsList[index]);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 20,
                thickness: 0.5,
                color: kBackgroundColor,
              ),
          itemCount: tweetModel.tweetsList.length),
    );
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
            backgroundColor: kBackgroundColor,
            bottomSheet: TweetTextField(),
            appBar: AppBar(
              backgroundColor: kDarkColor,
              title: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Tweets',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
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
                        backgroundColor: kPrimaryColor,
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
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
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
