// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';

class Tweets {
  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  String tweet;
  String createdBy;

  Tweets.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    this.id = documentSnapshot.id;
    this.createdAt = data['createdAt']?.toDate();
    this.modifiedAt = data['modifiedAt']?.toDate();
    this.tweet = data['tweet'];
    this.createdBy = data['createdBy'];
  }
}
