import 'package:get/get.dart';
import 'reviews_service.dart';

class ReviewsVendorController extends GetxController {
  final ReviewsService _service = ReviewsService();

  var isLoading = true.obs;
  var average = 0.0.obs;
  var count = 0.obs;
  var distribution = <int, int>{}.obs;

  var reviews = <Map<String, dynamic>>[].obs;

  var category = 'All'.obs;
  var sort = 'Newest'.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final sum = await _service.fetchSummary();
    average.value = (sum['average'] as num).toDouble();
    count.value = sum['count'] as int;
    distribution.assignAll(Map<int, int>.from(sum['distribution'] ?? {}).map((k, v) => MapEntry(k, v)));

    final r = await _service.fetchReviews();
    reviews.assignAll(r);
    isLoading.value = false;
  }

  void setCategory(String c) {
    category.value = c;
    // In real app, re-fetch with filter
  }

  void setSort(String s) {
    sort.value = s;
    // In real app, re-sort or re-fetch
  }
}
