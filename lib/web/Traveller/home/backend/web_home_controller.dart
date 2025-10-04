import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebHomeController extends GetxController {
  final RxString selectedLocation = 'Thailand'.obs;
  final RxBool isSearchFocused = false.obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxBool isMobileMenuOpen = false.obs;
  // Currently active top navigation item (used for highlighting)
  final RxString activeNav = 'Home'.obs;

  final List<String> categories = [
    'Activities',
    'Lessons/Classes',
    'Transportation',
    'Guide',
    'Accommodation',
    'Entertainment',
    'Tourist Attraction Spots',
    'Fitness and Wellbeing',
    'Cultural, Heritage, and History',
    'Tickets',
    'Events',
    'Tour Packages',
    'VIP Protocol'
  ];

  final RxList<Map<String, dynamic>> hotDeals = <Map<String, dynamic>>[
    {
      'title': 'Beach View, Thailand',
      'location': 'Thailand',
      'rating': 4.5,
      'beach': 'Beach View',
      'wifi': true,
      'image': 'assets/onboarding_images/onboarding_1.jpeg',
      'isFavorite': false,
    },
    {
      'title': 'Mountain Adventure, Nepal',
      'location': 'Nepal',
      'rating': 4.7,
      'beach': 'Mountain View',
      'wifi': true,
      'image': 'assets/onboarding_images/onboarding_2.jpeg',
      'isFavorite': false,
    },
    {
      'title': 'City Explorer, Japan',
      'location': 'Japan',
      'rating': 4.3,
      'beach': 'City View',
      'wifi': true,
      'image': 'assets/onboarding_images/onboarding_3.jpeg',
      'isFavorite': false,
    },
  ].obs;

  void toggleFavorite(int index) {
    hotDeals[index]['isFavorite'] = !hotDeals[index]['isFavorite'];
    hotDeals.refresh();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void setSearchFocus(bool focused) {
    isSearchFocused.value = focused;
  }

  void toggleMobileMenu() {
    isMobileMenuOpen.value = !isMobileMenuOpen.value;
  }

  void setActiveNav(String item) {
    activeNav.value = item;
  }

  // Keys for in-page navigation (Explore, Hot Deals, Footer/Contact)
  // Keys are nullable and registered by the WebHomeScreen instance to avoid
  // reusing the same GlobalKey across multiple widget instances (hot reload safe).
  GlobalKey? exploreKey;
  GlobalKey? hotDealsKey;
  // About section key
  GlobalKey? aboutKey;
  GlobalKey? footerKey;

  // Scroll to a section using Scrollable.ensureVisible
  void scrollToKey(GlobalKey? key) {
    try {
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      }
    } catch (_) {}
  }

  void scrollToExplore() => scrollToKey(exploreKey);
  void scrollToHotDeals() => scrollToKey(hotDealsKey);
  void scrollToAbout() => scrollToKey(aboutKey);
  void scrollToContact() => scrollToKey(footerKey);

  // Register keys supplied by the WebHomeScreen instance so each screen has
  // its own unique GlobalKeys (prevents duplicate GlobalKey exceptions).
  void registerExploreKey(GlobalKey key) => exploreKey = key;
  void registerHotDealsKey(GlobalKey key) => hotDealsKey = key;
  void registerAboutKey(GlobalKey key) => aboutKey = key;
  void registerFooterKey(GlobalKey key) => footerKey = key;
}