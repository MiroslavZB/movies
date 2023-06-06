import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final firestore = FirebaseFirestore.instance;

  // User
  static Future<void> postUser(List<int> savedIndexes, String email) async {
    try {
      await firestore.collection('users').doc(email).set({'savedIndexes': savedIndexes});
    } catch (_) {
      return;
    }
  }

  static Future<List> readUser(String email) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await firestore.collection("users").doc(email).get();
    if (doc.data() != null) {
      try {
        final savedIndexes_ = doc.data()!['savedIndexes'];
        if (savedIndexes_ is List) return savedIndexes_;
      } catch (_) {
        return [];
      }
    }
    return [];
  }
}
