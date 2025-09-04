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

    final query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('status', isEqualTo: 'On Site')
        .where('isActive', isEqualTo: 1);

    return query.snapshots().map((snapshot) {
      final allTrucks = snapshot.docs
          .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
          .toList();

      if (searchText.trim().isEmpty) return allTrucks;

      final text = searchText.trim().toLowerCase();
      return allTrucks.where((truck) {
        final truckNum = truck.truckNumber.toLowerCase().replaceAll(' ', '');
        return truckNum.contains(text);
      }).toList();
    });
  }
}
