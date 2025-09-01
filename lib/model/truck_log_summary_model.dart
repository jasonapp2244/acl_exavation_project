import 'package:cloud_firestore/cloud_firestore.dart';

class TruckLogSummaryModel {
  final String id;
  final String truckNumber;
  final String driverName;
  final String driverRole;
  final DateTime? timeIn;
  final DateTime? timeOut;
  final String status;
  final DateTime? timestamp;

  TruckLogSummaryModel({
    required this.id,
    required this.truckNumber,
    required this.driverName,
    required this.driverRole,
    this.timeIn,
    this.timeOut,
    required this.status,
    this.timestamp,
  });

  // Convert Firestore doc to model
  factory TruckLogSummaryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TruckLogSummaryModel(
      id: doc.id,
      truckNumber: data['truckNumber'] ?? '',
      driverName: data['driverName'] ?? '',
      driverRole: data['driverRole'] ?? 'Driver',
      timeIn: data['timeIn'] != null
          ? (data['timeIn'] as Timestamp).toDate()
          : null,
      timeOut: data['timeOut'] != null
          ? (data['timeOut'] as Timestamp).toDate()
          : null,
      status: data['status'] ?? '',
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  // Get formatted time strings
  String get formattedTimeIn {
    if (timeIn == null) return '--';
    return '${timeIn!.hour.toString().padLeft(2, '0')}:${timeIn!.minute.toString().padLeft(2, '0')} ${timeIn!.hour >= 12 ? 'PM' : 'AM'}';
  }

  String get formattedTimeOut {
    if (timeOut == null) return '--';
    return '${timeOut!.hour.toString().padLeft(2, '0')}:${timeOut!.minute.toString().padLeft(2, '0')} ${timeOut!.hour >= 12 ? 'PM' : 'AM'}';
  }
}
