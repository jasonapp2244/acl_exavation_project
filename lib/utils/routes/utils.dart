import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

  String getInitials(String name) {
    List<String> names = name.trim().split(" ");
    String initials = "";
    for (var part in names) {
      if (part.isNotEmpty) initials += part[0].toUpperCase();
    }
    return initials;
  }
}

String formatTime(var timeIn) {
  try {
    DateTime dateTime = DateTime.parse(timeIn);
    return DateFormat.jm().format(dateTime); // outputs like 08:30 AM
  } catch (e) {
    return "--:--"; // fallback if parsing fails
  }
}

// Helper method to get current date in the required format

snakBar(String massage, BuildContext context) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(massage)));
}
