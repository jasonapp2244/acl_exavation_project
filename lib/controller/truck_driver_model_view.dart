import 'package:acl/model/truck_driver_record_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TruckEntryProvider extends ChangeNotifier {
  String driverName = '';
  String truckNumber = '';
  String additionalNotes = '';
  String licensePlatePhotoPath = '';
  DateTime? timeIn;
  bool? isTimeInLoading;
  List<TruckDriverRecordModel> truckEntries = [];
  bool isLoading = false;
  bool isSaveLoading = false;

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

  Future<void> saveTruckEntry({bool recordTimeIn = false}) async {
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
            'status': 'onsite',
          });

      driverName = '';
      truckNumber = '';
      additionalNotes = '';
      licensePlatePhotoPath = '';
      timeIn = null;
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

  Future<void> fetchTruckEntries() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .orderBy('timestamp', descending: true)
          .get();

      truckEntries = snapshot.docs
          .map((doc) => TruckDriverRecordModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching truck entries: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
