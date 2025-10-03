import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WebOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<WebOnboardingPageData> pages = const [
    WebOnboardingPageData(
      title: 'Experience the world from your browser',
      description: 'Access all travel features with the convenience of web browsing, anywhere, anytime.',
      imagePath: 'assets/onboarding_images/onboarding_4.jpeg',
    ),
    WebOnboardingPageData(
      title: 'Seamless booking across all devices',
      description: 'Start planning on mobile, continue on desktop. Your travel plans sync everywhere.',
      imagePath: 'assets/onboarding_images/onboarding_5.jpeg',
    ),
    WebOnboardingPageData(
      title: 'Manage your travel business effortlessly',
      description: 'Powerful vendor tools and analytics designed for the modern travel professional.',
      imagePath: 'assets/onboarding_images/onboarding_6.jpeg',
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
  Get.offAllNamed('/WebHomeScreen');
    }
  }

  void skip() {
  box.write('seenOnboarding', true);
  Get.offAllNamed('/WebHomeScreen');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class WebOnboardingPageData {
  final String title;
  final String description;
  final String imagePath;

  const WebOnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}