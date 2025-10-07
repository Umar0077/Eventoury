import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:get/get.dart';
import '../Admin Home Screens/Dashboard/admin_dashboard.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 80),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Welcome Back Admin',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 24),
                  EventouryElevatedButton(
                    onPressed: () {
                      Get.to(() => const AdminDashboard());
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: EventouryColors.persimmon,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: EventouryColors.persimmon,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SocialButton(
                    icon: FontAwesomeIcons.google,
                    label: 'Continue with Google',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _SocialButton(
                    icon: Icons.apple,
                    label: 'Continue with Apple',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        side: BorderSide(color: EventouryColors.persimmon),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: EventouryColors.persimmon),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
