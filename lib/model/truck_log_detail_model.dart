import 'package:cloud_firestore/cloud_firestore.dart';

class TruckLogDetailModel {
  final String? id;
  final String? truckNumber;
  final String? driverName;
  final String? driverRole;
  final String? status;
  final DateTime? timeIn;
  final DateTime? timeOut;
  final DateTime? timestamp;

  TruckLogDetailModel({
    this.id,
    this.truckNumber,
    this.driverName,
    this.driverRole,
    this.status,
    this.timeIn,
    this.timeOut,
    this.timestamp,
  });

  /// Factory for Firestore DocumentSnapshot
  factory TruckLogDetailModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TruckLogDetailModel(
      id: doc.id,
      truckNumber: data['truckNumber'] ?? '',
      driverName: data['driverName'] ?? '',
      driverRole: data['driverRole'] ?? 'Driver',
      status: data['status'] ?? '',
      timeIn: _toDateTime(data['timeIn']),
      timeOut: _toDateTime(data['timeOut']),
      timestamp: _toDateTime(data['timestamp']),
    );
  }

  /// ✅ Factory for plain Map<String, dynamic>
  factory TruckLogDetailModel.fromMap(Map<String, dynamic> data) {
    return TruckLogDetailModel(
      id: data['entryId'] ?? data['id'] ?? '',
      truckNumber: data['truckNumber'] ?? '',
      driverName: data['driverName'] ?? '',
      driverRole: data['driverRole'] ?? 'Driver',
      status: data['status'] ?? '',
      timeIn: _toDateTime(data['timeIn']),
      timeOut: _toDateTime(data['timeOut']),
      timestamp: _toDateTime(data['timestamp']),
    );
  }

  /// Convert model to Firestore map
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

  /// Helper: safely convert Firestore Timestamp or DateTime
  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  // =======================
  // Utility Getters
  // =======================

  String get totalTime {
    if (timeIn == null || timeOut == null) return '--';
    final difference = timeOut!.difference(timeIn!);
    final hours = difference.inMinutes ~/ 60;
    final minutes = difference.inMinutes % 60;
    return '${hours} hrs ${minutes} mins';
  }

  String get formattedDate {
    if (timeIn == null) return '--';
    return '${_getMonthName(timeIn!.month)} ${timeIn!.day}, ${timeIn!.year}';
  }

  String get formattedTimestamp {
    if (timestamp == null) return '--';
    return '${_getMonthName(timestamp!.month)} ${timestamp!.day}';
  }

  // String get formattedTimeIn {
  //   if (timeIn == null) return '--';
  //   return '${timeIn!.hour.toString().padLeft(2, '0')}:${timeIn!.minute.toString().padLeft(2, '0')} ${timeIn!.hour >= 12 ? 'PM' : 'AM'}';
  // }

  // String get formattedTimeIn {
  //   if (timeIn == null) return '--';

  //   int hour = timeIn!.hour;
  //   final minute = timeIn!.minute.toString().padLeft(2, '0');
  //   final suffix = hour >= 12 ? 'PM' : 'AM';

  //   // Convert to 12-hour format
  //   if (hour == 0) {
  //     hour = 12; // midnight case → 12 AM
  //   } else if (hour > 12) {
  //     hour -= 12;
  //   }

  //   return '${hour.toString().padLeft(2, '0')}:$minute $suffix';
  // }

  // String get formattedTimeOut {
  //   if (timeOut == null) return '--';
  //   return '${timeOut!.hour.toString().padLeft(2, '0')}:${timeOut!.minute.toString().padLeft(2, '0')} ${timeOut!.hour >= 12 ? 'PM' : 'AM'}';
  // }

  // String get formattedTime {
  //   if (timestamp == null) return '--';
  //   return '${timestamp!.year} at ${timestamp!.hour.toString().padLeft(2, '0')}:${timestamp!.minute.toString().padLeft(2, '0')} ${timestamp!.hour >= 12 ? 'PM' : 'AM'}';
  // }
  String get formattedTimeIn {
    if (timeIn == null) return '--';
    return _formatTime(timeIn!);
  }

  String get formattedTimeOut {
    if (timeOut == null) return '--';
    return _formatTime(timeOut!);
  }

  String get formattedTime {
    if (timestamp == null) return '--';
    return '${timestamp!.year} at ${_formatTime(timestamp!)}';
  }

  // Reusable private method
  String _formatTime(DateTime time) {
    int hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12; // midnight
    } else if (hour > 12) {
      hour -= 12;
    }

    return '${hour.toString().padLeft(2, '0')}:$minute $suffix';
  }

  String get formattedDatef {
    if (timestamp == null) return '--';
    return '${_getMonthName(timestamp!.month)} ${timestamp!.day}, ${timestamp!.year}';
  }

  String formatTime(DateTime? time) {
    if (time == null) return '--';

    int hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12; // midnight → 12 AM
    } else if (hour > 12) {
      hour -= 12; // 13 → 1 PM, 23 → 11 PM
    }

    return '${hour.toString().padLeft(2, '0')}:$minute $suffix';
  }

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
