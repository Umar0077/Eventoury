import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  void login() async {
    if (isLoading.value) return;
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      Get.snackbar('Success', 'Signed in successfully', snackPosition: SnackPosition.BOTTOM);
      // navigate to home (replace history) so the user arrives at the web home screen
      try {
        Get.offAllNamed('/WebHomeScreen');
      } catch (_) {
        // fallback: try to pop if named navigation fails
        try {
          final ctx = Get.context;
          if (ctx != null && Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
        } catch (_) {}
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Sign-in failed', e.message ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Sign-in failed', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signInWithGoogle() {
    Get.snackbar('Google', 'Google sign-in tapped', snackPosition: SnackPosition.BOTTOM);
  }

  void signInWithApple() {
    Get.snackbar('Apple', 'Apple sign-in tapped', snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
