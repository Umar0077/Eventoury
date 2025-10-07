import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../Admin_Bottom_Navigation_bar/Admin_bottom_navigation_bar.dart';
import '../Total_Booking_screen/total_booking_screen.dart';
import '../Revenue/Revenue_Admin.dart';
import '../Active_Vendors/active_vendors_Admin.dart';
import '../PendingPayments/pending_payments.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  void _onNavTap(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildOverview(context),
      const TotalBookingScreen(),
      const RevenueAdmin(),
      const ActiveVendorsAdmin(),
      const PendingPayments(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: AdminCustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: (idx) => _onNavTap(idx),
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildSummaryCards(context),
          const SizedBox(height: 32),
          _buildBookingTrends(context),
          const SizedBox(height: 32),
          _buildPopularDestinations(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        children: [
          Image.asset(
            isDark ? 'assets/app_logos/logo_5.png' : 'assets/app_logos/logo_4.png',
            height: 40,
          ),
          const SizedBox(height: 8),
          Text(
            'Admin Dashboard',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildSummaryCard(
          context,
          icon: Icons.calendar_month,
          value: '1,254',
          label: 'Total Bookings',
          onTap: () => _onNavTap(1),
        ),
        _buildSummaryCard(
          context,
          icon: Icons.account_balance_wallet,
          value: '\$2,340',
          label: 'Revenue This Month',
          onTap: () => _onNavTap(2),
        ),
        _buildSummaryCard(
          context,
          icon: Icons.people,
          value: '82',
          label: 'Active Vendors',
          onTap: () => _onNavTap(3),
        ),
        _buildSummaryCard(
          context,
          icon: Icons.pending_actions,
          value: '12',
          label: ' Pending Payments',
          onTap: () => _onNavTap(4),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    final shadowColor = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.08);

    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: EventouryColors.tangerine,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: EventouryColors.tangerine,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingTrends(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Trends',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Theme.of(context).cardColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: BookingTrendsChart(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Jan', style: TextStyle(fontSize: 12)),
                  Text('Feb', style: TextStyle(fontSize: 12)),
                  Text('Mar', style: TextStyle(fontSize: 12)),
                  Text('Apr', style: TextStyle(fontSize: 12)),
                  Text('May', style: TextStyle(fontSize: 12)),
                  Text('Jun', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '2025',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularDestinations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Destinations',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildDestinationCard(context, index + 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(BuildContext context, int destinationNumber) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    final shadowColor = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.08);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  '300 × 200',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Destination $destinationNumber',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '132 bookings',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingTrendsChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.purple.withOpacity(0.3),
          Colors.purple.withOpacity(0.1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final dataPoints = [800, 1200, 1800, 1600, 900, 1900];
    final maxValue = 2000.0;
    final stepWidth = size.width / (dataPoints.length - 1);

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepWidth;
      final y = size.height - (dataPoints[i] / maxValue * size.height);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

