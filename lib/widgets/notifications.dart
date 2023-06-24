import 'package:flutter/material.dart';

class Notifications {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message,BuildContext context,) {
    final snackbar = SnackBar(
      backgroundColor: const Color(0xFFd6f2e5),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        content: Text(message,
            style: const TextStyle(color: Colors.grey, fontSize: 20)));
     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
