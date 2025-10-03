import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/theme/loader.dart';
import '../../profile/backend/profile_controller.dart';

class LoginController extends GetxController {
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    isSubmitting.value = true;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      storage.write('isLoggedIn', true);
      isSubmitting.value = false;
      return credential;
    } catch (e) {
      isSubmitting.value = false;
      Get.snackbar('Sign Up Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GetStorage storage = GetStorage();

  final RxBool isSubmitting = false.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter your email';
    if (!value.contains('@')) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter your password';
    if (value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSubmitting.value = true;
    // Show loader
    FullScreenLoader.openLoadingDialogue('Logging in...', 'assets/loader/loading.json');
    try {
      // sign in user
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      storage.write('isLoggedIn', true);
      isSubmitting.value = false;
      // Update profile controller user state
      try {
        final profileController = Get.find<ProfileController>();
        profileController.updateUser();
      } catch (_) {}
      // Stop loader
      FullScreenLoader.stopLoading();
      final dynamic next = Get.arguments == null ? null : Get.arguments['next'];
      if (next is Widget) {
        Get.off(() => next);
      } else {
        Get.back();
      }
    } catch (e) {
      isSubmitting.value = false;
      FullScreenLoader.stopLoading();
      Get.snackbar('Login Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
