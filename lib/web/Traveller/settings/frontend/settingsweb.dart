import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/settings/backend/settings_controller.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
// bottom bar removed for this screen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eventoury/web/Traveller/authentication/signin_required.dart';
import 'dart:math';

import 'package:eventoury/web/Traveller/profile/frontend/profileweb.dart';
import 'package:eventoury/web/Traveller/wishlist/frontend/wishlistweb.dart';

class SettingsWeb extends StatelessWidget {
  const SettingsWeb({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(SettingsController());
  final theme = Theme.of(context);
  // If not signed in, show the sign-in prompt
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const SignInRequired();
  }
  // final isDark = theme.brightness == Brightness.dark; // unused after topbar extraction
    final screenWidth = MediaQuery.of(context).size.width;

    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;

    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    // pick a random avatar image from available assets for the profile/upload area
    final avatarImages = [
      'assets/onboarding_images/onboarding_1.jpeg',
      'assets/onboarding_images/onboarding_2.jpeg',
      'assets/onboarding_images/onboarding_3.jpeg',
      'assets/home_screen/events.jpg',
    ];
    final randomAvatar = AssetImage(avatarImages[Random().nextInt(avatarImages.length)]);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          TopBarWidget(activeItem: 'Settings'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Profile header
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20, vertical: isMobile ? 16 : 22),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06)),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadowColor.withOpacity(0.06),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Obx(() => CircleAvatar(radius: isMobile ? 36 : 48, backgroundColor: controller.isDarkMode.value ? theme.primaryColor : theme.cardColor, backgroundImage: randomAvatar))),
                            const SizedBox(height: 12),
                            Center(child: Text('Huzaifa Noor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.textTheme.titleLarge?.color))),
                            const SizedBox(height: 4),
                            Center(child: Text('Lahore, Pakistan', style: TextStyle(color: theme.textTheme.bodySmall?.color))),
                            const SizedBox(height: 18),

                            // Top links
                            _listRow('Profile', theme, onTap: () => Get.to(() => const ProfileWeb())),
                            Divider(color: theme.dividerColor.withOpacity(0.06)),
                            _listRow('Wishlist', theme, onTap: () => Get.to(() => WishlistWeb())),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Account Setting
                      Text('Account Setting', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: theme.textTheme.titleLarge?.color)),
                      const SizedBox(height: 12),
                      // Edit profile removed per request
                      _cardButton(context, icon: Icons.translate, title: 'Change language', theme: theme, onTap: () {}),

                      const SizedBox(height: 24),

                      Text('Eventoury Legal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: theme.textTheme.titleLarge?.color)),
                      const SizedBox(height: 12),
                      _cardButton(context, icon: Icons.description_outlined, title: 'Terms and Condition', theme: theme, onTap: () {}),
                      const SizedBox(height: 8),
                      _cardButton(context, icon: Icons.privacy_tip_outlined, title: 'Privacy policy', theme: theme, onTap: () {}),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // replaced by shared TopBarWidget

  Widget _listRow(String title, ThemeData theme, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(color: theme.textTheme.bodyLarge?.color)), Icon(Icons.chevron_right, color: theme.iconTheme.color)]),
      ),
    );
  }

  // nav item helper removed; TopBarWidget provides navigation UI now.

  Widget _cardButton(BuildContext context, {required IconData icon, required String title, required ThemeData theme, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
        child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.dividerColor.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Icon(icon, color: theme.iconTheme.color), const SizedBox(width: 12), Text(title, style: TextStyle(color: theme.textTheme.bodyLarge?.color))]), Icon(Icons.open_in_new, color: theme.iconTheme.color)]),
      ),
    );
  }

  // Footer removed; use BottomBarWidget
}
