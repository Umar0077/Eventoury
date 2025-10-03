import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final isDark = theme.brightness == Brightness.dark; // unused for now
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.person, size: 60, color: Colors.grey[400]),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: EventouryColors.persimmon,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text('Ahmed Travels & Tours', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Verified Vendor · Travel & Transport', style: textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _profileStat('120', 'Bookings'),
                  _profileStat('★ 4.8', 'Reviews'),
                ],
              ),
              SizedBox(height: 24),
              _settingsTile(Icons.edit, 'Edit Profile', () {}, context),
              const Divider(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(height: 16),
              _settingsTile(Icons.language, 'Change language', () {}, context),
              _settingsTile(Icons.brightness_6, 'Appearance', () {}, context),
              _settingsTile(Icons.notifications, 'Notification', () {}, context),
              _settingsTile(FontAwesomeIcons.headset, 'Support', () {}, context),
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
              SizedBox(
                width: double.infinity,
                child: EventouryElevatedButton(onPressed: () {}, child: Text('Logout'))
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
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
