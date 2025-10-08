import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class AdminInsights extends StatelessWidget {
	const AdminInsights({super.key});

	@override
	Widget build(BuildContext context) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		final sectionBg = isDark ? Colors.black : Colors.white;

		return Scaffold(
			appBar: AppBar(
				title: Text('Insights', style: Theme.of(context).textTheme.titleLarge),
				backgroundColor: Theme.of(context).scaffoldBackgroundColor,
				elevation: 0,
				centerTitle: true,
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						// Analytics Overview
						Row(
							children: [
								Expanded(child: _metricCard(context, title: 'Revenue', value: '\$3,455.65', isRevenue: true, bg: sectionBg)),
								const SizedBox(width: 12),
								Expanded(child: _metricCard(context, title: 'Monthly Growth', value: '12.4%', isRevenue: false, bg: sectionBg)),
							],
						),
						const SizedBox(height: 18),

						// Alerts
						Text('Alerts', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
						const SizedBox(height: 8),
						Column(
							children: [
								_alertCard(context, 'Payment overdue: Vendor Ali Travels', bg: sectionBg),
								const SizedBox(height: 8),
								_alertCard(context, 'Low availability: Maldives Package', bg: sectionBg),
							],
						),
						const SizedBox(height: 18),

						// Recent Activity
						Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
						const SizedBox(height: 8),
						Column(
							children: List.generate(6, (i) => Padding(
								padding: const EdgeInsets.only(bottom: 8.0),
								child: _activityItem(context, avatarLabel: i % 2 == 0 ? 'H' : 'A', text: i % 2 == 0 ? 'Huzaifa booked Maldives' : 'Ali Travels added new package', time: '${i+1}h ago', bg: sectionBg),
							)),
						),
					],
				),
			),
			floatingActionButton: FloatingActionButton(
				heroTag: 'insights_fab',
				backgroundColor: EventouryColors.tangerine,
				onPressed: () {
					// optional: export or add report
					showDialog(context: context, builder: (_) => AlertDialog(
						title: const Text('Quick Action'),
						content: const Text('Export report or add custom metric.'),
						actions: [
							EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
						],
					));
				},
				child: const Icon(Icons.add, color: Colors.white),
			),
		);
	}

	Widget _metricCard(BuildContext context, {required String title, required String value, required bool isRevenue, required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		final shadow = isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.06);

		return Container(
			padding: const EdgeInsets.all(14),
			decoration: BoxDecoration(
				color: bg,
				borderRadius: BorderRadius.circular(12),
				boxShadow: [BoxShadow(color: shadow, blurRadius: 12, offset: const Offset(0,6))],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 8),
					Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: EventouryColors.tangerine, fontWeight: FontWeight.bold)),
					const SizedBox(height: 12),
					// Simple bar chart representation
					SizedBox(
						height: 60,
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.end,
							children: List.generate(7, (i) => Expanded(
								child: Container(
									margin: const EdgeInsets.symmetric(horizontal: 4),
									height: (20 + i * 8).toDouble(),
									decoration: BoxDecoration(
										gradient: LinearGradient(colors: isRevenue
											? [EventouryColors.tangerine.withOpacity(0.9), EventouryColors.persimmon]
											: [Colors.lightBlueAccent.withOpacity(0.9), Colors.pinkAccent.withOpacity(0.9)]),
										borderRadius: BorderRadius.circular(6),
									),
								),
							)),
						),
					),
				],
			),
		);
	}

	Widget _alertCard(BuildContext context, String text, {required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		return Container(
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: bg,
				borderRadius: BorderRadius.circular(12),
				boxShadow: [BoxShadow(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0,4))],
			),
			child: Row(
				children: [
					Icon(Icons.warning_amber_rounded, color: EventouryColors.tangerine),
					const SizedBox(width: 12),
					Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EventouryColors.tangerine))),
					EventouryElevatedButton(onPressed: () {}, child: const Text('Details')),
				],
			),
		);
	}

	Widget _activityItem(BuildContext context, {required String avatarLabel, required String text, String? time, required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		return Container(
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: bg,
				borderRadius: BorderRadius.circular(10),
				boxShadow: [BoxShadow(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0,4))],
			),
			child: Row(
				children: [
					CircleAvatar(radius: 20, backgroundColor: EventouryColors.tangerine.withOpacity(0.2), child: Text(avatarLabel, style: const TextStyle(color: Colors.white))),
					const SizedBox(width: 12),
					Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
					if (time != null) Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
				],
			),
		);
	}
}
