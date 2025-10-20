import 'package:get/get.dart';
import 'add_package_service.dart';

class AddPackageController extends GetxController {
  final AddPackageService _service = AddPackageService();

  var isLoading = false.obs;

  // Form fields
  var title = ''.obs;
  var shortDesc = ''.obs;
  var fullDesc = ''.obs;
  var location = ''.obs;
  var price = ''.obs;
  var duration = ''.obs;

  // Gallery (store urls or local paths in mock)
  var images = <String>[].obs;

  // Included / excluded items
  final List<String> defaultIncluded = ['Meals', 'Transport', 'Guide', 'Accommodation'];
  var included = <String>[].obs;
  final List<String> defaultExcluded = ['Flights', 'Visa', 'Personal Expenses'];
  var excluded = <String>[].obs;

  var isActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    included.assignAll(defaultIncluded);
    excluded.assignAll(defaultExcluded);
  }

  Future<void> addImage(dynamic imageFile) async {
    isLoading.value = true;
    final url = await _service.uploadImage(imageFile);
    images.add(url);
    isLoading.value = false;
  }

  void toggleIncluded(String item) {
    if (included.contains(item)) included.remove(item); else included.add(item);
  }

  void toggleExcluded(String item) {
    if (excluded.contains(item)) excluded.remove(item); else excluded.add(item);
  }

  Future<bool> savePackage() async {
    if (title.value.trim().isEmpty) return false;
    isLoading.value = true;
    final payload = {
      'title': title.value,
      'shortDesc': shortDesc.value,
      'fullDesc': fullDesc.value,
      'location': location.value,
      'price': price.value,
      'duration': duration.value,
      'images': images.toList(),
      'included': included.toList(),
      'excluded': excluded.toList(),
      'status': isActive.value ? 'Active' : 'Inactive',
    };
    final ok = await _service.savePackage(payload);
    isLoading.value = false;
    return ok;
  }
}
