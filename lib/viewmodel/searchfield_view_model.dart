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

  if (searchText.isNotEmpty) {
    query = query.where('truckNumber', isEqualTo: searchText.trim());
  }
  if (searchText.isNotEmpty) {
    query = query
        .where('truckNumber', isGreaterThanOrEqualTo: searchText.trim())
        .where(
          'truckNumber',
          isLessThanOrEqualTo: '${searchText.trim()}\uf8ff',
        );
  }
  return query.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
        .toList();
  });
}
