import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static tosatMassage(String massage) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      webBgColor: Colors.red,
      msg: massage,
    );
  }

  var _storage = FlutterSecureStorage();

  // Save UID after login
  Future<void> saveUser(User user) async {
    await _storage.write(key: 'uid', value: user.uid);
    await _storage.write(key: 'email', value: user.email ?? '');
  }

  // Get UID
  Future<String?> getUid() async {
    return await _storage.read(key: 'uid');
  }

  // Clear on logout
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  static void fieldFoucsChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFoucs,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFoucs);
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final months = [
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
    final day = now.day.toString().padLeft(2, '0');
    final month = months[now.month - 1];
    final year = now.year.toString();
    return '$day $month $year';
  }

  static void flushBarErrorMassage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(15),

        message: message,
        borderRadius: BorderRadius.circular(20),
        backgroundColor: Colors.red,
        title: "error",
        messageColor: Colors.black,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(Icons.error, size: 28, color: Colors.white),
        duration: Duration(seconds: 3),
      )..show(context),
    );
  }

  // Helpe

  String getInitials(String name) {
    List<String> names = name.trim().split(" ");
    String initials = "";
    for (var part in names) {
      if (part.isNotEmpty) initials += part[0].toUpperCase();
    }
    return initials;
  }
}

String formatTime(dynamic timeIn) {
  try {
    DateTime dateTime;

    if (timeIn is String) {
      dateTime = DateTime.parse(timeIn); // parse string
    } else if (timeIn is DateTime) {
      dateTime = timeIn; // already DateTime
    } else {
      return "--:--"; // unsupported type
    }

    return DateFormat.jm().format(dateTime); // e.g. 10:51 PM
  } catch (e) {
    return "--:--";
  }
}

snakBar(String massage, BuildContext context) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(massage)));
}
  String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> parts = fullName.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
    }
  }