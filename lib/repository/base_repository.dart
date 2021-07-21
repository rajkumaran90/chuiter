// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class BaseRepository {
  final String collectionName;
  CollectionReference<Map<String, dynamic>> collectionRef;

  BaseRepository({@required this.collectionName}) {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    collectionRef = FirebaseFirestore.instance.collection(this.collectionName);
  }
}
