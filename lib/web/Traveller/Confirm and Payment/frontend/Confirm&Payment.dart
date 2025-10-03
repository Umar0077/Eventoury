import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/Confirm%20and%20Payment/backend/confirm_payment_controller.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/Traveller/Payment/frontend/payment.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmPaymentController());
    // If a price was passed from the booking screen, set it here
    final args = Get.arguments;
    if (args is Map && args['price'] != null) {
      // ensure it's an int or double
      try {
        controller.totalPrice.value = args['price'] is double ? (args['price'] as double).toInt() : (args['price'] as int);
      } catch (_) {}
    }

    final theme = Theme.of(context);
  // final isDark = theme.brightness == Brightness.dark; // unused after TopBar extraction
    final screenWidth = MediaQuery.of(context).size.width;

    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          TopBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity, child: _buildHeader(theme, screenWidth)),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
                  Center(child: _buildContent(theme, screenWidth, controller)),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // replaced by shared TopBarWidget

  Widget _buildHeader(ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
              boxShadow: [BoxShadow(color: theme.shadowColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Icon(Icons.arrow_back, color: theme.iconTheme.color, size: isDesktop ? 24 : 20),
          ),
        ),
        const SizedBox(width: 20),
        Text('Confirm and payment', style: TextStyle(fontSize: isDesktop ? 32 : isTablet ? 28 : 24, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
      ],
    );
  }

  Widget _buildContent(ThemeData theme, double screenWidth, ConfirmPaymentController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left column
          Expanded(flex: 1, child: _buildLeft(theme, screenWidth, controller)),
          const SizedBox(width: 40),
          // right image
          Expanded(flex: 1, child: _buildRight(theme, screenWidth, controller)),
        ],
      );
    }

    return Column(children: [_buildLeft(theme, screenWidth, controller), SizedBox(height: isTablet ? 40 : 30), _buildRight(theme, screenWidth, controller)]);
  }

  Widget _buildLeft(ThemeData theme, double screenWidth, ConfirmPaymentController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final imageHeight = isTablet ? 160.0 : 180.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Choice of Destination', style: TextStyle(fontSize: isDesktop ? 18 : 16, fontWeight: FontWeight.w600, color: theme.textTheme.titleLarge?.color)),
              GestureDetector(onTap: () {}, child: Text('Change', style: TextStyle(fontSize: isDesktop ? 16 : 14, fontWeight: FontWeight.w500, color: const Color(0xFFFF6B35)))),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: theme.dividerColor.withOpacity(0.1))),
            child: Row(children: [Icon(Icons.calendar_today, size: 16, color: theme.iconTheme.color), const SizedBox(width: 8), Text('11 - 15 April 2025', style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color)), const SizedBox(width: 16), Icon(Icons.person, size: 16, color: theme.iconTheme.color), const SizedBox(width: 8), Text('2', style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color))]),
          ),

          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: theme.shadowColor.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4))]),
            child: Column(
              children: [
                Container(height: imageHeight, decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), image: DecorationImage(image: AssetImage('assets/home_screen/events.jpg'), fit: BoxFit.cover))),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(width: 40, height: 40, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFFFF6B35).withOpacity(0.1)), child: const Icon(Icons.beach_access, color: Color(0xFFFF6B35), size: 20)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Beach', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)), Text('Bali, Indonesia', style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color))])),
                      ]),

                      const SizedBox(height: 16),

                      // Total price row: label left, prominent price on the right
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total price (incl VAT)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$${controller.totalPrice.value}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFFFF6B35))),
                                  const SizedBox(height: 2),
                                  Text('/2Person', style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                                ],
                              ),
                            ],
                          )),

                      const SizedBox(height: 16),

                      // Payment options
                      Obx(() => _paymentOptionRow(theme, controller, id: 'mastercard', label: 'Credit card/debit', asset: 'assets/payment/master-card.png', selected: controller.selectedPaymentMethod.value == 'mastercard')),
                      const SizedBox(height: 12),
                      Obx(() => _paymentOptionRow(theme, controller, id: 'visa', label: 'Credit card/debit', asset: 'assets/payment/visa.png', selected: controller.selectedPaymentMethod.value == 'visa')),

                      const SizedBox(height: 20),

                      // Full width process button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => EventouryElevatedButton(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              onPressed: controller.isProcessing.value
                                  ? null
                                  : () {
                                      // navigate directly to PaymentScreen, pass price and selected method
                                      Get.to(() => const PaymentScreen(), arguments: {'price': controller.totalPrice.value, 'method': controller.selectedPaymentMethod.value});
                                    },
                              child: controller.isProcessing.value
                                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                                  : const Text('Process Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOptionRow(ThemeData theme, ConfirmPaymentController controller, {required String id, required String label, required String asset, required bool selected}) {
    return GestureDetector(
      onTap: () => controller.selectPayment(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? const Color(0xFFFF6B35) : theme.dividerColor.withOpacity(0.12), width: selected ? 2 : 1)),
        child: Row(children: [Image.asset(asset, height: 32), const SizedBox(width: 12), Expanded(child: Text(label, style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color))), Radio<String>(value: id, groupValue: controller.selectedPaymentMethod.value, onChanged: (v) => controller.selectPayment(v ?? id))]),
      ),
    );
  }

  Widget _buildRight(ThemeData theme, double screenWidth, ConfirmPaymentController controller) {
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            height: isTablet ? 360 : 420,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: const DecorationImage(image: AssetImage('assets/home_screen/events.jpg'), fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  // nav helper removed; TopBarWidget handles navigation
}
