import 'dart:async';

class RevenueService {
  // Simulate network call to fetch KPI summary
  Future<Map<String, dynamic>> fetchKpis() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'totalRevenue': 80500,
      'growthPercent': 15,
      'averageRevenue': 688,
      'topPackage': 'City Tour',
    };
  }

  // Simulate fetch for chart points (e.g., last 30 days)
  Future<List<double>> fetchLineChartData({int points = 30}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(points, (i) => 2000 + (i % 6) * 600 + (i.isEven ? 200 : -200)).map((e) => e.toDouble()).toList();
  }

  // Simulate fetch for donut segments
  Future<List<Map<String, dynamic>>> fetchDonutSegments() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return [
      {'label': 'City Tour', 'value': 35000.0},
      {'label': 'Adventure', 'value': 25000.0},
      {'label': 'Relax', 'value': 15000.0},
      {'label': 'Other', 'value': 6000.0},
    ];
  }

  // Simulate recent bookings
  Future<List<Map<String, String>>> fetchRecentBookings() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return [
      {'id': '1245', 'name': 'Daniyal Khan', 'amount': '\$4,342', 'status': 'Completed'},
      {'id': '1244', 'name': 'Anaya Noor', 'amount': '\$1,750', 'status': 'Completed'},
      {'id': '1243', 'name': 'Ahmed Raza', 'amount': '\$4,980', 'status': 'Completed'},
      {'id': '1242', 'name': 'Hoorain Ali', 'amount': '\$4,500', 'status': 'Completed'},
    ];
  }
}
