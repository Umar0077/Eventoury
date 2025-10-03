import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/mobile/home/frontend/home_screen.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingPageData> pages = const [
    OnboardingPageData(
      title: 'Explore destinations worldwide',
      description: 'Discover cities, nature, and hidden gems.',
      imagePath: 'assets/onboarding_images/onboarding_1.jpeg',
    ),
    OnboardingPageData(
      title: 'Plan your journey in a few taps',
      description: 'Book flights, hotels, and activities seamlessly.',
      imagePath: 'assets/onboarding_images/onboarding_2.jpeg',
    ),
    OnboardingPageData(
      title: 'Unlock exclusive travel deals',
      description: 'Save more, travel more.',
      imagePath: 'assets/onboarding_images/onboarding_3.jpeg',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  final box = GetStorage();

  void nextOrFinish() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      box.write('seenOnboarding', true);
      Get.offAll(() => HomeScreen());
    }
  }

  void skip() {
    box.write('seenOnboarding', true);
    Get.offAll(() => HomeScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingPageData {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
