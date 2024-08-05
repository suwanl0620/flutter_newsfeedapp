import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// stores posts made by users in collection "Posts" in Firebase

class FirestoreDatabase {
  // current user
  User? user = FirebaseAuth.instance.currentUser;
  // retrieve collection of posts from Firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');
  // add post
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
      'Likes': 0,
    });
  }
  Future<void> incrementLikes(String postId) {
    return posts.doc(postId).update({'likes': FieldValue.increment(1)});
  }

  // read post from database
  Stream<QuerySnapshot> getPosts() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}
