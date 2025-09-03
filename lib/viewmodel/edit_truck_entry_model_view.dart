import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditTruckEntryModelView extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _driverName = '';
  String _truckNumber = '';
  String _additionalNotes = '';
  String _licensePlatePhotoPath = '';
  String _status = '';
  DateTime? _timeIn;
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;
  String? _recordId;

  // Getters
  String get driverName => _driverName;
  String get truckNumber => _truckNumber;
  String get additionalNotes => _additionalNotes;
  String get licensePlatePhotoPath => _licensePlatePhotoPath;
  String get status => _status;
  DateTime? get timeIn => _timeIn;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Setters
  void setDriverName(String name) {
    _driverName = name;
    notifyListeners();
  }

  void setTruckNumber(String number) {
    _truckNumber = number;
    notifyListeners();
  }

  void setAdditionalNotes(String notes) {
    _additionalNotes = notes;
    notifyListeners();
  }

  void setLicensePlatePhoto(String path) {
    _licensePlatePhotoPath = path;
    notifyListeners();
  }

  void setStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }


  Future<void> fetchTruckRecordByTruckNumber(String truckNumber) async {
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

      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .where(
            'truckNumber',
            isEqualTo: truckNumber,
          ) // ✅ filter by truck number
          .limit(1) // fetch only one
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        _recordId = querySnapshot.docs.first.id;
        _driverName = data['driverName'] ?? '';
        _truckNumber = data['truckNumber'] ?? '';
        _additionalNotes = data['additionalNotes'] ?? '';
        _licensePlatePhotoPath = data['licensePlatePhoto'] ?? '';
        _status = data['status'] ?? '';
        _timeIn = data['timeIn'] != null
            ? (data['timeIn'] as Timestamp).toDate()
            : null;
      } else {
        _error = "No truck found with number $truckNumber";
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = "Error fetching record: $e";
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTruckRecordByTruckNumber(String truckNumber) async {
    if (truckNumber.isEmpty) {
      _error = "Truck number required to update";
      notifyListeners();
      return;
    }

    if (_driverName.isEmpty) {
      _error = "Driver Name is required!";
      notifyListeners();
      return;
    }

    _isSaving = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = "User not authenticated";
        _isSaving = false;
        notifyListeners();
        return;
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .where(
            'truckNumber',
            isEqualTo: truckNumber,
          ) // ✅ find by truck number
          .limit(1) // get only first match
          .get();

      if (querySnapshot.docs.isEmpty) {
        _error = "No record found for truck number $truckNumber";
        _isSaving = false;
        notifyListeners();
        return;
      }

      final docId = querySnapshot.docs.first.id;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .doc(docId)
          .update({
            'driverName': _driverName,
            'truckNumber': _truckNumber,
            'additionalNotes': _additionalNotes,
            'licensePlatePhoto': _licensePlatePhotoPath,
            'status': _status.isNotEmpty ? _status : 'On Site',
            'updatedAt': FieldValue.serverTimestamp(),
          });

      _successMessage = "Truck entry updated successfully!";
      _isSaving = false;
      notifyListeners();
    } catch (e) {
      _error = "Error updating record: $e";
      _isSaving = false;
      notifyListeners();
    }
  }

  // Clear messages
  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  // Clear all data
  void clearData() {
    _driverName = '';
    _truckNumber = '';
    _additionalNotes = '';
    _licensePlatePhotoPath = '';
    _status = '';
    _timeIn = null;
    _isLoading = false;
    _isSaving = false;
    _error = null;
    _successMessage = null;
    _recordId = null;
    notifyListeners();
  }
}
