import 'package:get/get.dart';
import 'revenue_service.dart';

class RevenueVendorController extends GetxController {
  final RevenueService _service = RevenueService();

  var selectedFilter = 'Daily'.obs;

  var isLoading = true.obs;
  var totalRevenue = 0.obs;
  var growthPercent = 0.obs;
  var averageRevenue = 0.obs;
  var topPackage = ''.obs;

  var lineChartPoints = <double>[].obs;
  var donutSegments = <Map<String, dynamic>>[].obs;
  var recentBookings = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    isLoading.value = true;
    final kpis = await _service.fetchKpis();
    totalRevenue.value = kpis['totalRevenue'] ?? 0;
    growthPercent.value = kpis['growthPercent'] ?? 0;
    averageRevenue.value = kpis['averageRevenue'] ?? 0;
    topPackage.value = kpis['topPackage'] ?? '';

    final points = await _service.fetchLineChartData(points: 30);
    lineChartPoints.assignAll(points);

    final segments = await _service.fetchDonutSegments();
    donutSegments.assignAll(segments);

    final bookings = await _service.fetchRecentBookings();
    recentBookings.assignAll(bookings);

    isLoading.value = false;
  }

  void setFilter(String f) {
    selectedFilter.value = f;
    // Ideally reload data with filter applied. For mock, just reload.
    loadAll();
  }
}
