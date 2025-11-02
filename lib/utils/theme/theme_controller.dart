import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class ThemeController extends GetxController {
  static const _kKey = 'isDarkMode';
  final _box = GetStorage();
  final isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    final stored = _box.read(_kKey);
    if (stored != null && stored is bool) {
      isDark.value = stored;
    } else {
      // default to dark as requested
      isDark.value = true;
      _box.write(_kKey, true);
    }
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _box.write(_kKey, isDark.value);
    // inform GetMaterialApp via reactive binding in main
  }

  void setDark(bool value) {
    isDark.value = value;
    _box.write(_kKey, isDark.value);
  }
}
