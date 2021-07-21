// @dart=2.10

import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/repository/users_repository.dart';
import 'package:twitter/viewmodels/base_model.dart';
import 'package:twitter/services/authentication_service.dart';
import 'package:twitter/locator.dart';
import 'package:twitter/enums/view_state.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator.get<AuthenticationService>();

  final UserRepository _userRepository = locator.get<UserRepository>();
  bool userFound = false;
  String email;
  String password;

  Future<void> signIn(bool googleSSO) async {
    setState(ViewState.Busy);
    await _authenticationService.signOut();
    UserCredential firebaseUser;
    if (googleSSO) {
      firebaseUser = await _authenticationService.signInWithGoogle();
    } else {
      firebaseUser = await _authenticationService.signInEmail(email, password);
    }

    if (firebaseUser != null) {
      userFound = true;
      await _userRepository.writeUser(firebaseUser.user);
    } else {
      userFound = false;
    }
    setState(ViewState.Idle);
  }
}
