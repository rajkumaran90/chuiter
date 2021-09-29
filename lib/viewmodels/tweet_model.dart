// @dart=2.10
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/models/tweets.dart';
import 'package:twitter/repository/tweet_repository.dart';
import 'package:twitter/repository/users_repository.dart';
import 'package:twitter/viewmodels/base_model.dart';
import 'package:twitter/services/authentication_service.dart';
import 'package:twitter/locator.dart';
import 'package:twitter/enums/view_state.dart';
import 'package:twitter/models/user.dart' as userM;

class TweetModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator.get<AuthenticationService>();
  final TweetRepository _tweetRepository = locator.get<TweetRepository>();
  final UserRepository _userRepository = locator.get<UserRepository>();

  User currentUser;
  String tweetText;
  List<Tweets> tweetsList = [];

  void initial() {
    setState(ViewState.Busy);
    currentUser = _authenticationService.currentUser;
    _tweetRepository.tweetStream().listen((List<Tweets> list) {
      tweetsList = list;
      notifyListeners();
    });

    setState(ViewState.Idle);
  }

  Future<void> sendTweet() async {
    await _tweetRepository.addTweet(tweetText, currentUser.uid);
  }

  Future<userM.User> getUserDetails(String uid) async {
    userM.User userModel = await _userRepository.get(uid);
    return userModel;
  }

  void signOut() async {
    _authenticationService.signOut();
  }

  void deleteTweet(String docId) async {
    await _tweetRepository.deleteTweet(docId);
  }

  void editTweet(String tweet, String docId) async {
    await _tweetRepository.editTweet(tweet, docId);
  }
}
