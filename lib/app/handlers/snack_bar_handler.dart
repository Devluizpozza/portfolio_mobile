import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

abstract class SnackBarHandler {
  static void snackBarError(BuildContext context, String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
      borderRadius: 12,
      duration: Duration(seconds: 2),
    );
  }
}
