import 'package:acl/model/truck_driver_record_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditTruckEntryController extends ChangeNotifier {
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

  // Fetch truck record by ID
  Future<void> fetchTruckRecord(String recordId) async {
    _isLoading = true;
    _error = null;
    _recordId = recordId;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = "User not authenticated";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .doc(recordId)
          .get();

      if (!doc.exists) {
        _error = "Record not found";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final data = doc.data()!;
      _driverName = data['driverName'] ?? '';
      _truckNumber = data['truckNumber'] ?? '';
      _additionalNotes = data['additionalNotes'] ?? '';
      _licensePlatePhotoPath = data['licensePlatePhoto'] ?? '';
      _status = data['status'] ?? '';
      _timeIn = data['timeIn'] != null
          ? (data['timeIn'] as Timestamp).toDate()
          : null;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = "Error fetching record: $e";
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update truck record
  Future<void> updateTruckRecord() async {
    if (_recordId == null) {
      _error = "No record to update";
      notifyListeners();
      return;
    }

    if (_driverName.isEmpty || _truckNumber.isEmpty) {
      _error = "Driver Name and Truck Number are required!";
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

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('truck_entries')
          .doc(_recordId)
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
