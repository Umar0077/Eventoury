import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/Admin Mobile App/Admin Home Screens/Dashboard/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';
import 'dart:math';

class RevenueVendorScreen extends StatelessWidget {
  const RevenueVendorScreen({super.key});

  Widget _topStat(BuildContext context, String title, String value, String subtitle) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : theme.textTheme.bodyLarge?.color)),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.headlineSmall?.color)),
            const SizedBox(height: 6),
            Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color)),
          ],
        ),
      ),
    );
  }

  Widget _lineChart(BuildContext context) {
    // generate mock points
    final values = List.generate(30, (i) => 2000 + (i % 6) * 600 + (i.isEven ? 200 : -200));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final lineColor = isDark ? Colors.white.withOpacity(0.95) : (theme.textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.9);
    final gridColor = isDark ? Colors.white10 : Colors.black12;
    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _SimpleLineChartPainter(values: values.map((e) => e.toDouble()).toList(), lineColor: lineColor, gridColor: gridColor),
            child: Container(),
          ),
        ),
      ),
    );
  }

  Widget _donutChart(BuildContext context) {
    // mock segments
    final segments = [35.0, 25.0, 20.0, 20.0];
    final colors = [Colors.grey.shade800, Colors.grey.shade500, Colors.orange, Colors.black87];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 200,
          child: Center(
            child: CustomPaint(
              size: const Size(160, 160),
              painter: _SimpleDonutPainter(values: segments, colors: colors),
            ),
          ),
        ),
      ),
    );
  }

  Widget _recentBookings(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rows = [
      ['Booking #1245', 'Daniyal Khan', '\$4,342', 'Completed'],
      ['Booking #1244', 'Anaya Noor', '\$1,750', 'Completed'],
      ['Booking #1243', 'Ahmed Raza', '\$4,980', 'Completed'],
      ['Booking #1242', 'Hoorain Ali', '\$4,500', 'Completed'],
    ];

    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Bookings', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : theme.textTheme.titleMedium?.color)),
            const SizedBox(height: 12),
            ...rows.map((r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: isDark ? Colors.white70 : Colors.black87, shape: BoxShape.circle)),
                      const SizedBox(width: 12),
                      Expanded(child: Text('${r[0]} - ${r[1]}', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
                      SizedBox(width: 110, child: Text(r[2], textAlign: TextAlign.right, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
                      const SizedBox(width: 24),
                      Text(r[3], style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return VendorLayout(
      padding: const EdgeInsets.all(24.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isNarrow = maxWidth < 1000;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                IconButton(onPressed: () async {
                  try {
                    final ctrl = Get.find<VendorShellController>();
                    ctrl.setIndex(0);
                  } catch (_) {
                    Get.offAll(() => const AdminDashboard());
                    try {
                      final ctrl2 = Get.find<VendorShellController>();
                      ctrl2.setIndex(0);
                    } catch (_) {}
                  }
                }, icon: const Icon(Icons.arrow_back)),
                Text('Revenue', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              ]),
              Row(children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                  child: const Text('Daily'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                  child: const Text('Weekly'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                  child: const Text('Monthly'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                  child: const Text('Date Range'),
                ),
              ])
            ]),
            const SizedBox(height: 18),

            // Top stats - stack vertically on narrow screens
            if (isNarrow)
              Column(
                children: [
                  _topStat(context, 'Total Revenue', '\$80,500', 'This Month'),
                  const SizedBox(height: 12),
                  _topStat(context, 'Growth', '+15 %', 'Date Range'),
                  const SizedBox(height: 12),
                  _topStat(context, 'Average Revenue', '\$688', 'Per Booking'),
                  const SizedBox(height: 12),
                  _topStat(context, 'Highest earning Package', 'City Tour', ''),
                ],
              )
            else
              Row(children: [
                Expanded(child: _topStat(context, 'Total Revenue', '\$80,500', 'This Month')),
                const SizedBox(width: 12),
                Expanded(child: _topStat(context, 'Growth', '+15 %', 'Date Range')),
                const SizedBox(width: 12),
                Expanded(child: _topStat(context, 'Average Revenue', '\$688', 'Per Booking')),
                const SizedBox(width: 12),
                Expanded(child: _topStat(context, 'Highest earning Package', 'City Tour', '')),
              ]),

            const SizedBox(height: 16),

            // Charts row - stack on narrow screens and reduce height
            if (isNarrow)
              Column(children: [
                SizedBox(height: 220, child: _lineChart(context)),
                const SizedBox(height: 12),
                SizedBox(height: 220, child: _donutChart(context)),
              ])
            else
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 3, child: _lineChart(context)),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: _donutChart(context)),
              ]),

            const SizedBox(height: 16),

            // Recent bookings
            _recentBookings(context),
          ],
        );
      }),
    );
  }
}

/// A thin wrapper used by the VendorShell IndexedStack so the revenue page can
/// be shown as one of the persistent shell children (keeps sidebar visible).
class RevenueVendorContent extends StatelessWidget {
  const RevenueVendorContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const RevenueVendorScreen();
  }
}

// Simple line chart painter for mock data
class _SimpleLineChartPainter extends CustomPainter {
  final List<double> values;
  final Color lineColor;
  final Color gridColor;
  _SimpleLineChartPainter({required this.values, required this.lineColor, required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
  final paint = Paint()..color = lineColor..strokeWidth = 2.5..style = PaintingStyle.stroke;
  final gridPaint = Paint()..color = gridColor..strokeWidth = 1;

    final max = values.reduce((a, b) => a > b ? a : b);
    final min = values.reduce((a, b) => a < b ? a : b);

    // draw simple horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height - (i / 4) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final x = (i / (values.length - 1)) * size.width;
      final y = size.height - ((values[i] - min) / (max - min)) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple donut painter for mock segments
class _SimpleDonutPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  _SimpleDonutPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold(0.0, (a, b) => a + b);
    final rect = Offset.zero & size;
    double startRadian = -pi / 2;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 32.0..strokeCap = StrokeCap.butt;

    for (int i = 0; i < values.length; i++) {
      final sweep = (values[i] / total) * 2 * pi;
      paint.color = colors[i % colors.length];
      canvas.drawArc(rect.deflate(16), startRadian, sweep, false, paint);
      startRadian += sweep;
    }

    // draw center circle to make it a donut
    final centerPaint = Paint()..color = Colors.black87;
    canvas.drawCircle(rect.center, size.width * 0.18, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
