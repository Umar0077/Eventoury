import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/AvailableDate/backend/available_date_controller.dart';
import 'package:eventoury/web/top%20and%20Bottom%20bar/top%20bar%20web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';

class AvailableDateScreen extends StatelessWidget {
  const AvailableDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailableDateController());
  final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    // Responsive padding
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Top Navigation Bar (shared)
          TopBarWidget(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button and Title
                  SizedBox(
                    width: double.infinity,
                    child: _buildHeader(theme, screenWidth),
                  ),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),

                  // Booking Section
                  Center(
                    child: _buildBookingSection(theme, screenWidth, controller),
                  ),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),

                  // Footer
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: theme.iconTheme.color,
            size: isDesktop ? 28 : isTablet ? 26 : 24,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Available date',
          style: TextStyle(
            fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSection(ThemeData theme, double screenWidth, AvailableDateController controller) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    
    return Container(
      // make the panel wider on desktop to allow a wide calendar
      constraints: BoxConstraints(maxWidth: isDesktop ? 1100 : isTablet ? 900 : double.infinity),
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 20),
      padding: EdgeInsets.all(isDesktop ? 40 : isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your booking',
            style: TextStyle(
              fontSize: isDesktop ? 28 : isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),

          // make calendar full width inside panel
          SizedBox(width: double.infinity, child: _buildCalendar(theme, controller)),
          SizedBox(height: isDesktop ? 50 : isTablet ? 40 : 30),

          // guest selection full width with separators
          SizedBox(width: double.infinity, child: _buildGuestSelection(theme, controller)),
          SizedBox(height: isDesktop ? 50 : isTablet ? 40 : 30),

          // action buttons full width
          SizedBox(width: double.infinity, child: _buildActionButtons(theme, controller)),
        ],
      ),
    );
  }

  Widget _buildCalendar(ThemeData theme, AvailableDateController controller) {
    return Obx(() => Column(
      children: [
        // Month navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: controller.previousMonth,
              icon: Icon(
                Icons.chevron_left,
                color: theme.iconTheme.color,
              ),
            ),
            Text(
              '${controller.getMonthName(controller.currentMonth.value.month)} ${controller.currentMonth.value.year}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            IconButton(
              onPressed: controller.nextMonth,
              icon: Icon(
                Icons.chevron_right,
                color: theme.iconTheme.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Week days
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map((day) => Expanded(
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        // Calendar grid
        _buildCalendarGrid(theme, controller),
      ],
    ));
  }

  Widget _buildCalendarGrid(ThemeData theme, AvailableDateController controller) {
    return Obx(() {
      final screenWidth = MediaQuery.of(Get.context!).size.width;
      final isDesktop = screenWidth > 1200;
      final firstDayWeekday = controller.getFirstDayWeekday();
      final lastDayOfMonth = controller.getLastDayOfMonth();
      
  List<Widget> days = [];
      
      // Add empty spaces for days before the first day of the month
      for (int i = 0; i < firstDayWeekday; i++) {
        days.add(const SizedBox());
      }
      
      // Add days of the month
      for (int day = 1; day <= lastDayOfMonth; day++) {
        final isHighlighted = controller.isDateHighlighted(day);
        final isSelected = controller.isDateSelected(day);
        
        days.add(
          GestureDetector(
            onTap: () => controller.selectDate(day),
            child: Container(
                  height: isDesktop ? 80 : 40,
                  margin: EdgeInsets.all(isDesktop ? 12 : 2),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? const Color(0xFFFF6B35)
                      : isHighlighted 
                        ? const Color(0xFFFF6B35).withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected 
                          ? Colors.white
                          : isHighlighted
                            ? const Color(0xFFFF6B35)
                            : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                ),
          ),
        );
      }
      
      return GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: isDesktop ? 1.6 : 1.0,
        children: days,
      );
    });
  }

  Widget _buildGuestSelection(ThemeData theme, AvailableDateController controller) {
    return Obx(() => Column(
      children: [
        _buildGuestRow('Adult', controller.adults.value, theme, 
          controller.incrementAdults, controller.decrementAdults),
        const SizedBox(height: 16),
        _buildGuestRow('Children', controller.children.value, theme, 
          controller.incrementChildren, controller.decrementChildren),
        const SizedBox(height: 16),
        _buildGuestRow('Kids (Baby)', controller.babies.value, theme, 
          controller.incrementBabies, controller.decrementBabies),
      ],
    ));
  }

  Widget _buildGuestRow(String title, int count, ThemeData theme, 
      VoidCallback onIncrement, VoidCallback onDecrement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: count > 0 ? onDecrement : null,
              icon: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.remove,
                  size: 16,
                  color: count > 0 
                    ? theme.iconTheme.color
                    : theme.disabledColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: onIncrement,
              icon: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme, AvailableDateController controller) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: controller.resetBooking,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFF6B35)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6B35),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: EventouryElevatedButton(
            onPressed: controller.bookNow,
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Footer replaced by shared BottomBarWidget
}
