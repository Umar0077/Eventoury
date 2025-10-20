import 'dart:async';

class PackagesService {
  Future<List<Map<String, dynamic>>> fetchPackages() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {
        'id': 'p1',
        'title': 'Hunza Trip Deluxe',
        'subtitle': 'Explore the breathtaking Hunza Valley',
        'price': 900,
        'location': 'Hunza Valley',
        'description': '4 days, 3 nights: sightseeing, trekking, cultural visits.',
        'status': 'Active'
      },
      {
        'id': 'p2',
        'title': 'City Tour Classic',
        'subtitle': 'Best of the city in one day',
        'price': 120,
        'location': 'Lahore',
        'description': 'Guided city tour across major landmarks and food stops.',
        'status': 'Inactive'
      },
      {
        'id': 'p3',
        'title': 'Desert Safari',
        'subtitle': 'Sunset dunes and cultural night',
        'price': 450,
        'location': 'Thar Desert',
        'description': 'Camel rides, local music, and stargazing.',
        'status': 'Active'
      }
    ];
  }
}
