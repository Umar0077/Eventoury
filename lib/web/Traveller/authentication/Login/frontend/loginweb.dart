import 'dart:async';

import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/authentication/Login/backend/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventoury/web/Traveller/authentication/SignUp/frontend/Siginupweb.dart';
import 'package:eventoury/web/Vendor/Auth Screens/Login Screen/frontend/LoginScreenVendor.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
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
    final controller = Get.put(LoginController());
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

  final isDesktop = screenWidth > 1000;
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // full background image
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
                ),
                child: Row(
                  children: [
                    // left form
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
                            const SizedBox(height: 24),
                            TextField(controller: controller.emailController, decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                            const SizedBox(height: 12),
                            TextField(controller: controller.passwordController, obscureText: true, decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                            const SizedBox(height: 12),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [TextButton(onPressed: () {}, child: Text('Forgot Password?', style: TextStyle(color: EventouryColors.tangerine))), TextButton(onPressed: () { Get.to(() => const SignupWeb()); }, child: Text('Sign Up', style: TextStyle(color: EventouryColors.tangerine)))]),
                            const SizedBox(height: 8),
                            Obx(() => SizedBox(width: double.infinity, height: 48, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), onPressed: controller.isLoading.value ? null : controller.login, child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white) : const Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))))),
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
                                onPressed: controller.signInWithGoogle,
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
                                onPressed: controller.signInWithApple,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // prompt under social buttons
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Don't have an account? "),
                                      TextButton(
                                        onPressed: () => Get.to(() => const SignupWeb()),
                                        child: Text('Sign Up', style: TextStyle(color: EventouryColors.tangerine)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  TextButton(
                                    onPressed: () => Get.to(() => const LoginScreenVendor()),
                                    child: Text('Join as a vendor', style: TextStyle(color: EventouryColors.tangerine, decoration: TextDecoration.underline)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // right image carousel
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
