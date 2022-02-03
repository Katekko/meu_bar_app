import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  SnackbarUtil._();

  static void showSuccess(String message) {
    Get.rawSnackbar(
      title: 'Success',
      icon: const Icon(Icons.thumb_up, color: Colors.white),
      message: message,
      backgroundColor: Colors.green.shade600,
    );
  }

  static void showWarning(String message) {
    Get.rawSnackbar(
      title: 'Warning',
      icon: const Icon(Icons.warning, color: Colors.white),
      message: message,
      backgroundColor: Colors.orange.shade900,
    );
  }

  static void showError(String message) {
    Get.rawSnackbar(
      title: 'Error',
      icon: const Icon(Icons.error, color: Colors.white),
      message: message,
      backgroundColor: Colors.redAccent.shade700,
    );
  }
}
