import 'dart:async';

import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/model/truck_log_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TruckLogsViewModel extends ChangeNotifier {
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void clearDateFilter() {
    _selectedDate = null;
    notifyListeners();
  }

  // Stream<List<TruckDriverRecordModel>> latestLogsForDateStream({
  //   DateTime? date,
  // }) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) throw Exception("User not logged in");

  //   date ??= DateTime.now();

  //   final startOfDay = DateTime(date.year, date.month, date.day);
  //   final endOfDay = startOfDay.add(const Duration(days: 1));

  //   final truckEntriesRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .collection('truck_entries');

  //   return truckEntriesRef.snapshots().asyncMap((truckEntriesSnapshot) async {
  //     final List<TruckDriverRecordModel> latestLogs = [];

  //     for (var truckDoc in truckEntriesSnapshot.docs) {
  //       final logsSnapshot = await truckDoc.reference
  //           .collection('logs')
  //           .where('timeIn', isGreaterThanOrEqualTo: startOfDay)
  //           .where('timeIn', isLessThan: endOfDay)
  //           .orderBy('timeIn', descending: true)
  //           .limit(1)
  //           .get();

  //       if (logsSnapshot.docs.isNotEmpty) {
  //         final logData = logsSnapshot.docs.first.data();
  //         final truckData = truckDoc.data();

  //         // Merge parent (truck) + log data
  //         final mergedData = {
  //           'driverName': truckData['driverName'],
  //           'truckNumber': truckData['truckNumber'],
  //           ...logData,
  //         };

  //         latestLogs.add(
  //           TruckDriverRecordModel.fromMap(
  //             mergedData,
  //           ), // Use fromMap constructor
  //         );
  //       }
  //     }

  //     return latestLogs;
  //   });
  // }
  Stream<List<TruckDriverRecordModel>> latestLogsForDateStream({
    DateTime? date,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    date ??= DateTime.now();

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final truckEntriesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries');

    return truckEntriesRef.snapshots().asyncMap((truckEntriesSnapshot) async {
      final List<TruckDriverRecordModel> latestLogs = [];

      for (var truckDoc in truckEntriesSnapshot.docs) {
        // Get logs for the day
        final logsSnapshot = await truckDoc.reference
            .collection('logs')
            .where('timeIn', isGreaterThanOrEqualTo: startOfDay)
            .where('timeIn', isLessThan: endOfDay)
            .orderBy('timeIn', descending: true)
            .get();

        if (logsSnapshot.docs.isNotEmpty) {
          final latestLog = logsSnapshot.docs.first.data();
          final truckData = truckDoc.data();

          // Merge parent truck info + latest log
          final mergedData = {
            'driverName': truckData['driverName'],
            'truckNumber': truckData['truckNumber'],
            ...latestLog,
            'totalLogs':
                logsSnapshot.size, // ✅ total logs for that truck (today)
          };

          latestLogs.add(TruckDriverRecordModel.fromMap(mergedData));
        }
      }

      return latestLogs;
    });
  }
Stream<List<TruckDriverRecordModel>> searchByTruckNumber(String truckNumber) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("User not logged in");

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('truck_entries')
      .where('truckNumber', isEqualTo: truckNumber)
      .snapshots()
      .asyncMap((snapshot) async {
        final List<TruckDriverRecordModel> logs = [];
        for (var truckDoc in snapshot.docs) {
          final logsSnapshot = await truckDoc.reference
              .collection('logs')
              .orderBy('timeIn', descending: true)
              .get();

          if (logsSnapshot.docs.isNotEmpty) {
            final latestLog = logsSnapshot.docs.first.data();
            final truckData = truckDoc.data();

            final mergedData = {
              'driverName': truckData['driverName'],
              'truckNumber': truckData['truckNumber'],
              ...latestLog,
              'totalLogs': logsSnapshot.size,
            };

            logs.add(TruckDriverRecordModel.fromMap(mergedData));
          }
        }
        return logs;
      });
}

  Future<void> deleteTruckEntry(String truckNo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final truckEntriesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries');

    // Find the truck entry matching truckNo
    final querySnapshot = await truckEntriesRef
        .where('truckNumber', isEqualTo: truckNo)
        .get();

    for (var truckDoc in querySnapshot.docs) {
      // Delete all logs inside this truck entry
      final logsSnapshot = await truckDoc.reference.collection('logs').get();
      for (var logDoc in logsSnapshot.docs) {
        await logDoc.reference.delete();
      }

      // Delete the truck entry document itself
      await truckDoc.reference.delete();
    }
    notifyListeners();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<TruckLogDetailModel> _truckLogs = [];
  List<TruckLogDetailModel> _allTruckLogs = [];
  String _driverName = "Loading...";
  bool _isLoading = true;
  String? _error;

  String get driverName => _driverName;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Clear all data
  void clearData() {
    _truckLogs = [];
    _allTruckLogs = [];
    //_driverName = "Loading...";
    _isLoading = true;
    _error = null;
    _selectedDate = null;
    notifyListeners();
  }

  // Apply date filter to the truck logs
  void _applyDateFilter() {
    if (_selectedDate == null) {
      _truckLogs = List.from(_allTruckLogs);
    } else {
      _truckLogs = _allTruckLogs.where((log) {
        if (log.timeIn == null) return false;

        // Compare only the date part (year, month, day)
        final logDate = DateTime(
          log.timeIn!.year,
          log.timeIn!.month,
          log.timeIn!.day,
        );
        final selectedDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
        );

        return logDate.isAtSameMomentAs(selectedDate);
      }).toList();
    }
  }
}
