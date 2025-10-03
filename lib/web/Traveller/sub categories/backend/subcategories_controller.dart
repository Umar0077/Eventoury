import 'package:eventoury/web/Traveller/Details/frontend/Details.dart';
import 'package:get/get.dart';

class SubcategoriesController extends GetxController {
  final RxBool isMobileMenuOpen = false.obs;
  final RxString categoryTitle = 'Event'.obs;
  
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[
    {
      'title': 'Adventures Tours',
      'subtitle': '128+ people',
      'rating': 4.8,
      'price': '\$199',
      'image': 'assets/onboarding_images/onboarding_1.jpeg',
      'isFavorite': false,
    },
    {
      'title': 'Family Tours',
      'subtitle': '85+ people',
      'rating': 4.8,
      'price': '\$149',
      'image': 'assets/onboarding_images/onboarding_2.jpeg',
      'isFavorite': false,
    },
    {
      'title': 'Couple Tours',
      'subtitle': '92+ people',
      'rating': 4.3,
      'price': '\$899',
      'image': 'assets/onboarding_images/onboarding_3.jpeg',
      'isFavorite': false,
    },
    {
      'title': 'Baby Shower',
      'subtitle': '64+ people',
      'rating': 4.6,
      'price': '\$799',
      'image': 'assets/onboarding_images/onboarding_4.jpeg',
      'isFavorite': false,
    },
  ].obs;

  void toggleMobileMenu() {
    isMobileMenuOpen.value = !isMobileMenuOpen.value;
  }

  void toggleFavorite(int index) {
    events[index]['isFavorite'] = !events[index]['isFavorite'];
    events.refresh();
  }

  void onEventTap(String eventTitle) {
    // Find the event data
    final event = events.firstWhere((e) => e['title'] == eventTitle);
    
    // Navigate to details screen with event data
    Get.to(() => DetailsScreen(
      title: event['title'],
      location: 'Bali, Indonesia',
      country: 'Indonesia',
      rating: event['rating'],
      reviewCount: int.parse(event['subtitle'].replaceAll(RegExp(r'[^0-9]'), '')),
      price: event['price'],
    ));
  }
}