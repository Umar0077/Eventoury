import 'package:get/get.dart';
import '../../booking/frontend/booking.dart';

class AvailableDateController extends GetxController {
  // Selected date
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  
  // Current month for calendar display
  final Rx<DateTime> currentMonth = DateTime.now().obs;
  
  // Guest counts
  final RxInt adults = 2.obs;
  final RxInt children = 4.obs;
  final RxInt babies = 0.obs;
  
  // Available/highlighted dates for booking
  final List<int> highlightedDates = [11, 12, 13, 14, 21, 22];
  
  // Calendar navigation
  void previousMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year, 
      currentMonth.value.month - 1
    );
  }
  
  void nextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year, 
      currentMonth.value.month + 1
    );
  }
  
  // Date selection
  void selectDate(int day) {
    selectedDate.value = DateTime(
      currentMonth.value.year, 
      currentMonth.value.month, 
      day
    );
  }
  
  // Guest count management
  void incrementAdults() {
    adults.value++;
  }
  
  void decrementAdults() {
    if (adults.value > 0) {
      adults.value--;
    }
  }
  
  void incrementChildren() {
    children.value++;
  }
  
  void decrementChildren() {
    if (children.value > 0) {
      children.value--;
    }
  }
  
  void incrementBabies() {
    babies.value++;
  }
  
  void decrementBabies() {
    if (babies.value > 0) {
      babies.value--;
    }
  }
  
  // Reset all values to default
  void resetBooking() {
    adults.value = 2;
    children.value = 4;
    babies.value = 0;
    selectedDate.value = DateTime.now();
    currentMonth.value = DateTime.now();
  }
  
  // Book now action
  void bookNow() {
    // Navigate to Booking screen
  Get.to(() => BookingScreen());
  }
  
  // Utility methods
  bool isDateHighlighted(int day) {
    return highlightedDates.contains(day);
  }
  
  bool isDateSelected(int day) {
    return selectedDate.value.day == day && 
           selectedDate.value.month == currentMonth.value.month &&
           selectedDate.value.year == currentMonth.value.year;
  }
  
  String getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
  
  String formatDate(DateTime date) {
    return '${date.day} ${getMonthName(date.month)} ${date.year}';
  }
  
  int getTotalGuests() {
    return adults.value + children.value + babies.value;
  }
  
  // Get first day of the current month for calendar layout
  int getFirstDayWeekday() {
    final firstDay = DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    return firstDay.weekday == 7 ? 0 : firstDay.weekday;
  }
  
  // Get last day of the current month
  int getLastDayOfMonth() {
    return DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0).day;
  }
}