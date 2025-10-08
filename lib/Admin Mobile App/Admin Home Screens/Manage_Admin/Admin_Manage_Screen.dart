import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class AdminManageScreen extends StatefulWidget {
  const AdminManageScreen({super.key});

  @override
  State<AdminManageScreen> createState() => _AdminManageScreenState();
}

class _AdminManageScreenState extends State<AdminManageScreen>
		with SingleTickerProviderStateMixin {
	late TabController _tabController;

	@override
	void initState() {
		super.initState();
		_tabController = TabController(length: 2, vsync: this);
			_tabController.addListener(() {
				// re-render when user swipes between tabs so the custom toggle updates
				if (mounted) setState(() {});
			});
	}

	Widget _buildCustomToggle(BuildContext context) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		final width = MediaQuery.of(context).size.width - 32; // padding accounted
		final pillWidth = (width / 2) - 6; // small gap

		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(4),
			decoration: BoxDecoration(
				color: Theme.of(context).scaffoldBackgroundColor,
				borderRadius: BorderRadius.circular(40),
				border: Border.all(color: isDark ? Colors.white24 : EventouryColors.tangerine.withOpacity(0.6), width: 1.5),
			),
			child: ClipRRect(
				borderRadius: BorderRadius.circular(40),
				child: Stack(
					children: [
					// selected pill
					AnimatedPositioned(
						duration: const Duration(milliseconds: 220),
						curve: Curves.easeInOut,
						left: _tabController.index == 0 ? 0 : pillWidth + 8,
						top: 0,
						bottom: 0,
						child: Container(
							width: pillWidth,
							margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
							decoration: BoxDecoration(
								color: EventouryColors.tangerine,
								borderRadius: BorderRadius.circular(28),
							),
						),
					),

					// labels and taps
					Row(
						children: [
							Expanded(
								child: InkWell(
									onTap: () => _tabController.animateTo(0),
									child: Container(
										height: 44,
										alignment: Alignment.center,
										child: Text('Bookings', style: TextStyle(color: _tabController.index == 0 ? Colors.white : (isDark ? Colors.white70 : Colors.black), fontWeight: FontWeight.w600)),
									),
								),
							),
							Expanded(
								child: InkWell(
									onTap: () => _tabController.animateTo(1),
									child: Container(
										height: 44,
										alignment: Alignment.center,
										child: Text('Vendors', style: TextStyle(color: _tabController.index == 1 ? Colors.white : (isDark ? Colors.white70 : Colors.black), fontWeight: FontWeight.w600)),
									),
								),
							),
						],
					),
				],
				),
			),
		);
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		// use explicit white/black for sections per requirement
		final isDark = Theme.of(context).brightness == Brightness.dark;
		final sectionBg = isDark ? Colors.black : Colors.white;

					return Scaffold(
						extendBody: true,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Manage', style: Theme.of(context).textTheme.titleLarge),
					backgroundColor: Theme.of(context).scaffoldBackgroundColor,
					elevation: 0,
					centerTitle: true,
					bottom: PreferredSize(
						preferredSize: const Size.fromHeight(72),
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
							child: _buildCustomToggle(context),
						),
					),
				),
			body: TabBarView(
				controller: _tabController,
				children: [
					// Bookings Tab
					Stack(
						children: [
															Padding(
																padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 24),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: [
												Text('Upcoming Bookings',
														style: Theme.of(context)
																.textTheme
																.titleMedium
																?.copyWith(fontWeight: FontWeight.bold)),
												EventouryElevatedButton(
													onPressed: () {
														_showFilter(context);
													},
													child: const Row(
														mainAxisSize: MainAxisSize.min,
														children: [
															Icon(Icons.filter_list, color: Colors.white),
															SizedBox(width: 8),
															Text('Filter')
														],
													),
												),
											],
										),
										const SizedBox(height: 12),
										Expanded(
											child: ListView.separated(
												itemCount: 6,
												separatorBuilder: (_, __) => const SizedBox(height: 12),
												itemBuilder: (context, index) {
													final status = index % 3 == 0
															? 'Confirmed'
															: index % 3 == 1
																	? 'Pending'
																	: 'Cancelled';
													return _buildBookingCard(context,
															userName: index % 2 == 0 ? 'Huzaifa Noor' : 'Jane Doe',
															destination: ['Maldives','Bali','Paris'][index % 3],
															date: '25 Aug 2025',
															status: status,
															bg: sectionBg);
												},
											),
										),
									],
								),
							),
							// Floating Action Button
															Positioned(
																right: 20,
																bottom: MediaQuery.of(context).padding.bottom + 24,
																child: FloatingActionButton(
																	heroTag: 'manage_fab',
																	backgroundColor: EventouryColors.tangerine,
																	onPressed: () {
																		// open quick add
																		_showAddBooking(context);
																	},
																	child: const Icon(Icons.add, color: Colors.white),
																),
							),
						],
					),

					// Vendors Tab
											Padding(
												padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 24),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text('Vendors',
										style: Theme.of(context)
												.textTheme
												.titleMedium
												?.copyWith(fontWeight: FontWeight.bold)),
								const SizedBox(height: 12),
								Expanded(
									child: ListView.separated(
										itemCount: 8,
										separatorBuilder: (_, __) => const SizedBox(height: 12),
										itemBuilder: (context, index) {
											final status = index % 3 == 0
													? 'Active'
													: index % 3 == 1
															? 'Inactive'
															: 'Blocked';
											return _buildVendorCard(context,
												name: 'Vendor ${index+1}',
												status: status,
												rating: 4.0 + (index % 5) * 0.1,
												bg: sectionBg,
											);
										},
									),
								),
							],
						),
					),
				],
			),
			// keep bottom padding so Admin bottom nav remains visible
		);
	}

	Widget _buildBookingCard(BuildContext context,
			{required String userName,
			required String destination,
			required String date,
			required String status,
			required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;
		Color statusColor;
		if (status == 'Confirmed') statusColor = Colors.green;
		else if (status == 'Pending') statusColor = EventouryColors.tangerine;
		else statusColor = Colors.red;

		return GestureDetector(
			onTap: () => _showBookingDetails(context, userName, destination, date, status),
			child: Container(
				padding: const EdgeInsets.all(14),
				decoration: BoxDecoration(
					color: bg,
					borderRadius: BorderRadius.circular(12),
					boxShadow: [
						BoxShadow(
							color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.06),
							blurRadius: 12,
							offset: const Offset(0,6),
						)
					],
				),
				child: Row(
					children: [
						CircleAvatar(
							radius: 26,
							backgroundColor: EventouryColors.tangerine.withOpacity(0.2),
							child: Text(userName.split(' ').map((e)=>e[0]).take(2).join(), style: const TextStyle(color: Colors.white)),
						),
						const SizedBox(width: 12),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(userName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
									const SizedBox(height: 4),
									Text(destination, style: Theme.of(context).textTheme.bodySmall),
									const SizedBox(height: 6),
									Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
								],
							),
						),
						Container(
							padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
							decoration: BoxDecoration(
								color: statusColor.withOpacity(0.15),
								borderRadius: BorderRadius.circular(20),
							),
							child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w600)),
						),
					],
				),
			),
		);
	}

	Widget _buildVendorCard(BuildContext context,
			{required String name, required String status, required double rating, required Color bg}) {
		final isDark = Theme.of(context).brightness == Brightness.dark;

			// choose badge colors with good contrast (white text on colored background)
			Color badgeColor;
			if (status == 'Active') {
				badgeColor = Colors.green;
			} else if (status == 'Inactive') {
				badgeColor = isDark ? Colors.grey[700]! : Colors.grey[500]!;
			} else {
				badgeColor = Colors.red;
			}

			return GestureDetector(
				onTap: () => _showVendorDetails(context, name, status, rating),
				child: Container(
					padding: const EdgeInsets.all(14),
					decoration: BoxDecoration(
						color: bg,
						borderRadius: BorderRadius.circular(12),
						boxShadow: [
							BoxShadow(
								color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.06),
								blurRadius: 12,
								offset: const Offset(0,6),
							)
						],
					),
					child: Row(
						children: [
							CircleAvatar(
								radius: 26,
								backgroundColor: EventouryColors.tangerine.withOpacity(0.15),
								child: Icon(Icons.storefront, color: EventouryColors.tangerine),
							),
							const SizedBox(width: 12),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
										const SizedBox(height: 6),
										Row(
											children: [
												Icon(Icons.star, color: EventouryColors.tangerine, size: 16),
												const SizedBox(width: 6),
												Text(rating.toStringAsFixed(1), style: Theme.of(context).textTheme.bodySmall),
											],
										),
									],
								),
							),
							Container(
								padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
								decoration: BoxDecoration(
									color: badgeColor,
									borderRadius: BorderRadius.circular(20),
									boxShadow: [
										BoxShadow(
											color: Colors.black.withOpacity(0.2),
											blurRadius: 6,
											offset: const Offset(0,2),
										),
									],
								),
								child: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
							),
						],
					),
				),
			);
	}

	void _showFilter(BuildContext context) {
		showModalBottomSheet(
			context: context,
			backgroundColor: Theme.of(context).cardColor,
			shape: const RoundedRectangleBorder(
				borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
			),
			builder: (_) {
				return Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text('Filters', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
							const SizedBox(height: 12),
							// placeholder filters
							const Text('Date range, Status, User'),
							const SizedBox(height: 16),
							Row(
								mainAxisAlignment: MainAxisAlignment.end,
								children: [
									EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Apply')),
								],
							),
						],
					),
				);
			},
		);
	}

	void _showAddBooking(BuildContext context) {
		showDialog(
			context: context,
			builder: (_) => AlertDialog(
				title: const Text('Add Booking'),
				content: const Text('Quick add booking or open full create screen.'),
				actions: [
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
				],
			),
		);
	}

	void _showBookingDetails(BuildContext context, String user, String dest, String date, String status) {
		showDialog(
			context: context,
			builder: (_) => AlertDialog(
				title: Text('$user — $dest'),
				content: Column(
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text('Date: $date'),
						const SizedBox(height: 8),
						Text('Status: $status'),
					],
				),
				actions: [
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Edit')),
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
				],
			),
		);
	}

	void _showVendorDetails(BuildContext context, String name, String status, double rating) {
		showDialog(
			context: context,
			builder: (_) => AlertDialog(
				title: Text(name),
				content: Column(
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text('Status: $status'),
						const SizedBox(height: 8),
						Row(children: [Icon(Icons.star, color: EventouryColors.tangerine), const SizedBox(width: 8), Text(rating.toStringAsFixed(1))]),
					],
				),
				actions: [
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Edit')),
					EventouryElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Deactivate')),
				],
			),
		);
	}
}
