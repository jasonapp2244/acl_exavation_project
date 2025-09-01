import 'package:acl/model/truck_driver_record_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TruckEntryViewModel extends ChangeNotifier {
  String driverName = '';
  String truckNumber = '';
  String additionalNotes = '';
  String licensePlatePhotoPath = '';
  String status = '';
  DateTime? timeIn;
  bool? isTimeInLoading;
  bool? isActive;
  List<TruckDriverRecordModel> truckEntries = [];
  bool isLoading = false;
  bool isSaveLoading = false;
  TextEditingController driverNameController = new TextEditingController();
  TextEditingController additionalController = new TextEditingController();
  TextEditingController truckNumberController = new TextEditingController();

  void setDriverName(String name) {
    driverName = name;
    notifyListeners();
  }

  void setTruckNumber(String number) {
    truckNumber = number;
    notifyListeners();
  }

  void setAdditionalNotes(String notes) {
    additionalNotes = notes;
    notifyListeners();
  }

  void setLicensePlatePhoto(String path) {
    licensePlatePhotoPath = path;
    notifyListeners();
  }

  Future<void> saveTruckEntry(
    BuildContext context, {
    bool recordTimeIn = false,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");
    if (driverName.isEmpty || truckNumber.isEmpty) {
      throw Exception("Driver Name and Truck Number are required!");
    }

    // Set the correct loading flag
    if (recordTimeIn) {
      isTimeInLoading = true;
    } else {
      isSaveLoading = true;
    }
    notifyListeners();

    try {
      if (recordTimeIn) {
        timeIn = DateTime.now();
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .add({
            'driverName': driverName,
            'truckNumber': truckNumber,
            'additionalNotes': additionalNotes,
            'licensePlatePhoto': licensePlatePhotoPath,
            'timeIn': timeIn ?? null,
            'timestamp': FieldValue.serverTimestamp(),
            'status': status.isNotEmpty ? status : 'On Site',
            'isActive': isActive ?? 1,
          });

      driverName = '';
      truckNumber = '';
      additionalNotes = '';
      licensePlatePhotoPath = '';
      timeIn = null;
      Navigator.pop(context);
    } catch (e) {
      rethrow;
    } finally {
      // Reset loading flags
      if (recordTimeIn) {
        isTimeInLoading = false;
      } else {
        isSaveLoading = false;
      }
      notifyListeners();
    }
  }

  Stream<List<TruckDriverRecordModel>> truckEntriesStream(String selectStatus) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('status', isEqualTo: selectStatus) // corrected
        .where('isActive', isEqualTo: 1)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          // Group records by truck number and get only the most recent record for each
          Map<String, TruckDriverRecordModel> uniqueTrucks = {};

          for (var doc in snapshot.docs) {
            final record = TruckDriverRecordModel.fromFirestore(doc);

            // If this truck number hasn't been seen yet, add it
            if (!uniqueTrucks.containsKey(record.truckNumber)) {
              uniqueTrucks[record.truckNumber] = record;
            } else {
              // If we already have a record for this truck, compare timestamps
              final existingRecord = uniqueTrucks[record.truckNumber]!;

              // If current record has a more recent timestamp, replace it-
              if (record.timestamp != null &&
                  existingRecord.timestamp != null) {
                if (record.timestamp!.isAfter(existingRecord.timestamp!)) {
                  uniqueTrucks[record.truckNumber] = record;
                }
              } else if (record.timestamp != null &&
                  existingRecord.timestamp == null) {
                // If existing record has no timestamp but current does, use current
                uniqueTrucks[record.truckNumber] = record;
              }
            }
          }

          // Return only the unique truck records (most recent for each truck number)
          return uniqueTrucks.values.toList();
        });
  }

  // Stream for Active On Site trucks (count only)
  Stream<int> activeOnSiteTrucksCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('status', isEqualTo: 'On Site')
        .where('isActive', isEqualTo: 1)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Stream for Active Departed trucks (count only)
  Stream<int> activeDepartedTrucksCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('status', isEqualTo: 'Departed')
        .where('isActive', isEqualTo: 1)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Stream for ALL Active Trucks (count only)
  Stream<int> allActiveTrucksCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('isActive', isEqualTo: 1)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<List<TruckDriverRecordModel>> truckEntriesOfSamePerson(
    String truckNumber,
  ) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Query for active records of the given truck number
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('truck_entries')
        .where('isActive', isEqualTo: 1)
        .where(
          'truckNumber',
          isEqualTo: truckNumber.trim(),
        ) // filter by truckNumber
        .orderBy('truckNumber');

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> recordTimeIn(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('truck_entries')
          .doc(docId)
          .update({
            'timeIn': DateTime.now(),
            'status': 'On Site',
            'isActive': 1,
          });
    } catch (e) {
      debugPrint("Error recording Time In: $e");
      rethrow;
    }
  }

  Future<void> recordTimeOut(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('truck_entries')
          .doc(docId)
          .update({
            'timeOut': DateTime.now(),
            'status': 'Departed',
            'isActive': 0,
          });
    } catch (e) {
      debugPrint("Error recording Time Out: $e");
      rethrow;
    }
  }
}
