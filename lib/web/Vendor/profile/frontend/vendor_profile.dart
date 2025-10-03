import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class VendorProfile extends StatelessWidget {
  const VendorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return VendorLayout(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0),
      child: const VendorProfileContent(),
    );
  }
}

class VendorProfileContent extends StatelessWidget {
  const VendorProfileContent({super.key});

  Widget _statBox(BuildContext context, String value, String label, {Widget? trailing, double? width}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SizedBox(
      width: width ?? 300,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.04), blurRadius: isDark ? 6 : 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.titleMedium?.color)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (trailing != null) trailing,
                Flexible(child: Text(label, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color?.withOpacity(0.8))))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String title, String value, {VoidCallback? onEdit}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
        boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.03), blurRadius: isDark ? 6 : 6, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color?.withOpacity(0.8))),
                const SizedBox(height: 6),
                Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : theme.textTheme.bodyLarge?.color)),
              ],
            ),
          ),
          if (onEdit != null)
            InkWell(
              onTap: onEdit,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.edit, color: EventouryColors.tangerine),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
    // navigate back to public home
    try {
      Get.offAllNamed('/WebHomeScreen');
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 900;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            // Avatar
            CircleAvatar(
              radius: isNarrow ? 36 : 48,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text('Ahmed Travels & Tours', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Verified Vendor • Travel & Transport', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color?.withOpacity(0.8))),
            const SizedBox(height: 18),

            // Stats row (responsive & centered)
            LayoutBuilder(builder: (context, constraints) {
              final available = constraints.maxWidth;
              if (isNarrow) {
                return Column(
                  children: [
                    _statBox(context, '120', 'Bookings', width: double.infinity),
                    const SizedBox(height: 12),
                    _statBox(context, '★ 4.8', 'Reviews', trailing: const SizedBox.shrink(), width: double.infinity),
                    const SizedBox(height: 12),
                    _statBox(context, '560', 'Followers', width: double.infinity),
                  ],
                );
              }
              // compute a box width: fit three boxes with gaps, cap at 380
              final gapTotal = 40.0; // two gaps of 20
              final boxWidth = math.min((available - gapTotal) / 3, 380.0);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _statBox(context, '120', 'Bookings', width: boxWidth),
                  const SizedBox(width: 20),
                  _statBox(context, '★ 4.8', 'Reviews', trailing: const SizedBox.shrink(), width: boxWidth),
                  const SizedBox(width: 20),
                  _statBox(context, '560', 'Followers', width: boxWidth),
                ],
              );
            }),

            const SizedBox(height: 18),

            // Info fields (use full available width)
            LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _infoRow(context, 'Business Name', 'Ahmed Tours Pvt Ltd.', onEdit: () {}),
                      _infoRow(context, 'Email', 'ahmed@example.com', onEdit: () {}),
                      _infoRow(context, 'Phone', '+92 321 567890', onEdit: () {}),
                      _infoRow(context, 'Address', 'Karachi, Pakistan', onEdit: () {}),
                      _infoRow(context, 'Service Type', 'Travel Agency', onEdit: () {}),

                      // Logout button
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 18),
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(colors: [EventouryColors.tangerine, Color(0xFFFF7A24)]),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _signOut,
                            borderRadius: BorderRadius.circular(8),
                            child: Center(
                              child: Text('Logout', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),

                      // Security
                      const SizedBox(height: 6),
                      Text('Security', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? theme.cardColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
                          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.03), blurRadius: isDark ? 6 : 6, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Two-Factor Authentication', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : theme.textTheme.bodyLarge?.color)),
                                    const SizedBox(height: 6),
                                    Text('Enable', style: theme.textTheme.bodySmall?.copyWith(color: EventouryColors.tangerine)),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine),
                                  child: const Text('Enable'),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('Login History', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color?.withOpacity(0.8)) ),
                            const SizedBox(height: 6),
                            Text('Last login: 12 Sept, 10:30 AM on Device XYZ', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),
                      Text('Support', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? theme.cardColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
                          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.03), blurRadius: isDark ? 6 : 6, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Support', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodySmall?.color)),
                            const SizedBox(height: 6),
                            InkWell(onTap: () {}, child: Text('Chat / Email', style: TextStyle(color: EventouryColors.tangerine))),
                            const SizedBox(height: 12),
                            Text('Report an Issue', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodySmall?.color)),
                            const SizedBox(height: 6),
                            InkWell(onTap: () {}, child: Text('Report', style: TextStyle(color: EventouryColors.tangerine))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      );
    });
  }
}

