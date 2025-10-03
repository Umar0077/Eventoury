import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDarkMode = true.obs; // placeholder, can be linked to actual theme settings

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
