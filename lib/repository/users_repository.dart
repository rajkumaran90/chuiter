// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter/repository/base_repository.dart';
import 'package:twitter/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserRepository extends BaseRepository {
  static const String _collectionName = 'users';

  UserRepository() : super(collectionName: _collectionName);

  Future<User> get(String uid) async {
    DocumentSnapshot snapshot = await collectionRef.doc(uid).get();

    if (snapshot.exists) {
      return User.fromDocumentSnapshot(snapshot);
    }

    return null;
  }

  Future<void> writeUser(auth.User user) async {
    await collectionRef.doc(user.uid).set(
      {
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
      },
    );
  }
}
