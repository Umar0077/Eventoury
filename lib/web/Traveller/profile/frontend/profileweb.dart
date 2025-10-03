import 'package:eventoury/web/Traveller/profile/backend/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
// bottom bar removed for this screen
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class ProfileWeb extends StatelessWidget {
	const ProfileWeb({super.key});

	@override
	Widget build(BuildContext context) {
		final controller = Get.put(ProfileController());
		final theme = Theme.of(context);
		// final isDark = theme.brightness == Brightness.dark; // unused after TopBar extraction
		final screenWidth = MediaQuery.of(context).size.width;

		final isDesktop = screenWidth > 1200;
		final isTablet = screenWidth > 768 && screenWidth <= 1200;
		final isMobile = screenWidth <= 768;

		final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
		final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

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
					TopBarWidget(),
					Expanded(
						child: SingleChildScrollView(
							padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
							child: Center(
								child: Container(
									constraints: BoxConstraints(maxWidth: 900),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.center,
										children: [
																						const SizedBox(height: 10),
																						// Back + title row
																						Row(
																							children: [
																								IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, color: theme.iconTheme.color)),
																								const SizedBox(width: 8),
																								Text('Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
																							],
																						),
																						const SizedBox(height: 12),
																						// Profile Card
																						Container(
																				width: double.infinity,
																				padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: isMobile ? 20 : 36),
																				decoration: BoxDecoration(
																					color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
																					borderRadius: BorderRadius.circular(12),
																					boxShadow: [BoxShadow(color: theme.shadowColor.withOpacity(0.04), blurRadius: 12)],
																					border: Border.all(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06)),
																				),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.center,
													children: [
														// Avatar
														CircleAvatar(
															radius: isMobile ? 36 : 48,
															backgroundImage: randomAvatar,
														),
														const SizedBox(height: 12),
														Text(controller.nameController.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.textTheme.titleLarge?.color)),
														const SizedBox(height: 4),
														Text('Lahore, Pakistan', style: TextStyle(color: theme.textTheme.bodySmall?.color)),

														const SizedBox(height: 20),

														// Form fields
														Align(
															alignment: Alignment.centerLeft,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	_label('Name', theme),
																	const SizedBox(height: 8),
																	Obx(() => _inputField(controller.nameController, theme: theme, hint: 'Huzaifa Noor', readOnly: !controller.isEditing.value)),
																	const SizedBox(height: 16),
																	_label('Email', theme),
																	const SizedBox(height: 8),
																	Obx(() => _inputField(controller.emailController, theme: theme, hint: 'huzaifa.ux@gmail.com', readOnly: !controller.isEditing.value)),
																	const SizedBox(height: 16),
																	_label('Phone', theme),
																	const SizedBox(height: 8),
																	Obx(() => _inputField(controller.phoneController, theme: theme, hint: '+92 1234567890', readOnly: !controller.isEditing.value)),
																	const SizedBox(height: 16),
																	_label('Location', theme),
																	const SizedBox(height: 8),
																	Obx(() => _inputField(controller.locationController, theme: theme, hint: 'Lahore, Pakistan', readOnly: !controller.isEditing.value)),
																],
															),
														),

														const SizedBox(height: 24),
														Obx(() {
															if (!controller.isEditing.value) {
																return SizedBox(
																	width: isMobile ? double.infinity : 220,
																	child: EventouryElevatedButton(onPressed: controller.startEdit, child: const Text('Edit Changes')),
																);
															}
															// editing
															return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
																SizedBox(
																	width: isMobile ? 140 : 120,
																	child: EventouryElevatedButton(onPressed: controller.isSaving.value ? null : controller.saveProfile, child: controller.isSaving.value ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : const Text('Save')),
																),
																const SizedBox(width: 12),
																SizedBox(width: isMobile ? 140 : 120, child: OutlinedButton(onPressed: controller.cancelEdit, child: const Text('Cancel')))
															]);
														}),
													],
												),
											),

											const SizedBox(height: 40),
											// bottom bar removed for this screen
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

	Widget _label(String text, ThemeData theme) => Text(text, style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600));

	Widget _inputField(TextEditingController controller, {required ThemeData theme, String? hint, bool readOnly = false}) {
		return TextField(
			controller: controller,
			readOnly: readOnly,
			decoration: InputDecoration(
				hintText: hint,
				filled: true,
				fillColor: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
				border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
				contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
			),
		);
	}

 
  // Replaced by shared TopBarWidget
  
}

