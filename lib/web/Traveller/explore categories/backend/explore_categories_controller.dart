import 'package:eventoury/web/Traveller/sub%20categories/frontend/subcategories.dart';
import 'package:get/get.dart';

class ExploreCategoriesController extends GetxController {
  final RxBool isMobileMenuOpen = false.obs;
  
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Activities',
      'description': 'Enjoy fun outdoor activities to city tours.',
      'image': 'assets/onboarding_images/onboarding_1.jpeg',
    },
    {
      'title': 'Lessons/Classes',
      'description': 'Learn new skills with expert instructors.',
      'image': 'assets/onboarding_images/onboarding_2.jpeg',
    },
    {
      'title': 'Transportation',
      'description': 'Find the best transport and airport services.',
      'image': 'assets/home_screen/transport.jpg',
    },
    {
      'title': 'Guide',
      'description': 'Get the best guides for your travel adventures.',
      'image': 'assets/onboarding_images/onboarding_3.jpeg',
    },
    {
      'title': 'Accommodation',
      'description': 'Discover comfortable stays for every budget.',
      'image': 'assets/onboarding_images/onboarding_4.jpeg',
    },
    {
      'title': 'Entertainment',
      'description': 'Find concerts, shows, and nightlife experiences.',
      'image': 'assets/onboarding_images/onboarding_5.jpeg',
    },
    {
      'title': 'Tourist Attraction Spots',
      'description': 'Explore iconic landmarks and hidden gems.',
      'image': 'assets/onboarding_images/onboarding_6.jpeg',
    },
    {
      'title': 'Fitness and Wellbeing',
      'description': 'Maintain your health with fitness and wellness services.',
      'image': 'assets/onboarding_images/onboarding_1.jpeg',
    },
    {
      'title': 'Cultural, Heritage, and History',
      'description': 'Immerse yourself in rich cultural and historical experiences.',
      'image': 'assets/onboarding_images/onboarding_2.jpeg',
    },
    {
      'title': 'Tickets',
      'description': 'Book tickets for events, attractions, and experiences.',
      'image': 'assets/onboarding_images/onboarding_3.jpeg',
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
      'title': 'VIP Protocol',
      'description': 'Experience premium VIP services and exclusive access.',
      'image': 'assets/onboarding_images/onboarding_4.jpeg',
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