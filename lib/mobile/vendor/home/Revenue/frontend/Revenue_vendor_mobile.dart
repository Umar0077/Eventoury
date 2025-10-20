import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/revenue_vendor_controller.dart';

class RevenueVendorMobile extends StatelessWidget {
	RevenueVendorMobile({Key? key}) : super(key: key);

	final RevenueVendorController controller = Get.put(RevenueVendorController());

	@override
	Widget build(BuildContext context) {
			final theme = Theme.of(context);
			final isDark = theme.brightness == Brightness.dark;

		return SafeArea(
			child: Obx(() {
				if (controller.isLoading.value) {
					return const Center(child: CircularProgressIndicator());
				}

				return Scaffold(
					appBar: AppBar(
						leading: IconButton(
							icon: const Icon(Icons.arrow_back),
							onPressed: () => Navigator.of(context).maybePop(),
						),
						title: const Text('Revenue'),
						centerTitle: true,
						actions: [
							IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_today_outlined)),
						],
						elevation: 0,
					),
					body: SingleChildScrollView(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								// Filters
								SizedBox(
									height: 44,
									child: ListView(
										scrollDirection: Axis.horizontal,
										children: ['Daily', 'Weekly', 'Monthly', 'Date Range']
												.map((f) => Padding(
															padding: const EdgeInsets.only(right: 8.0),
															child: _FilterButton(
																label: f,
																active: controller.selectedFilter.value == f,
																onTap: () => controller.setFilter(f),
															),
														))
												.toList(),
									),
								),

								const SizedBox(height: 8),

								// KPI cards (stacked)
								_KpiCard(
									title: 'Total Revenue',
									value: '\$${controller.totalRevenue.value.toString()}',
									subtitle: 'This Month',
									onTap: () => _openDetail(context, 'Total Revenue', 'Detailed breakdown for Total Revenue'),
								),
								const SizedBox(height: 8),
								_KpiCard(
									title: 'Growth',
									value: '+${controller.growthPercent.value}%',
									subtitle: 'Date Range',
									onTap: () => _openDetail(context, 'Growth', 'Detailed breakdown for Growth'),
								),
								const SizedBox(height: 8),
								_KpiCard(
									title: 'Average Revenue',
									value: '\$${controller.averageRevenue.value}',
									subtitle: 'Per Booking',
									onTap: () => _openDetail(context, 'Average Revenue', 'Detailed breakdown for Average Revenue'),
								),
								const SizedBox(height: 8),
								_KpiCard(
									title: 'Highest Earning Package',
									value: controller.topPackage.value,
									subtitle: '',
									onTap: () => _openDetail(context, 'Top Package', '${controller.topPackage.value} details'),
								),

								const SizedBox(height: 12),

								// Charts
								SizedBox(
									width: double.infinity,
									height: 220,
									child: Card(
										color: isDark ? Colors.black : Colors.white,
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
										elevation: 3,
										shadowColor: Colors.black26,
										child: Padding(
											padding: const EdgeInsets.all(12.0),
											child: CustomPaint(
												painter: _SimpleLineChartPainter(
														values: controller.lineChartPoints.toList(),
														lineColor: isDark ? Colors.white70 : Colors.black87,
														gridColor: isDark ? Colors.white10 : Colors.black12),
												child: Container(),
											),
										),
									),
								),

								const SizedBox(height: 8),

								SizedBox(
									width: double.infinity,
									height: 200,
									child: Card(
										color: isDark ? Colors.black : Colors.white,
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
										elevation: 3,
										shadowColor: Colors.black26,
										child: Padding(
											padding: const EdgeInsets.all(12.0),
											child: Center(
												child: GestureDetector(
													onTapDown: (d) {
														// for simplicity, show full donut legend
														showModalBottomSheet(
																context: context,
																builder: (_) {
																	return _DonutLegend(segments: controller.donutSegments.toList());
																});
													},
													child: CustomPaint(
														size: const Size(160, 160),
														painter: _SimpleDonutPainter(
															values: controller.donutSegments.map((e) => (e['value'] as double)).toList(),
															colors: [
																EventouryColors.tangerine,
																EventouryColors.persimmon,
																EventouryColors.electric_orange,
																Colors.grey.shade500,
															],
														),
													),
												),
											),
										),
									),
								),

								const SizedBox(height: 12),

								Text('Recent Bookings', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
								const SizedBox(height: 8),
								ListView.separated(
									shrinkWrap: true,
									physics: const NeverScrollableScrollPhysics(),
									itemCount: controller.recentBookings.length,
									separatorBuilder: (_, __) => const SizedBox(height: 8),
									itemBuilder: (context, idx) {
										final b = controller.recentBookings[idx];
										return Card(
											color: isDark ? Colors.black : Colors.white,
											shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
											elevation: 2,
											shadowColor: Colors.black26,
											child: ListTile(
												title: Text('Booking #${b['id']} - ${b['name']}', style: theme.textTheme.bodyLarge),
												subtitle: Text(b['amount'] ?? '', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
												trailing: Container(
													padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
													decoration: BoxDecoration(
														color: Colors.green.shade600.withOpacity(0.12),
														borderRadius: BorderRadius.circular(8),
													),
													child: Text(b['status'] ?? '', style: theme.textTheme.bodySmall?.copyWith(color: Colors.green.shade600)),
												),
												onTap: () => _openBookingDetail(context, b),
											),
										);
									},
								),
								const SizedBox(height: 16),
							],
						),
					),
				);
			}),
		);
	}

	void _openDetail(BuildContext context, String title, String body) {
		showModalBottomSheet(
				context: context,
				isScrollControlled: true,
				builder: (_) {
					return Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
							Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
							const SizedBox(height: 12),
							Text(body),
							const SizedBox(height: 12),
							ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
						]),
					);
				});
	}

	void _openBookingDetail(BuildContext context, Map<String, String> b) {
		showModalBottomSheet(context: context, builder: (_) {
			return Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
					Text('Booking #${b['id']}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 8),
					Text('Name: ${b['name']}'),
					const SizedBox(height: 4),
					Text('Amount: ${b['amount']}'),
					const SizedBox(height: 8),
					ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
				]),
			);
		});
	}
}

class _FilterButton extends StatelessWidget {
	final String label;
	final bool active;
	final VoidCallback onTap;

	const _FilterButton({required this.label, required this.active, required this.onTap});

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		final isDark = theme.brightness == Brightness.dark;
		final bgColor = active ? EventouryColors.tangerine : (isDark ? Colors.black : Colors.white);
		final textColor = active ? Colors.white : (isDark ? Colors.white : Colors.black);

		return InkWell(
			onTap: onTap,
			borderRadius: BorderRadius.circular(10),
			child: Container(
				padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
				decoration: BoxDecoration(
					color: bgColor,
					borderRadius: BorderRadius.circular(10),
					boxShadow: [
						BoxShadow(
							color: isDark ? Colors.black54 : Colors.black12,
							offset: const Offset(0, 2),
							blurRadius: 6,
						),
					],
				),
				child: Text(label, style: TextStyle(color: textColor)),
			),
		);
	}
}

class _KpiCard extends StatelessWidget {
	final String title;
	final String value;
	final String subtitle;
	final VoidCallback onTap;

	const _KpiCard({required this.title, required this.value, required this.subtitle, required this.onTap});

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		final isDark = theme.brightness == Brightness.dark;
				return GestureDetector(
					onTap: onTap,
					child: SizedBox(
						width: double.infinity,
						child: Card(
							color: isDark ? Colors.black : Colors.white,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
							elevation: 3,
							shadowColor: Colors.black26,
							child: Padding(
								padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
									Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : theme.textTheme.bodyLarge?.color)),
									const SizedBox(height: 6),
									Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
									if (subtitle.isNotEmpty) ...[
										const SizedBox(height: 6),
										Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
									]
								]),
							),
						),
					),
					);
	}
}

class _DonutLegend extends StatelessWidget {
	final List<Map<String, dynamic>> segments;
	const _DonutLegend({required this.segments});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(16.0),
			child: Column(mainAxisSize: MainAxisSize.min, children: [
				Text('Revenue by Package', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
				const SizedBox(height: 12),
				...segments.map((s) => Padding(
							padding: const EdgeInsets.symmetric(vertical: 6.0),
							child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
								Text(s['label'] ?? ''),
								Text('\$${(s['value'] as double).toStringAsFixed(0)}'),
							]),
						))
			]),
		);
	}
}

// Reuse painters similar to web vendor for small mobile charts
class _SimpleLineChartPainter extends CustomPainter {
	final List<double> values;
	final Color lineColor;
	final Color gridColor;
	_SimpleLineChartPainter({required this.values, required this.lineColor, required this.gridColor});

	@override
	void paint(Canvas canvas, Size size) {
		final paint = Paint()..color = lineColor..strokeWidth = 2.5..style = PaintingStyle.stroke;
		final gridPaint = Paint()..color = gridColor..strokeWidth = 1;

		if (values.isEmpty) return;

		final max = values.reduce((a, b) => a > b ? a : b);
		final min = values.reduce((a, b) => a < b ? a : b);

		for (int i = 0; i <= 4; i++) {
			final y = size.height - (i / 4) * size.height;
			canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
		}

		final path = Path();
		for (int i = 0; i < values.length; i++) {
			final x = (i / (values.length - 1)) * size.width;
			final y = size.height - ((values[i] - min) / (max - min)) * size.height;
			if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
		}

		canvas.drawPath(path, paint);
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SimpleDonutPainter extends CustomPainter {
	final List<double> values;
	final List<Color> colors;
	_SimpleDonutPainter({required this.values, required this.colors});

	@override
	void paint(Canvas canvas, Size size) {
		final total = values.fold(0.0, (a, b) => a + b);
		final rect = Offset.zero & size;
		double startRadian = -3.14 / 2;
		final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 28.0..strokeCap = StrokeCap.butt;

		for (int i = 0; i < values.length; i++) {
			final sweep = total == 0 ? 0.0 : (values[i] / total) * 2 * 3.1415926535;
			paint.color = colors[i % colors.length];
			canvas.drawArc(rect.deflate(14), startRadian, sweep, false, paint);
			startRadian += sweep;
		}

		final centerPaint = Paint()..color = Theme.of(Get.context!).brightness == Brightness.dark ? Colors.black87 : Colors.white;
		canvas.drawCircle(rect.center, size.width * 0.2, centerPaint);
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

