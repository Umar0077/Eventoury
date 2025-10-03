import 'package:get/get.dart';
import 'package:eventoury/utils/global_keys.dart';

class HomeController extends GetxController {
  // Observable variable for selected navigation index
  final RxInt selectedIndex = 0.obs;

  // Method to change selected index
  void changeTab(int index) {
    // Pop all routes in the nested navigator before changing tab
  final navigator = homeNestedKey.currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
    }
    selectedIndex.value = index;
  }

  // Getter for current selected index
  int get currentIndex => selectedIndex.value;

  var showBottomNav = true.obs;

  void hideNavBar() => showBottomNav.value = false;
  void showNavBar() => showBottomNav.value = true;
}
