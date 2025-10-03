import 'package:get/get.dart';

class VendorHomeController extends GetxController {
  var selectedIndex = 0.obs;

  void onNavTap(int index) {
    selectedIndex.value = index;
  }
}
