import 'dart:async';

import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/model/truck_log_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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

    // Stream of truck entries
    return truckEntriesRef.snapshots().switchMap((truckEntriesSnapshot) {
      final List<Stream<TruckDriverRecordModel>> truckStreams = [];

      for (var truckDoc in truckEntriesSnapshot.docs) {
        final truckData = truckDoc.data();

        // Stream of latest log for this truck
        final logStream = truckDoc.reference
            .collection('logs')
            .where('timeIn', isGreaterThanOrEqualTo: startOfDay)
            .where('timeIn', isLessThan: endOfDay)
            .orderBy('timeIn', descending: true)
            .snapshots()
            .map((logsSnapshot) {
              if (logsSnapshot.docs.isEmpty) {
                return TruckDriverRecordModel.fromMap({
                  'driverName': truckData['driverName'],
                  'truckNumber': truckData['truckNumber'],
                  'status': 'N/A',
                  'totalLogs': 0,
                });
              }

              final logData = logsSnapshot.docs.first.data();
              return TruckDriverRecordModel.fromMap({
                'driverName': truckData['driverName'],
                'truckNumber': truckData['truckNumber'],
                ...logData,
                'totalLogs': logsSnapshot.size,
              });
            });

        truckStreams.add(logStream);
      }

      // Combine all truck streams into a single stream
      return CombineLatestStream.list(truckStreams);
    });
  }

  Stream<List<TruckDriverRecordModel>> searchByTruckNumber(String searchText) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final truckEntriesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries');

    // Listen to all active truck entries
    return truckEntriesRef.where('isActive', isEqualTo: 1).snapshots().asyncMap(
      (snapshot) async {
        final List<TruckDriverRecordModel> results = [];

        for (var truckDoc in snapshot.docs) {
          final truckData = truckDoc.data();
          final truckNumber =
              truckData['truckNumber']?.toString().toLowerCase() ?? '';

          // Filter by searchText (partial match)
          if (searchText.trim().isNotEmpty &&
              !truckNumber.contains(searchText.trim().toLowerCase())) {
            continue; // skip if it doesn't match
          }

          // Fetch latest log for this truck
          final logsSnapshot = await truckDoc.reference
              .collection('logs')
              .orderBy('timeIn', descending: true)
              .limit(1)
              .get();

          Map<String, dynamic> mergedData = {
            'driverName': truckData['driverName'],
            'truckNumber': truckData['truckNumber'],
            'totalLogs': logsSnapshot.size,
          };

          if (logsSnapshot.docs.isNotEmpty) {
            mergedData.addAll(logsSnapshot.docs.first.data());
          }

          results.add(TruckDriverRecordModel.fromMap(mergedData));
        }

        return results;
      },
    );
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
