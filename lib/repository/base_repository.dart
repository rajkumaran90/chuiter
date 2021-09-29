// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class BaseRepository {
  final String collectionName;
  CollectionReference<Map<String, dynamic>> collectionRef;

  BaseRepository({@required this.collectionName}) {
    final instance = FirebaseFirestore.instance;
    instance.settings = Settings(persistenceEnabled: true);
    collectionRef = instance.collection(this.collectionName);
  }
}
