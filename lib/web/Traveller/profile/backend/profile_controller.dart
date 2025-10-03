import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Huzaifa Noor');
  final emailController = TextEditingController(text: 'huzaifa.ux@gmail.com');
  final phoneController = TextEditingController(text: '+92 1234567890');
  final locationController = TextEditingController(text: 'Lahore, Pakistan');

  final isSaving = false.obs;
  final isEditing = false.obs;

  // keep originals to allow cancel
  late String _originalName;
  late String _originalEmail;
  late String _originalPhone;
  late String _originalLocation;

  void startEdit() {
    // store originals
    _originalName = nameController.text;
    _originalEmail = emailController.text;
    _originalPhone = phoneController.text;
    _originalLocation = locationController.text;
    isEditing.value = true;
  }

  void cancelEdit() {
    // restore
    nameController.text = _originalName;
    emailController.text = _originalEmail;
    phoneController.text = _originalPhone;
    locationController.text = _originalLocation;
    isEditing.value = false;
  }

  void saveProfile() async {
    if (isSaving.value) return;
    isSaving.value = true;
    // Simulate a save
    await Future.delayed(const Duration(seconds: 1));
    isSaving.value = false;
    // update originals to current values and exit edit mode
    _originalName = nameController.text;
    _originalEmail = emailController.text;
    _originalPhone = phoneController.text;
    _originalLocation = locationController.text;
    isEditing.value = false;
    // Optionally show a snackbar
    Get.snackbar('Saved', 'Profile information saved successfully', snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
