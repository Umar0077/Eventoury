import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class AdminProfile extends StatelessWidget {
	const AdminProfile({super.key});

	@override
	Widget build(BuildContext context) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		final sectionBg = isDark ? Colors.black : Colors.white;

		return Scaffold(
			appBar: AppBar(
				leading: IconButton(
					icon: const Icon(Icons.arrow_back),
					onPressed: () => Navigator.maybePop(context),
				),
				title: Text('Profile', style: Theme.of(context).textTheme.titleLarge),
				backgroundColor: Theme.of(context).scaffoldBackgroundColor,
				elevation: 0,
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						// Profile Card
						Center(
							child: Container(
								width: double.infinity,
								padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
								decoration: BoxDecoration(
									color: sectionBg,
									borderRadius: BorderRadius.circular(12),
									boxShadow: [BoxShadow(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0,6))],
								),
								child: Column(
									children: [
										CircleAvatar(radius: 44, backgroundColor: EventouryColors.tangerine.withOpacity(0.2), child: const Icon(Icons.person, color: Colors.white, size: 40)),
										const SizedBox(height: 12),
										Text('Huzaifa Noor', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
										const SizedBox(height: 4),
										Text('Administrator', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
									],
								),
							),
						),

						const SizedBox(height: 18),

						// Contact Information
						Text('Contact Information', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
						const SizedBox(height: 8),
						_infoField(context, label: 'Email', value: 'huzaifa.noor@example.com', bg: sectionBg),
						const SizedBox(height: 8),
						_infoField(context, label: 'Phone', value: '+1234567890', bg: sectionBg),
						const SizedBox(height: 8),
						_infoField(context, label: 'Role', value: 'Administrator', bg: sectionBg),

						const SizedBox(height: 18),

						// Settings
						Text('Settings', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
						const SizedBox(height: 8),
						_settingsItem(context, icon: Icons.manage_accounts, title: 'Manage Account', onTap: () {} , bg: sectionBg),
						_settingsItem(context, icon: Icons.notifications, title: 'Notifications', onTap: () {}, bg: sectionBg),
						_settingsItem(context, icon: Icons.lock, title: 'Change Password', onTap: () {}, bg: sectionBg),

						const SizedBox(height: 24),

						// Logout Button
						Center(
							child: SizedBox(
								width: double.infinity,
								child: EventouryElevatedButton(
									onPressed: () {
										_confirmLogout(context);
									},
									child: const Text('Logout'),
								),
							),
						),
					],
				),
			),
		);
	}

	Widget _infoField(BuildContext context, {required String label, required String value, required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		return Container(
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: bg,
				borderRadius: BorderRadius.circular(10),
				boxShadow: [BoxShadow(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0,4))],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
					const SizedBox(height: 6),
					Text(value, style: Theme.of(context).textTheme.bodyMedium),
				],
			),
		);
	}

	Widget _settingsItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		return InkWell(
			onTap: onTap,
			child: Container(
				margin: const EdgeInsets.only(bottom: 8),
				padding: const EdgeInsets.all(12),
				decoration: BoxDecoration(
					color: bg,
					borderRadius: BorderRadius.circular(10),
					boxShadow: [BoxShadow(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0,3))],
				),
				child: Row(
					children: [
						Icon(icon, color: EventouryColors.tangerine),
						const SizedBox(width: 12),
						Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
						const Icon(Icons.chevron_right)
					],
				),
			),
		);
	}

	void _confirmLogout(BuildContext context) {
		showDialog(context: context, builder: (_) => AlertDialog(
			title: const Text('Confirm Logout'),
			content: const Text('Are you sure you want to logout?'),
			actions: [
				EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
				EventouryElevatedButton(onPressed: () {
					// perform logout logic here
					Navigator.pop(context);
				}, child: const Text('Logout')),
			],
		));
	}
}
