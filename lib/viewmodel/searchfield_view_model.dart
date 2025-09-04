import 'package:acl/model/truck_driver_record_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier {
  Stream<List<TruckDriverRecordModel>> truckEntriesStream({
    String searchText = "",
  }) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('status', isEqualTo: 'On Site')
        .where('isActive', isEqualTo: 1);

    if (searchText.isNotEmpty) {
      query = query.where('truckNumber', isEqualTo: searchText.trim());
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
          .toList();
    });
  }
}

Stream<List<TruckDriverRecordModel>> truckEntriesStream({
  String searchText = "",
}) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("User not logged in");

  Query<Map<String, dynamic>> query = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('truck_entries')
      .where('isActive', isEqualTo: 1);

  // 🔎 If search is not empty, filter progressively
  if (searchText.trim().isNotEmpty) {
    final text = searchText.trim();
    query = query
        .where('truckNumber', isGreaterThanOrEqualTo: text)
        .where('truckNumber', isLessThanOrEqualTo: '$text\uf8ff');
  }

  return query.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
        .toList();
  });
}
