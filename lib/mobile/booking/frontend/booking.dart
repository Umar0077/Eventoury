import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/mobile/authentication/frontend/login_required_screen.dart';
import 'package:eventoury/mobile/booking/frontend/booking_details.dart';
import 'package:intl/intl.dart';
import '../backend/booking_controller.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final BookingController controller = Get.put(BookingController());
  final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Select Dates",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your booking',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              /// Calendar Header
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: controller.goToPreviousMonth,
                    ),
                    Text(
                      DateFormat.yMMMM().format(controller.currentMonth.value),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 18),
                      onPressed: controller.goToNextMonth,
                    ),
                  ],
                );
              }),
              const SizedBox(height: 8),

              /// Weekday labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: weekDays
                    .map(
                      (d) => SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(
                            d,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),

              /// Calendar days
              Flexible(
                fit: FlexFit.loose,
                child: Obx(() {
                  final days = controller.getDaysInMonth(
                    controller.currentMonth.value,
                  );
                  final startOffset = controller.getStartingWeekday(
                    controller.currentMonth.value,
                  );

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: days.length + startOffset,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                    itemBuilder: (context, index) {
                      if (index < startOffset) {
                        return const SizedBox(); // Empty space for alignment
                      }

                      final day = days[index - startOffset];

                      return Obx(() {
                        final inRange = controller.isInRange(day);
                        final isPast = day.isBefore(controller.today);

                        return GestureDetector(
                          onTap: () =>
                              !isPast ? controller.selectDate(day) : null,
                          child: Container(
                            decoration: BoxDecoration(
                              color: inRange
                                  ? EventouryColors.tangerine
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: inRange
                                    ? EventouryColors.tangerine
                                    : Colors.grey[300]!,
                                width: inRange ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(
                                  color: isPast
                                      ? isDark
                                            ? Colors.grey.shade700
                                            : Colors.grey
                                      : (inRange
                                            ? Colors.white
                                            : isDark
                                            ? Colors.white
                                            : Colors.black),
                                  fontWeight: inRange
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
              ),

              const SizedBox(height: 12), // Reduced gap
              // Counters
              _buildCounterRow('Adult', controller.adults),
              _buildCounterRow('Children', controller.children),
              _buildCounterRow('Kids (Baby)', controller.kids),

              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.resetBooking,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: EventouryColors.electric_orange,
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: EventouryElevatedButton(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          // ✅ User is logged in → go to booking screen
                          Get.to(() => BookingDetailsScreen());
                        } else {
                          Get.to(() => LoginRequiredScreen(), arguments: {'next': BookingDetailsScreen()});
                        }
                      },
                      child: Text("Book Now"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterRow(String label, RxInt value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: () {
              if (value.value > 0) value.value--;
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Obx(
            () => Text(
              value.value.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: () => value.value++,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}
