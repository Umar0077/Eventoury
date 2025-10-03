import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    try {
      isLoading.value = true;
      // Placeholder implementation: simulate network/login delay
      await Future.delayed(const Duration(seconds: 1));
      // Here you should integrate your auth backend. For now, we treat any non-empty credentials as successful.
      Get.offAllNamed('/VendorHome');
    } catch (e) {
      Get.snackbar('Login failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Stubs for social sign-in
  void signInWithGoogle() {
    Get.snackbar('Info', 'Google sign-in not implemented');
  }

  void signInWithApple() {
    Get.snackbar('Info', 'Apple sign-in not implemented');
  }
}
