import 'package:acl/model/truck_log_detail_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TruckLogDetailController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<TruckLogDetailModel> _truckLogs = [];
  List<TruckLogDetailModel> _allTruckLogs = [];
  String _driverName = "Loading...";
  bool _isLoading = true;
  String? _error;
  StreamSubscription<QuerySnapshot>? _subscription;
  DateTime? _selectedDate;

  // Getters
  List<TruckLogDetailModel> get truckLogs => _truckLogs;
  List<TruckLogDetailModel> get allTruckLogs => _allTruckLogs;
  String get driverName => _driverName;
  bool get isLoading => _isLoading;
  String? get error => _error;
  DateTime? get selectedDate => _selectedDate;

  // // Load truck logs for a specific truck number
  // Future<void> loadTruckLogs(String truckNumber) async {
  //   if (truckNumber.isEmpty) return;

  //   // Cancel any existing subscription
  //   await _subscription?.cancel();

  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) {
  //       _error = "User not authenticated";
  //       _isLoading = false;
  //       notifyListeners();
  //       return;
  //     }

  //     print('Loading truck logs for truck: $truckNumber');
  //     print('User ID: ${user.uid}');

  //     // Get the stream for truck entries
  //     final stream = _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('truck_entries')
  //         .where('truckNumber', isEqualTo: truckNumber.trim())
  //         .snapshots();

  //     // Listen to the stream and store the subscription
  //     _subscription = stream.listen(
  //       (snapshot) {
  //         print('Received snapshot with ${snapshot.docs.length} documents');
  //         _processSnapshot(snapshot, truckNumber);
  //       },
  //       onError: (error) {
  //         print('Stream error: $error');
  //         _error = "Error loading truck logs: $error";
  //         _isLoading = false;
  //         notifyListeners();
  //       },
  //     );
  //   } catch (e) {
  //     print('Exception in loadTruckLogs: $e');
  //     _error = "Error loading truck logs: $e";
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  // Process the Firestore snapshot

  Future<void> loadTruckLogs(String truckNumber) async {
    if (truckNumber.isEmpty) return;

    await _subscription?.cancel();

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = "User not authenticated";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // First find the parent truck entry
      final parentSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .where('truckNumber', isEqualTo: truckNumber.trim())
          .limit(1) // assuming only one active entry per truck
          .get();

      if (parentSnapshot.docs.isEmpty) {
        _error = "No entry found for this truck";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final parentDocId = parentSnapshot.docs.first.id;

      // Now listen to its logs subcollection
      final stream = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .doc(parentDocId)
          .collection('logs')
          .orderBy('timestamp', descending: true)
          .snapshots();

      _subscription = stream.listen(
        (snapshot) {
          print("Received ${snapshot.docs.length} logs for $truckNumber");
          _processSnapshot(snapshot, truckNumber); // ✅ call your helper
        },
        onError: (error) {
          print('Stream error: $error');
          _error = "Error loading truck logs: $error";
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      print('Exception in loadTruckLogs: $e');
      _error = "Error loading truck logs: $e";
      _isLoading = false;
      notifyListeners();
    }
  }

  void _processSnapshot(QuerySnapshot snapshot, String truckNumber) {
    try {
      print('Processing snapshot for truck: $truckNumber');
      print('Snapshot docs length: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        print('No documents found for truck: $truckNumber');
        _truckLogs = [];
        _driverName = "No driver found";
        _isLoading = false;
        _error = null;
        notifyListeners();
        return;
      }

      // Parse documents into models
      final records = snapshot.docs
          .map((doc) {
            try {
              print('Processing document: ${doc.id}');
              print('Document data: ${doc.data()}');
              return TruckLogDetailModel.fromFirestore(doc);
            } catch (e) {
              print('Error parsing document ${doc.id}: $e');
              print('Document data: ${doc.data()}');
              return null;
            }
          })
          .where((record) => record != null)
          .cast<TruckLogDetailModel>()
          .toList();

      // Sort by timestamp in descending order (most recent first)
      records.sort((a, b) {
        final aTime = a.timestamp ?? DateTime.now();
        final bTime = b.timestamp ?? DateTime.now();
        return bTime.compareTo(aTime);
      });

      // Update the driver name from the first record
      if (records.isNotEmpty) {
        _driverName = records.first.driverName ?? '';
        print('Driver name set to: $_driverName');
      } else {
        _driverName = "No driver found";
      }

      _allTruckLogs = records;
      _applyDateFilter();
      _isLoading = false;
      _error = null;
      notifyListeners();

      print('Successfully loaded ${records.length} truck logs');
    } catch (e) {
      print('Error in _processSnapshot: $e');
      _error = "Error processing data: $e";
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> deleteTruckLog(String parentDocId, String logId) async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) return;

  //     await _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('truck_entries')
  //         .doc(parentDocId) // parent ticket
  //         .collection('logs') // logs subcollection
  //         .doc(logId) // specific log
  //         .delete();

  //     print("Log $logId deleted successfully from truck entry $parentDocId");
  //     // The stream will auto-update UI
  //   } catch (e) {
  //     _error = "Error deleting log: $e";
  //     notifyListeners();
  //   }
  // }

  // Clear all data
  void clearData() {
    _truckLogs = [];
    _allTruckLogs = [];
    _driverName = "Loading...";
    _isLoading = true;
    _error = null;
    _selectedDate = null;
    notifyListeners();
  }

  // Set selected date for filtering
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _applyDateFilter();
    notifyListeners();
  }

  // Clear date filter
  void clearDateFilter() {
    _selectedDate = null;
    _applyDateFilter();
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

  // Debug method to test data loading
  Future<void> debugLoadTruckLogs(String truckNumber) async {
    print('=== DEBUG: Loading truck logs for: $truckNumber ===');

    final user = _auth.currentUser;
    if (user == null) {
      print('DEBUG: User not authenticated');
      return;
    }

    try {
      // Get all documents first to see what's available
      final allDocs = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .get();

      print('DEBUG: Total documents in collection: ${allDocs.docs.length}');

      for (var doc in allDocs.docs) {
        final data = doc.data();
        print(
          'DEBUG: Document ${doc.id} - truckNumber: "${data['truckNumber']}"',
        );
      }

      // Now try the specific query
      final specificDocs = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .where('truckNumber', isEqualTo: truckNumber.trim())
          .get();

      print(
        'DEBUG: Documents matching "$truckNumber": ${specificDocs.docs.length}',
      );
    } catch (e) {
      print('DEBUG: Error in debug method: $e');
    }
  }

  // Refresh data
  Future<void> refreshData(String truckNumber) async {
    clearData();
    await loadTruckLogs(truckNumber);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
