import 'package:eventoury/mobile/home/frontend/widgets/explore.dart';
import 'package:eventoury/mobile/home/frontend/widgets/header.dart';
import 'package:eventoury/mobile/home/frontend/widgets/title.dart';
import 'package:eventoury/mobile/home/frontend/widgets/popular_deals.dart';
import 'package:eventoury/mobile/home/frontend/widgets/bottom_navigation.dart';
import 'package:eventoury/mobile/search/frontend/search_screen.dart';
import 'package:eventoury/mobile/home/frontend/controllers/home_controller.dart';
import 'package:eventoury/utils/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/global_keys.dart';

import '../../my_bookings/frontend/my_bookings.dart';
import '../../profile/frontend/profile_screen.dart';
import '../../wishlist/frontend/wishlist.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Initialize the controller
  final HomeController controller = Get.put(HomeController());

  Widget _getCurrentScreen() {
    return Obx(() {
      switch (controller.selectedIndex.value) {
        case 0:
          return _buildHomeContent();
        case 1:
          return const Wishlist();
        case 2:
          return const SearchScreen();
        case 3:
          return const MyBookingScreen();
        case 4:
          return const ProfileScreen();
        default:
          return _buildHomeContent();
      }
    });
  }



  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Header(),
            const SizedBox(height: 15),

            // Main Title Section
            MainTitle(),
            const SizedBox(height: 15),

            // Explore Section
            Builder(builder: (context) => ExploreSection(context: context)),
            const SizedBox(height: 30),

            // Popular Deals Section
            const PopularDealsSection(),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;

// ignore_for_file: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
  final navigator = homeNestedKey.currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
          return false;
        }
        if (controller.selectedIndex.value != 0) {
          controller.changeTab(0);
          return false;
        } else {
          final now = DateTime.now();
          if (lastPressed == null ||
              now.difference(lastPressed!) > const Duration(seconds: 2)) {
            lastPressed = now;
            Loaders.simpleSnackBar(title: 'Exit App', message: 'Press back again to exit', context: context);
            return false;
          }
          return true;
        }
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Navigator(
                  key: homeNestedKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => _getCurrentScreen(),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(() {
                    return controller.showBottomNav.value
                        ? CustomBottomNavigation(
                            selectedIndex: controller.selectedIndex.value,
                            onTap: (index) {
                              controller.changeTab(index);
                            },
                          )
                        : const SizedBox.shrink();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
