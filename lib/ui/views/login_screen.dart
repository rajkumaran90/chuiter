// @dart=2.10
import 'package:flutter/material.dart';
import 'package:twitter/ui/router.dart';
import 'package:twitter/ui/views/base_view.dart';
import 'package:twitter/ui/widget/common/roundedButton.dart';
import 'package:twitter/viewmodels/login_model.dart';
import 'package:twitter/enums/view_state.dart';

// constants
const kPrimaryColor = Color(0xFF976FA2);
const kSecondaryColor = Color(0xFFBAA7E3);
const kLightColor = Color(0xFF868686);
const kDarkColor = Color(0xFF3D3041);
const kBackgroundColor = Color(0xFF050405);
const kAccentColor = Color(0xFF664CF5);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Unable to Login",
            ),
            content: Text("Please ensure your email and password are correct."),
            //buttons?
            actions: <Widget>[
              ElevatedButton(
                child: Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  void _signIn(
      BuildContext context, LoginModel loginModel, bool googleSSO) async {
    await loginModel.signIn(googleSSO);

    if (loginModel.userFound == true) {
      Navigator.pushNamedAndRemoveUntil(context, RouteScreen.tweetScreen,
          ModalRoute.withName(RouteScreen.welcomeScreen));
    } else {
      showErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BaseView<LoginModel>(
          builder: (BuildContext context, LoginModel loginModel, Widget child) {
            if (ViewState.Busy == loginModel.state) {
              return Center(
                  child: CircularProgressIndicator(
                color: kAccentColor,
              ));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 50),
                    child: Center(
                      child: Image.asset(
                        'assets/bird_1.png',
                        scale: 1.5,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: kSecondaryColor),
                      onChanged: (String email) {
                        loginModel.email = email;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: kSecondaryColor),
                        fillColor: kDarkColor,
                        filled: true,
                        suffixIcon: Icon(Icons.person, color: kSecondaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kSecondaryColor, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: kSecondaryColor),
                      onChanged: (String password) {
                        loginModel.password = password;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: kSecondaryColor),
                        fillColor: kDarkColor,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.lock,
                          color: kSecondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kSecondaryColor, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 10),
                    child: Center(
                      child: RoundedButton(
                        'Login',
                        () => _signIn(context, loginModel, false),
                      ),
                    ),
                  ),
                  Center(
                    child: RoundedButton(
                      'Google SSO',
                      () => _signIn(context, loginModel, true),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
