import 'package:eventoury/mobile/authentication/frontend/login_screen.dart';
import 'package:eventoury/mobile/profile/frontend/edit_profile_screen.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/frontend/controllers/home_controller.dart';
import '../backend/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            final loggedIn = controller.user.value != null;
            return Column(
              children: [
                const SizedBox(height: 24),
                if (!loggedIn) ...[
                  Card(
                    color: Colors.orange.shade50,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.lock_outline, size: 48, color: EventouryColors.tangerine),
                          const SizedBox(height: 16),
                          Text(
                            'Log in to sync bookings, access your wishlist, and store your information securely.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          EventouryElevatedButton(onPressed: () {Get.to(LoginScreen());}, child: Text("Login/SignUp"))
                        ],
                      ),
                    ),
                  ),
                ],
                if (loggedIn) ...[
                  // Profile Image & Name
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: controller.user.value?.photoURL != null
                            ? NetworkImage(controller.user.value!.photoURL!)
                            : null,
                        child: controller.user.value?.photoURL == null
                            ? Icon(Icons.person, size: 36)
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Laiba Ahmar',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lahore, Pakistan',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Profile & Wishlist
                  Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1,
                    shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(Icons.edit, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                      title: Text('Profile', style: Theme.of(context).textTheme.bodyMedium),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Get.to(() => const EditProfileScreen(), id: 1);
                      },
                    ),
                  ),
                  Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1,
                    shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(Icons.favorite_outline, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                      title:  Text('Wishlist', style: Theme.of(context).textTheme.bodyMedium),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        final homeController = Get.find<HomeController>();
                        homeController.changeTab(1);
                      },
                    ),
                  ),
                  const Divider(height: 50),
                ],
                // Settings (always visible)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 16),
                _settingsTile(Icons.language, 'Change language', () {}, context),
                _settingsTile(Icons.brightness_6, 'Appearance', () {}, context),
                _settingsTile(Icons.notifications, 'Notification', () {}, context),
                const Divider(height: 50),
                // Legal (always visible)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Eventory Legal', style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 16),
                _settingsTile(Icons.shield_outlined, 'Terms and Condition', () {}, context),
                _settingsTile(Icons.privacy_tip_outlined, 'Privacy policy', () {}, context),
                const SizedBox(height: 24),
                if (loggedIn) ...[
                  // Logout Button
                  SizedBox(width: double.infinity, child: EventouryElevatedButton(onPressed: controller.logout, child: Text('Logout'))),
                  const SizedBox(height: 30),
                ],
                const SizedBox(height: 80),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, VoidCallback onTap, BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium,),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
        onTap: onTap,
      ),
    );
  }
}
