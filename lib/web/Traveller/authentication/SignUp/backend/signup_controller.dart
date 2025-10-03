import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
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
      final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      // Optionally set display name
      await userCred.user?.updateDisplayName(name);
      isLoading.value = false;
      Get.snackbar('Success', 'Account created', snackPosition: SnackPosition.BOTTOM);
      // navigate back to login
      try {
        final ctx = Get.context;
        if (ctx != null && Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
      } catch (_) {}
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup failed', e.message ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
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
