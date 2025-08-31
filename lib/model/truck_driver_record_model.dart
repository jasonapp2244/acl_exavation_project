import 'package:cloud_firestore/cloud_firestore.dart';

class TruckDriverRecordModel {
  final String id;
  final String truckNumber;
  final String status;
  final DateTime? timeIn;
  final String driverName;
  final String driverRole;
  final String additionalNotes;
  final String licensePlatePhotoPath;

  TruckDriverRecordModel({
    required this.id,
    required this.truckNumber,
    required this.status,
    this.timeIn,
    required this.driverName,
    required this.driverRole,
    this.additionalNotes = '',
    this.licensePlatePhotoPath = '',
  });

  // Convert Firestore doc to model
  factory TruckDriverRecordModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TruckDriverRecordModel(
      id: doc.id,
      truckNumber: data['truckNumber'] ?? '',
      status: data['status'] ?? '',
      timeIn: data['timeIn'] != null
          ? (data['timeIn'] as Timestamp).toDate()
          : null,
      driverName: data['driverName'] ?? '',
      driverRole: data['driverRole'] ?? 'Driver',
      additionalNotes: data['additionalNotes'] ?? '',
      licensePlatePhotoPath: data['licensePlatePhoto'] ?? '',
    );
  }

  // Convert model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'truckNumber': truckNumber,
      'status': status,
      'timeIn': timeIn != null ? Timestamp.fromDate(timeIn!) : null,
      'driverName': driverName,
      'driverRole': driverRole,
      'additionalNotes': additionalNotes,
      'licensePlatePhoto': licensePlatePhotoPath,
    };
  }
}
