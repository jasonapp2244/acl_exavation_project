import 'dart:async';

import 'package:acl/model/truck_driver_record_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TruckLogDetailModelController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<TruckDriverRecordModel>> truckEntriesStream({DateTime? date}) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final DateTime selectedDate = date ?? DateTime.now();

    final DateTime startOfDay = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      0,
      0,
      0,
    );

    final DateTime endOfDay = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      23,
      59,
      59,
    );

    final entriesQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('isActive', isEqualTo: 1);

    return entriesQuery.snapshots().asyncMap((entriesSnapshot) async {
      Map<String, TruckDriverRecordModel> uniqueTrucks = {};

      await Future.wait(
        entriesSnapshot.docs.map((entry) async {
          final logsSnap = await entry.reference
              .collection("logs")
              .where(
                "timestamp",
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
              )
              .where(
                "timestamp",
                isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
              )
              .orderBy("timestamp", descending: true)
              .limit(1)
              .get();

          if (logsSnap.docs.isNotEmpty) {
            final latestLog = TruckDriverRecordModel.fromFirestore(
              logsSnap.docs.first,
            );

            // ✅ only add if not already present (keep unique truckNumber)
            if (!uniqueTrucks.containsKey(latestLog.truckNumber)) {
              uniqueTrucks[latestLog.truckNumber] = latestLog;
            } else {
              // compare timestamps → keep the latest one
              if (latestLog.timestamp!.isAfter(
                uniqueTrucks[latestLog.truckNumber]!.timestamp!,
              )) {
                uniqueTrucks[latestLog.truckNumber] = latestLog;
              }
            }
          }
        }),
      );

      final result = uniqueTrucks.values.toList()
        ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

      return result;
    });
  }
}
