import 'package:eventoury/web/Traveller/Payment/backend/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    // initialize from args
    controller.initFromArgs(Get.arguments);

    final theme = Theme.of(context);
  // final isDark = theme.brightness == Brightness.dark; // unused after topbar extraction
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // top nav (shared)
          TopBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color, size: isDesktop ? 28 : isTablet ? 24 : 20),
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(width: 12),
                          Text('Payment', style: TextStyle(fontSize: isDesktop ? 28 : isTablet ? 26 : 24, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // main content: left form, right image
                      LayoutBuilder(builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 800;
                        return isWide
                            ? Row(children: [Expanded(flex: 1, child: _buildForm(theme, controller)), const SizedBox(width: 24), Expanded(flex: 1, child: _buildImage(theme))])
                            : Column(children: [_buildForm(theme, controller), const SizedBox(height: 20), _buildImage(theme)]);
                      }),

                      const SizedBox(height: 40),
                      const BottomBarWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Top navigation replaced by shared TopBarWidget

  Widget _buildForm(ThemeData theme, PaymentController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Card preview mock
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: theme.shadowColor.withOpacity(0.06), blurRadius: 12)],
          border: Border.all(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Huzaifa', style: TextStyle(color: theme.textTheme.titleLarge?.color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Account Balance', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
          const SizedBox(height: 12),
          Text('\$${controller.totalPrice.value}.80', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
          const SizedBox(height: 8),
          Text('Master Card', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
        ]),
      ),

      // Card number
      Text('Card Number', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
  TextField(controller: controller.cardNumberController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), hintText: '7445 2345 1234 0937', filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white)),
      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expiration Month', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: controller.expiryMonth.value.isEmpty ? null : controller.expiryMonth.value,
                  items: List.generate(12, (i) => DropdownMenuItem(value: (i + 1).toString(), child: Text('${i + 1}'))),
                  onChanged: (v) => controller.expiryMonth.value = v ?? '',
                  dropdownColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expiration Year', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: controller.expiryYear.value.isEmpty ? null : controller.expiryYear.value,
                  items: List.generate(10, (i) => DropdownMenuItem(value: (DateTime.now().year + i).toString(), child: Text('${DateTime.now().year + i}'))),
                  onChanged: (v) => controller.expiryYear.value = v ?? '',
                  dropdownColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),
      Text('CVV', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
  TextField(controller: controller.cvvController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white), keyboardType: TextInputType.number),

      const SizedBox(height: 12),
      Row(children: [Checkbox(value: controller.saveInfo.value, onChanged: (v) => controller.saveInfo.value = v ?? false), Text('Save this information for next time', style: TextStyle(color: theme.textTheme.bodyMedium?.color))]),

      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('\$${controller.totalPrice.value}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFFFF6B35))), const SizedBox(height: 4), Text('/Person', style: TextStyle(color: theme.textTheme.bodySmall?.color))]),
        Obx(() => EventouryElevatedButton(onPressed: controller.isProcessing.value ? null : controller.submitPayment, child: controller.isProcessing.value ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : const Text('Confirm Payment'))),
      ])
    ]);
  }

  Widget _buildImage(ThemeData theme) {
    return Container(
      height: 320,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: const DecorationImage(image: AssetImage('assets/home_screen/events.jpg'), fit: BoxFit.cover)),
    );
  }

  
}
