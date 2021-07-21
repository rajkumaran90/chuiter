// @dart=2.10

import 'package:flutter/material.dart';
import 'locator.dart';
import 'ui/router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuiter',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      initialRoute: RouteScreen.welcomeScreen,
      onGenerateRoute: RouteScreen.generateRoute,
    );
  }
}
