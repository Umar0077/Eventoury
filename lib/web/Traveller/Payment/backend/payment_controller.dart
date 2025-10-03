import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentController extends GetxController {
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expiryMonth = ''.obs;
  final expiryYear = ''.obs;
  final saveInfo = false.obs;

  final totalPrice = 1200.obs;
  final isProcessing = false.obs;

  void initFromArgs(dynamic args) {
    if (args is Map && args['price'] != null) {
      try {
        totalPrice.value = args['price'] is double ? (args['price'] as double).toInt() : (args['price'] as int);
      } catch (_) {}
    }
  }

  Future<void> submitPayment() async {
    isProcessing.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isProcessing.value = false;
    // Show success animation (Lottie) and then navigate to home
    try {
      // Show a dialog with the success animation. BarrierDismissible false so user sees it.
      Get.dialog(
        Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Try to use a provided success animation asset; fallback to another if needed
                Lottie.asset('assets/payment/120978-payment-successful.json', width: 220, height: 220, fit: BoxFit.contain),
                const SizedBox(height: 8),
                Text('Payment Successful', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Get.theme.textTheme.titleLarge?.color)),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Keep the dialog visible for the duration of the animation (approx 2.2s) then close and navigate home
      await Future.delayed(const Duration(milliseconds: 2200));
      if (Get.isDialogOpen ?? false) Get.back();
      // Navigate to web home screen, replacing history
      Get.offAllNamed('/WebHomeScreen');
    } catch (e) {
      // fallback behavior: show a small snackbar when animation or navigation fails
      Get.snackbar('Payment', 'Payment processed (demo)', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
