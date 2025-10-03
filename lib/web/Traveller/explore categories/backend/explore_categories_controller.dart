import 'package:eventoury/web/Traveller/sub%20categories/frontend/subcategories.dart';
import 'package:get/get.dart';

class ExploreCategoriesController extends GetxController {
  final RxBool isMobileMenuOpen = false.obs;
  
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Transportation',
      'description': 'Find the best transport and airport services.',
      'image': 'assets/home_screen/transport.jpg',
    },
    {
      'title': 'Events',
      'description': 'Experience thrilling and engaging events.',
      'image': 'assets/home_screen/events.jpg',
    },
    {
      'title': 'Tour Packages',
      'description': 'Explore beautiful tour packages for all budgets.',
      'image': 'assets/home_screen/tour_packages.jpeg',
    },
    {
      'title': 'Activities',
      'description': 'Enjoy fun outdoor activities to city tours.',
      'image': 'assets/onboarding_images/onboarding_3.jpeg',
    },
    {
      'title': 'Guide',
      'description': 'Get the best guides for your travel adventures.',
      'image': 'assets/onboarding_images/onboarding_4.jpeg',
    },
    {
      'title': 'Entertainment',
      'description': 'Find concerts, shows, and nightlife experiences.',
      'image': 'assets/onboarding_images/onboarding_5.jpeg',
    },
  ];

  void toggleMobileMenu() {
    isMobileMenuOpen.value = !isMobileMenuOpen.value;
  }

  void onCategoryTap(String categoryTitle) {
    // Navigate to subcategories screen
    Get.to(() => SubcategoriesScreen(categoryTitle: categoryTitle));
  }
}