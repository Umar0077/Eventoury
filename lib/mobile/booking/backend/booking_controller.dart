import 'package:get/get.dart';

class BookingController extends GetxController {
  final DateTime today =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var currentMonth = DateTime(DateTime.now().year, DateTime.now().month).obs;
  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;

  var adults = 2.obs;
  var children = 4.obs;
  var kids = 0.obs;

  /// Returns all days of the current month
  List<DateTime> getDaysInMonth(DateTime month) {
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
          (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  /// Number of empty slots at start of month for alignment
  int getStartingWeekday(DateTime month) {
    return DateTime(month.year, month.month, 1).weekday % 7; // Sunday = 0
  }

  /// Checks if a date is in the selected range
  bool isInRange(DateTime day) {
    return !day.isBefore(selectedStartDate.value) &&
        !day.isAfter(selectedEndDate.value);
  }

  /// Resets booking
  void resetBooking() {
    adults.value = 0;
    children.value = 0;
    kids.value = 0;
    selectedStartDate.value = today;
    selectedEndDate.value = today;
    currentMonth.value = DateTime(today.year, today.month);
  }

  /// Dynamic range selection logic
  void selectDate(DateTime day) {
    if (day.isBefore(today)) return;

    // Case 1: first selection (start and end are same)
    if (selectedStartDate.value == selectedEndDate.value) {
      if (day.isBefore(selectedStartDate.value)) {
        selectedStartDate.value = day;
      } else {
        selectedEndDate.value = day;
      }
    } else {
      // Case 2: range already exists
      if (day.isBefore(selectedStartDate.value)) {
        // Clicked before start → update start
        selectedStartDate.value = day;
      } else if (day.isAfter(selectedEndDate.value)) {
        // Clicked after end → update end
        selectedEndDate.value = day;
      } else {
        // Clicked inside existing range → reset to single date
        selectedStartDate.value = day;
        selectedEndDate.value = day;
      }
    }
  }

  /// Navigate to previous month
  void goToPreviousMonth() {
    final prevMonth =
    DateTime(currentMonth.value.year, currentMonth.value.month - 1);
    if (!prevMonth.isBefore(DateTime(today.year, today.month))) {
      currentMonth.value = prevMonth;
    }
  }

  /// Navigate to next month
  void goToNextMonth() {
    currentMonth.value =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1);
  }
}
