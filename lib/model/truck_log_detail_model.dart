import 'package:cloud_firestore/cloud_firestore.dart';

class TruckLogDetailModel {
  final String id;
  final String truckNumber;
  final String driverName;
  final String driverRole;
  final String status;
  final DateTime? timeIn;
  final DateTime? timeOut;
  final DateTime? timestamp;

  TruckLogDetailModel({
    required this.id,
    required this.truckNumber,
    required this.driverName,
    required this.driverRole,
    required this.status,
    this.timeIn,
    this.timeOut,
    this.timestamp,
  });

  // Convert Firestore doc to model
  factory TruckLogDetailModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TruckLogDetailModel(
      id: doc.id,
      truckNumber: data['truckNumber'] ?? '',
      driverName: data['driverName'] ?? '',
      driverRole: data['driverRole'] ?? 'Driver',
      status: data['status'] ?? '',
      timeIn: data['timeIn'] != null
          ? (data['timeIn'] as Timestamp).toDate()
          : null,
      timeOut: data['timeOut'] != null
          ? (data['timeOut'] as Timestamp).toDate()
          : null,
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'truckNumber': truckNumber,
      'driverName': driverName,
      'driverRole': driverRole,
      'status': status,
      'timeIn': timeIn != null ? Timestamp.fromDate(timeIn!) : null,
      'timeOut': timeOut != null ? Timestamp.fromDate(timeOut!) : null,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  // Calculate total time between timeIn and timeOut
  String get totalTime {
    if (timeIn == null || timeOut == null) {
      return '--';
    }

    final difference = timeOut!.difference(timeIn!);
    final hours = difference.inMinutes ~/ 60;
    final minutes = difference.inMinutes % 60;

    return '${hours} hrs ${minutes} mins';
  }

  // Get formatted date string
  String get formattedDate {
    if (timeIn == null) return '--';
    return '${_getMonthName(timeIn!.month)} ${timeIn!.day}, ${timeIn!.year}';
  }

  // Get formatted timestamp string
  String get formattedTimestamp {
    if (timestamp == null) return '--';
    return '${_getMonthName(timestamp!.month)} ${timestamp!.day}';
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

  // Get formatted time strings

  // Get formatted time strings
  String get formattedTime {
    if (timestamp == null) return '--';
    return '${timestamp!.year} at ${timestamp!.hour.toString().padLeft(2, '0')}:${timestamp!.minute.toString().padLeft(2, '0')} ${timestamp!.hour >= 12 ? 'PM' : 'AM'}';
  }

  String get formattedDatef {
    if (timestamp == null) return '--';
    return '${_getMonthName(timestamp!.month)} ${timestamp!.day}, ${timestamp!.year}';
  }

  // Helper method to get month name
  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
