import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  // Form controllers
  final guestNameController = TextEditingController();
  final guestNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  
  // Form keys
  final formKey = GlobalKey<FormState>();
  
  // Reactive properties
  final isLoading = false.obs;
  final selectedCountryCode = '+62'.obs;
  final selectedDestination = 'Beach'.obs;
  final selectedLocation = 'Bali, Indonesia'.obs;
  final bookingPrice = 1200.obs;
  
  // Country codes list
  final List<String> countryCodes = [
    '+1', '+44', '+33', '+49', '+81', '+86', '+91', '+62', '+60', '+65'
  ];
  
  @override
  void onInit() {
    super.onInit();
    // Initialize default values
    guestNumberController.text = '2';
  }
  
  @override
  void onClose() {
    // Dispose controllers
    guestNameController.dispose();
    guestNumberController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
  
  // Validation methods
  String? validateGuestName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Guest name is required';
    }
    if (value.trim().length < 2) {
      return 'Guest name must be at least 2 characters';
    }
    return null;
  }
  
  String? validateGuestNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Number of guests is required';
    }
    final number = int.tryParse(value);
    if (number == null || number < 1) {
      return 'Please enter a valid number of guests';
    }
    if (number > 20) {
      return 'Maximum 20 guests allowed';
    }
    return null;
  }
  
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (value.trim().length < 8) {
      return 'Please enter a valid phone number';
    }
    // Remove spaces and check if it contains only digits
    final cleanNumber = value.replaceAll(' ', '').replaceAll('-', '');
    if (!RegExp(r'^\d+$').hasMatch(cleanNumber)) {
      return 'Phone number should contain only digits';
    }
    return null;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  
  // Actions
  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }
  
  void changeDestination() {
    // This would typically open a destination picker
    // For now, we'll just show a placeholder
    Get.snackbar(
      'Change Destination',
      'Destination picker will be implemented',
      backgroundColor: const Color(0xFFFF6B35),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }
  
  void goBack() {
    Get.back();
  }
  
  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Create booking data
      final bookingData = {
        'guestName': guestNameController.text.trim(),
        'guestNumber': int.parse(guestNumberController.text.trim()),
        'phone': '${selectedCountryCode.value} ${phoneController.text.trim()}',
        'email': emailController.text.trim(),
        'destination': selectedDestination.value,
        'location': selectedLocation.value,
        'price': bookingPrice.value,
        'bookingDate': DateTime.now().toIso8601String(),
      };
      
      print('Booking Data: $bookingData');
      
      // Show success message
      Get.snackbar(
        'Booking Successful!',
        'Your booking has been confirmed. Check your email for details.',
        backgroundColor: const Color(0xFFFF6B35),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      
      // Navigate back or to confirmation screen
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
      
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Booking Failed',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Reset form
  void resetForm() {
    guestNameController.clear();
    guestNumberController.text = '2';
    phoneController.clear();
    emailController.clear();
    selectedCountryCode.value = '+62';
    formKey.currentState?.reset();
  }
  
  // Helper methods
  String getFormattedPrice() {
    return '\$${bookingPrice.value}';
  }
  
  bool get isFormValid {
    return guestNameController.text.trim().isNotEmpty &&
           guestNumberController.text.trim().isNotEmpty &&
           phoneController.text.trim().isNotEmpty &&
           emailController.text.trim().isNotEmpty;
  }
}