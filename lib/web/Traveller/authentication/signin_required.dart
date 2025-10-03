import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/Traveller/authentication/Login/frontend/loginweb.dart';

class SignInRequired extends StatelessWidget {
  const SignInRequired({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          tooltip: 'Back to home',
          onPressed: () {
            // navigate back to web home screen
            Get.offAllNamed('/WebHomeScreen');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, color: EventouryColors.tangerine, size: 96),
            const SizedBox(height: 16),
            Text('Please sign in to continue further', style: TextStyle(fontSize: 18, color: theme.textTheme.titleLarge?.color), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: EventouryElevatedButton(
                onPressed: () {
                  // navigate to login
                  Get.to(() => const LoginWeb());
                },
                child: const Text('Sign In', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
