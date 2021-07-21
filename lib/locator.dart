// @dart=2.10
import 'package:get_it/get_it.dart';
import 'package:twitter/repository/tweet_repository.dart';
import 'package:twitter/repository/users_repository.dart';
import 'package:twitter/services/authentication_service.dart';
import 'package:twitter/viewmodels/login_model.dart';
import 'package:twitter/viewmodels/tweet_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => TweetModel());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => TweetRepository());
}
