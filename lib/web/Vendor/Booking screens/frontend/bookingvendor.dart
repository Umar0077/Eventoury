import 'package:flutter/material.dart';
// get package not needed in this file
import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/utils/constants/colors.dart';

class BookingVendor extends StatelessWidget {
  const BookingVendor({super.key});

  @override
  Widget build(BuildContext context) {
	final bookings = [
	  {'name': 'Ahmed Khan', 'package': 'City Tour - 2 Days', 'status': 'Confirmed', 'datetime': '12 Sept, 10:30 AM'},
	  {'name': 'Sara Ali', 'package': 'Beach Resort - 3 Days', 'status': 'Pending', 'datetime': '15 Sept, 12:00 PM'},
	  {'name': 'Michael Johnson', 'package': 'Mountain Hiking - 1 Day', 'status': 'Cancelled', 'datetime': '20 Sept, 9:00 AM'},
	];

		return VendorLayout(
	  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 28.0),
	  floatingActionButton: FloatingActionButton(
					heroTag: 'bookingvendor_fab',
					onPressed: () {},
		backgroundColor: EventouryColors.tangerine,
		child: const Icon(Icons.add),
	  ),
	  child: BookingVendorContent(bookings: bookings),
	);
  }
}

class BookingVendorContent extends StatelessWidget {
	final List<Map<String, String>> bookings;
	final Widget Function(BuildContext, Map<String, String>)? bookingCardBuilder;

	const BookingVendorContent({super.key, List<Map<String, String>>? bookings, this.bookingCardBuilder})
			: bookings = bookings ?? const [
					{'name': 'Ahmed Khan', 'package': 'City Tour - 2 Days', 'status': 'Confirmed', 'datetime': '12 Sept, 10:30 AM'},
					{'name': 'Sara Ali', 'package': 'Beach Resort - 3 Days', 'status': 'Pending', 'datetime': '15 Sept, 12:00 PM'},
					{'name': 'Michael Johnson', 'package': 'Mountain Hiking - 1 Day', 'status': 'Cancelled', 'datetime': '20 Sept, 9:00 AM'},
				];

	Color _statusColor(String status) {
		switch (status.toLowerCase()) {
			case 'confirmed':
				return Colors.green.shade600;
			case 'pending':
				return Colors.orange.shade600;
			case 'cancelled':
				return Colors.red.shade400;
			default:
				return Colors.grey;
		}
	}

	Widget _defaultBookingCard(BuildContext context, Map<String, String> b) {
		final status = b['status'] ?? '';
		final theme = Theme.of(context);
		final isDark = theme.brightness == Brightness.dark;
		return Card(
			color: isDark ? theme.cardColor : Colors.white,
			margin: const EdgeInsets.symmetric(vertical: 12),
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
			elevation: isDark ? 0.6 : 6,
			child: Padding(
				padding: const EdgeInsets.all(18.0),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(b['name'] ?? '', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.headlineSmall?.color)),
									const SizedBox(height: 6),
									Text(b['package'] ?? '', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyLarge?.color)),
									const SizedBox(height: 10),
									Container(
										padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
										decoration: BoxDecoration(color: _statusColor(status).withOpacity(0.18), borderRadius: BorderRadius.circular(6)),
										child: Text(status, style: TextStyle(color: _statusColor(status), fontWeight: FontWeight.w600)),
									),
									const SizedBox(height: 8),
									Text(b['datetime'] ?? '', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white54 : theme.textTheme.bodySmall?.color)),
								],
							),
						),
						const SizedBox(width: 20),
						Column(
							mainAxisSize: MainAxisSize.min,
							children: [
								OutlinedButton(
									onPressed: () {},
									style: OutlinedButton.styleFrom(
										side: BorderSide(color: EventouryColors.tangerine),
										foregroundColor: EventouryColors.tangerine,
										backgroundColor: isDark ? theme.cardColor : Colors.white,
										padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
									),
									child: Text('Message', style: TextStyle(color: EventouryColors.tangerine)),
								),
								const SizedBox(height: 8),
								ElevatedButton(
									onPressed: () {},
									style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
									child: Text('Details', style: TextStyle(color: isDark ? Colors.white : Colors.white)),
								),
							],
						)
					],
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		final builder = bookingCardBuilder ?? _defaultBookingCard;
		final theme = Theme.of(context);
		return DefaultTabController(
			length: 3,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Text('Bookings', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
							Row(children: [IconButton(onPressed: () {}, icon: const Icon(Icons.search)), IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))]),
						],
					),
					const SizedBox(height: 12),
						TabBar(
							labelColor: theme.textTheme.bodyLarge?.color ?? Theme.of(context).primaryColor,
							unselectedLabelColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.85) ?? Colors.black54,
							indicatorColor: EventouryColors.tangerine,
							labelStyle: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600) ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
							unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500) ?? const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
							tabs: const [Tab(text: 'Ongoing'), Tab(text: 'Upcoming'), Tab(text: 'Completed')],
						),
					const SizedBox(height: 16),
					Expanded(
						child: TabBarView(
							children: [
								// Ongoing
								ListView.builder(
									itemCount: bookings.length,
									itemBuilder: (context, i) => builder(context, bookings[i]),
								),
								// Upcoming (placeholder reuse)
								ListView.builder(
									itemCount: bookings.length,
									itemBuilder: (context, i) => builder(context, bookings[i]),
								),
								// Completed (placeholder reuse)
								ListView.builder(
									itemCount: bookings.length,
									itemBuilder: (context, i) => builder(context, bookings[i]),
								),
							],
						),
					)
				],
			),
		);
	}
}

