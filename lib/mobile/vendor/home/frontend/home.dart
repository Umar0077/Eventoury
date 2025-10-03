import 'package:eventoury/mobile/vendor/bookings/frontend/bookings.dart';
import 'package:eventoury/mobile/vendor/home/frontend/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/global_keys.dart';
import '../../insight/insight_page.dart';
import '../../../../utils/constants/colors.dart';
import '../../profile/frontend/profile.dart';
import 'vendor_home_controller.dart';

class _VendorHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark ? 'assets/app_logos/logo_5.png' : 'assets/app_logos/logo_4.png',
                  width: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome back, Usama Travel Co.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoCard(title: 'Bookings', value: '120', icon: Icons.book_online_rounded),
                  _InfoCard(title: 'Revenue', value: '2902', icon: Icons.bar_chart_rounded),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoCard(title: '230 reviews', value: '4.7', icon: Icons.star_rounded, isStar: true),
                  _InfoCard(title: 'Active Packages', value: '15', icon: Icons.card_travel_rounded),
                ],
              ),
              SizedBox(height: 24),
              Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              _ActivityItem(
                title: 'Booking #1245 – Daniyal Khan – 4342',
                time: '2 hours ago',
              ),
              _ActivityItem(
                title: 'Package Updated – "Hunza Trip Deluxe"',
                time: '3 hours ago',
              ),
              _ActivityItem(
                title: 'Review Added – ⭐⭐⭐⭐⭐ by Mahaz Noor',
                time: '4 hours ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ignore_for_file: deprecated_member_use
class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VendorHomeController controller = Get.put(VendorHomeController());
    return WillPopScope(
      onWillPop: () async {
  final navigator = vendorNestedKey.currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
          return false;
        }
        if (controller.selectedIndex.value != 0) {
          controller.onNavTap(0);
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Navigator(
                  key: vendorNestedKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => Obx(() {
                        switch (controller.selectedIndex.value) {
                          case 0:
                            return _VendorHomeContent();
                          case 1:
                            return const VendorInsightPage();
                          case 2:
                            return Center(child: Text(' Add Booking Screen'));
                          case 3:
                            return VendorBookingScreen();
                          case 4:
                            return VendorProfileScreen();
                          default:
                            return _VendorHomeContent();
                        }
                      }),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(() {
                    return VendorBottomNavigation(
                      selectedIndex: controller.selectedIndex.value,
                      onTap: controller.onNavTap,
                    );
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isStar;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    this.isStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        color: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: EventouryColors.tangerine,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 6),
              Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String time;

  const _ActivityItem({
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: EventouryColors.tangerine,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 2),
                  Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
