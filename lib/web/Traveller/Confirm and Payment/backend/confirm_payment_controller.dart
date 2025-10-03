import 'package:get/get.dart';

class ConfirmPaymentController extends GetxController {
  final selectedPaymentMethod = 'mastercard'.obs; // 'mastercard' or 'visa'
  final isProcessing = false.obs;
  final totalPrice = 1200.obs; // default

  void selectPayment(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> processPayment() async {
    if (isProcessing.value) return;
    try {
      isProcessing.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar('Payment processed', 'Your payment was successful');
    } catch (e) {
      Get.snackbar('Payment failed', 'Please try again');
    } finally {
      isProcessing.value = false;
    }
  }
}
