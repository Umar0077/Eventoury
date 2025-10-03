import 'package:eventoury/mobile/booking/frontend/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'add_new_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selected = 0; // 0: Mastercard, 1: Visa

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // brightness not used here; left intentionally commented for future use
    // final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Confirm and payment', style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DestinationCard(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price (incl VAT)',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '\$1200',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('/2Person', style: theme.textTheme.labelMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _MethodTile(
              label: 'Credit card/debit',
              brandAsset: null,
              selected: _selected == 0,
              onTap: () => setState(() => _selected = 0),
            ),
            const SizedBox(height: 12),
            _MethodTile(
              label: 'Credit card/debit',
              brandAsset: null,
              selected: _selected == 1,
              onTap: () => setState(() => _selected = 1),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.to(() => const AddNewCardScreen()),
              child: Center(child: Text("Add new Card", style: Theme.of(context).textTheme.labelLarge,)),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: EventouryElevatedButton(
          onPressed: () {
            Get.to(() => PaymentSuccess());
          },
          child: const Text('Process Payment'),
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choice of Destination',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Change',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: EventouryColors.tangerine,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 64,
                width: 88,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/home_screen/tour_packages.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beach',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text('Bali, Indonesia', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String label;
  final String? brandAsset; // you can wire assets later
  final bool selected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.label,
    required this.brandAsset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? EventouryColors.tangerine
                : (theme.dividerColor.withOpacity(0.4)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/payment/master-card.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: theme.textTheme.titleSmall)),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
            ),
          ],
        ),
      ),
    );
  }
}
