import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class VendorInsightPage extends StatelessWidget {
  const VendorInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Insights Dashboard',
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                ),
                SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    _FilterButton(label: 'Daily'),
                    _FilterButton(label: 'Weekly'),
                    _FilterButton(label: 'Monthly'),
                    _FilterButton(label: 'Yearly'),
                  ],
                ),
                SizedBox(height: 24),
                _InfoCard(title: 'Earnings', value: '+\$12,345', icon: Icons.attach_money, color: EventouryColors.tangerine,),
                _InfoCard(title: 'Bookings', value: '150', icon: Icons.calendar_today, color: EventouryColors.tangerine, ),
                _InfoCard(title: 'Ratings', value: '4.0', icon: Icons.star, color: Colors.amber, showStars: true),
                _InfoCard(title: 'Revenue Growth', value: '+15%', icon: Icons.show_chart, color: Colors.green,),
                SizedBox(height: 24),
                _ChartCard(title: 'Earnings', value: '3455.65', color: EventouryColors.persimmon),
                _ChartCard(title: 'Monthly Growth', value: '2354.32', color: EventouryColors.persimmon),
                SizedBox(height: 24),
                _AlertCard(
                  icon: Icons.warning_amber_rounded,
                  title: 'High booking surge this week',
                  subtitle: 'Monitor your availability closely.',
                  color: Colors.orange,
                ),
                _AlertCard(
                  icon: Icons.payments_outlined,
                  title: 'Pending payout requests',
                  subtitle: 'Review your earnings.',
                  color: Colors.green,
                ),
                _AlertCard(
                  icon: Icons.trending_down,
                  title: 'Customer ratings slightly dropped',
                  subtitle: 'Analyze customer feedback.',
                  color: Colors.red,
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: EventouryElevatedButton(
                        onPressed: () {},
                        child: Text('Export Report'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: EventouryColors.persimmon,
                            )
                          ),
                        ),
                        onPressed: () {},
                        child: Text('View Details', style: Theme.of(context).textTheme.bodyMedium,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  const _FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      child: Center(child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),)),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool showStars;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.showStars = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(width: 6),
              ],
            ),
            SizedBox(height: 8),
            showStars
                ? Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_border, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  )
                : Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _ChartCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(8, (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 20.0 + (index * 8),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _AlertCard({required this.icon, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color:Colors.grey  , fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
