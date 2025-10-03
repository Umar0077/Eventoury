import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VendorLayout(
      padding: const EdgeInsets.all(24.0),
      child: const VendorHomeContent(),
    );
  }
}

class VendorHomeContent extends StatelessWidget {
  const VendorHomeContent({super.key});

  Widget _statCard(BuildContext context, IconData icon, String title, String value, String subtitle) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06);

    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 1),
      ),
      // stronger elevation in light mode so cards lift off the white scaffold
      elevation: isDark ? 0.6 : 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Filled tangerine circle with white icon (matches provided image)
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: EventouryColors.tangerine,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: Center(
                child: Icon(icon, color: Colors.white, size: 26),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : theme.textTheme.bodyLarge?.color)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : (theme.textTheme.headlineSmall?.color ?? Colors.black))),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(fontSize: 13, color: isDark ? Colors.white54 : theme.textTheme.bodySmall?.color)),
          ],
        ),
      ),
    );
  }

  Widget _packagesCard(BuildContext context, IconData icon, String title, String value, String subtitle) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06);

    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: borderColor, width: 1)),
      // stronger elevation in light mode so cards lift off the white scaffold
      elevation: isDark ? 0.6 : 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(shape: BoxShape.circle, color: EventouryColors.tangerine),
              child: Center(child: Icon(icon, color: Colors.white, size: 24)),
            ),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : theme.textTheme.bodyLarge?.color)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : (theme.textTheme.headlineSmall?.color ?? Colors.black))),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : theme.textTheme.bodySmall?.color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final isNarrow = maxWidth < 900;

      return SingleChildScrollView(
        child: Stack(
          children: [
            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('Welcome back, Usama Travel Co.', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 20),

        // Stat cards grid - responsive column count
        GridView.count(
          crossAxisCount: isNarrow ? 1 : 2,
          shrinkWrap: true,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: isNarrow ? 3.4 : 3.2,
          children: [
              InkWell(
                onTap: () {
                  try {
                    // switch the shell to the Bookings tab (index 1)
                    final shellCtrl = Get.find<VendorShellController>();
                    shellCtrl.setIndex(1);
                  } catch (_) {
                    // fallback: do nothing if controller not available
                  }
                },
                child: _statCard(context, Icons.calendar_month_outlined, 'Bookings', '120', 'This Month'),
              ),
            InkWell(
              onTap: () {
                try {
                  final shellCtrl = Get.find<VendorShellController>();
                  shellCtrl.setIndex(2); // revenue tab
                } catch (_) {}
              },
              child: _statCard(context, Icons.bar_chart, 'Revenue', '\$64553', '+12% growth'),
            ),
            InkWell(
              onTap: () {
                try {
                  final shellCtrl = Get.find<VendorShellController>();
                  shellCtrl.setIndex(3);
                } catch (_) {}
              },
              child: _statCard(context, Icons.star_border, 'Reviews', '4.7', '230 reviews'),
            ),
            InkWell(
              onTap: () async {
                try {
                  final ctrl = Get.find<VendorShellController>();
                  ctrl.setIndex(6);
                  return;
                } catch (_) {}

                // fallback: ensure VendorShell exists then set the index
                await Get.offAllNamed('/Vendor');
                try {
                  final ctrl2 = Get.find<VendorShellController>();
                  ctrl2.setIndex(6);
                } catch (_) {}
              },
              child: _packagesCard(context, Icons.business_center, 'Packages', '15 Active', '2 New Added'),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Recent activity
        Text('Recent Activity', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // Recent activity list: fixed height on narrow screens, expanded on wide screens
        if (isNarrow)
          SizedBox(
            height: 320,
            child: ListView(
              children: [
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Booking #1245 - Daniyal Khan - \$4342', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('2 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Package Updated - "Hunza Trip Deluxe"', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('3 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Review Added - ★★★★★ by Mahaz Noor', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('4 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 320,
            child: ListView(
              children: [
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Booking #1245 - Daniyal Khan - \$4342', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('2 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Package Updated - "Hunza Trip Deluxe"', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('3 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.brightness == Brightness.dark ? Colors.transparent : theme.dividerColor.withOpacity(0.06))),
                  child: ListTile(
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle)),
                    title: Text('Review Added - ★★★★★ by Mahaz Noor', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    subtitle: Text('4 hours ago', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                  ),
                ),
              ],
            ),
          ),
      ],
                ),

                // Top-right avatar (matches provided screenshot)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 6.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: theme.cardColor,
                      child: Text('U', style: TextStyle(color: theme.primaryColor)),
                    ),
                  ),
                ),
              ],
            ),
      );
    });
  }
}
