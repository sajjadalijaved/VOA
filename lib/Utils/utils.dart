import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar_route.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void errorMessageFlush(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          duration: const Duration(seconds: 2),
          message: message,
          titleColor: Colors.white,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(10),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          positionOffset: 20,
        )..show(context));
  }

  static void successMessageFlush(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          duration: const Duration(seconds: 2),
          message: message,
          titleColor: Colors.white,
          backgroundColor: Colors.green,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(10),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.done,
            color: Colors.white,
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          positionOffset: 20,
        )..show(context));
  }

  static snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
