import 'package:eventoury/mobile/booking/frontend/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final TextEditingController _name = TextEditingController(text: 'Laiba');
  final TextEditingController _guestNum = TextEditingController(text: '2');
  final TextEditingController _phone = TextEditingController(
    text: '123 456 789',
  );
  final TextEditingController _email = TextEditingController(
    text: 'laibaahmarmalik@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Booking', style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Booking',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),

            Text('Guest name', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            TextField(
              controller: _name,
              decoration: const InputDecoration(hintText: 'Full name'),
            ),
            const SizedBox(height: 14),

            Text('Guest number', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            TextField(
              controller: _guestNum,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Number of guests'),
            ),
            const SizedBox(height: 14),

            Text('Phone', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            Row(
              children: [
                SizedBox(
                  width: 88,
                  child: InputDecorator(
                    decoration: const InputDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('+92'),
                        Icon(Icons.expand_more, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Text('Email', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 20),

            Container(
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
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
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
                        child: const Icon(Icons.image, color: Colors.white70),
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
                            Text(
                              'Bali, Indonesia',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$1200',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: EventouryColors.persimmon,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('/2Person', style: theme.textTheme.labelMedium),
                    ],
                  ),
                ),
                Expanded(
                  child: EventouryElevatedButton(
                    onPressed: () {
                      Get.to(() => PaymentScreen());
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
