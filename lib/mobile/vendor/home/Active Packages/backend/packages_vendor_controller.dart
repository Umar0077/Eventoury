import 'package:get/get.dart';
import 'packages_service.dart';

class PackagesVendorController extends GetxController {
  final PackagesService _service = PackagesService();

  var isLoading = true.obs;
  var packages = <Map<String, dynamic>>[].obs;

  var category = 'All'.obs;
  var status = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPackages();
  }

  Future<void> loadPackages() async {
    isLoading.value = true;
    final list = await _service.fetchPackages();
    packages.assignAll(list);
    isLoading.value = false;
  }

  void setCategory(String c) {
    category.value = c;
    // Implement filtering in real app
  }

  void setStatus(String s) {
    status.value = s;
    // Implement filtering in real app
  }

  void deletePackage(String id) {
    packages.removeWhere((p) => p['id'] == id);
  }
}
