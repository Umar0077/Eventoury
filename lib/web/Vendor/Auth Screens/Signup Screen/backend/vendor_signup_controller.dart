import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorSignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final isLoading = false.obs;

  void signup() async {
    if (isLoading.value) return;
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmController.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (password != confirm) {
      Get.snackbar('Error', 'Passwords do not match', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      // Placeholder: simulate account creation delay
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      Get.snackbar('Success', 'Account created', snackPosition: SnackPosition.BOTTOM);
      try {
        Get.back();
      } catch (_) {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup failed', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
