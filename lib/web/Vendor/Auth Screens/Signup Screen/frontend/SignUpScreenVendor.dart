import 'dart:async';

import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Vendor/Auth Screens/Signup Screen/backend/vendor_signup_controller.dart';
import 'package:eventoury/web/Vendor/Auth Screens/Login Screen/frontend/LoginScreenVendor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreenVendor extends StatefulWidget {
  const SignUpScreenVendor({super.key});

  @override
  State<SignUpScreenVendor> createState() => _SignUpScreenVendorState();
}

class _SignUpScreenVendorState extends State<SignUpScreenVendor> {
  final List<String> imgs = [
    'assets/onboarding_images/onboarding_1.jpeg',
    'assets/onboarding_images/onboarding_2.jpeg',
    'assets/onboarding_images/onboarding_3.jpeg',
  ];
  int index = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() => index = (index + 1) % imgs.length);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorSignupController());
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

  final isDesktop = screenWidth > 1000;
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/onboarding_images/onboarding_4.jpeg', fit: BoxFit.cover)),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 24, vertical: 24),
              child: Container(
                width: double.infinity,
                height: isDesktop ? screenHeight * 0.9 : null,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06)),
                  boxShadow: [BoxShadow(color: theme.shadowColor.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Create Account Vendor', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
                            const SizedBox(height: 24),
                            TextField(controller: controller.nameController, decoration: InputDecoration(hintText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white)),
                            const SizedBox(height: 12),
                            TextField(controller: controller.emailController, decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white)),
                            const SizedBox(height: 12),
                            TextField(controller: controller.passwordController, obscureText: true, decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white)),
                            const SizedBox(height: 12),
                            TextField(controller: controller.confirmController, obscureText: true, decoration: InputDecoration(hintText: 'Confirm Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), filled: true, fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white)),
                            const SizedBox(height: 12),
                            Obx(() => SizedBox(width: double.infinity, height: 48, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), onPressed: controller.isLoading.value ? null : controller.signup, child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white) : const Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))))),
                            const SizedBox(height: 16),
                            Row(children: [Expanded(child: Divider(color: theme.dividerColor)), const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('OR')), Expanded(child: Divider(color: theme.dividerColor))]),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                icon: FaIcon(FontAwesomeIcons.google, color: EventouryColors.tangerine),
                                label: Text('Continue with Google', style: TextStyle(color: EventouryColors.tangerine)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                                  side: BorderSide(color: theme.dividerColor),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                icon: FaIcon(FontAwesomeIcons.apple, color: EventouryColors.tangerine),
                                label: Text('Continue with Apple', style: TextStyle(color: EventouryColors.tangerine)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                                  side: BorderSide(color: theme.dividerColor),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Already have an account? '),
                                  TextButton(onPressed: () { Get.to(() => const LoginScreenVendor()); }, child: Text('Login', style: TextStyle(color: EventouryColors.tangerine))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isDesktop)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Positioned.fill(child: Image.asset(imgs[index], fit: BoxFit.cover)),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: imgs.asMap().entries.map((e) {
                                      return Container(
                                        width: 36,
                                        height: 6,
                                        margin: const EdgeInsets.symmetric(horizontal: 6),
                                        decoration: BoxDecoration(color: e.key == index ? EventouryColors.tangerine : Colors.white24, borderRadius: BorderRadius.circular(6)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
