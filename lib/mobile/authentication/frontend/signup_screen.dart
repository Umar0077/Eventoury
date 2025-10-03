import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

import '../backend/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Form(
              key: Get.put(SignupController()).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: Get.find<SignupController>().nameController,
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: Get.find<SignupController>().validateName,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: Get.find<SignupController>().emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: Get.find<SignupController>().validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: Get.find<SignupController>().passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: Get.find<SignupController>().validatePassword,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller:
                        Get.find<SignupController>().confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator:
                        Get.find<SignupController>().validateConfirmPassword,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Get.find<SignupController>().role.value,
                          isExpanded: true,
                          icon: const Icon(Icons.expand_more),
                          dropdownColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                          items: Get.find<SignupController>().roles
                              .map(
                                (r) => DropdownMenuItem<String>(
                                  value: r,
                                  child: Text(r, style: TextStyle(fontSize: 16),),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              Get.find<SignupController>().role.value = val;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => EventouryElevatedButton(
                      onPressed: Get.find<SignupController>().isSubmitting.value
                          ? null
                          : Get.find<SignupController>().submit,
                      isLoading:
                          Get.find<SignupController>().isSubmitting.value,
                      child: const Text('Create Account'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      side: BorderSide(color: EventouryColors.persimmon),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: EventouryColors.persimmon,
                        ),
                        SizedBox(width: 12),
                        Text('Continue with Google', style: Theme.of(context).textTheme.labelLarge,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      side: BorderSide(color: EventouryColors.persimmon),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(Icons.apple, color: EventouryColors.persimmon),
                        SizedBox(width: 12),
                        Text('Continue with Apple', style: Theme.of(context).textTheme.labelLarge,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: EventouryColors.persimmon,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
