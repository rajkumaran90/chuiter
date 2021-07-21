// @dart=2.10
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter/repository/base_repository.dart';
import 'package:twitter/models/tweets.dart';

class TweetRepository extends BaseRepository {
  static const String _collectionName = 'tweets';

  TweetRepository() : super(collectionName: _collectionName);

  Stream<List<Tweets>> tweetStream() {
    return collectionRef.orderBy('createdAt', descending: true).snapshots().map(
        (QuerySnapshot snapshot) => snapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                Tweets.fromDocumentSnapshot(documentSnapshot))
            .toList());
  }

  Future<void> addTweet(String tweet, String uid) async {
    await collectionRef.add(
      {
        'tweet': tweet,
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> deleteTweet(String docId) async {
    await collectionRef.doc(docId).delete();
  }

  Future<void> editTweet(String tweet, String docId) async {
    await collectionRef.doc(docId).set({
      'tweet': tweet,
    }, SetOptions(merge: true));
  }
}
