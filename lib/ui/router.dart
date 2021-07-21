// @dart=2.10
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter/ui/views/login_screen.dart';
import 'package:twitter/ui/views/tweet_screen.dart';
import 'package:twitter/ui/views/welcome_screen.dart';

class RouteScreen {
  static const String welcomeScreen = '/';
  static const String loginScreen = '/login';
  static const String tweetScreen = '/tweet';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen(),
          fullscreenDialog: true,
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
          fullscreenDialog: true,
        );

      case tweetScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => TweetScreen(),
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
