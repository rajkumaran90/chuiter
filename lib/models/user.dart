// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  User.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    this.id = documentSnapshot.id;
    this.displayName = data['displayName'];
    this.email = data['email'];
    this.photoUrl = data['photoUrl'];
  }
}
