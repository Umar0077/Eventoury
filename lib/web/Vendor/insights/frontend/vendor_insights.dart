import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class VendorInsights extends StatelessWidget {
  const VendorInsights({super.key});

  // helpers moved into VendorInsightsContent

  @override
  Widget build(BuildContext context) {
    return VendorLayout(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0),
      child: const VendorInsightsContent(),
    );
  }
}

class VendorInsightsContent extends StatelessWidget {
  const VendorInsightsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget statCard(String title, String value, {String? subtitle, Color? accent}) {
      // Return a plain container; callers should wrap with Expanded when used
      // inside a Row. This prevents accidentally placing Expanded inside a
      // shrink-wrapping Column (such as when the page is inside a
      // SingleChildScrollView).
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: isDark ? theme.cardColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.18) : Colors.black.withOpacity(0.06),
                blurRadius: isDark ? 6 : 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(value, style: theme.textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: accent ?? (isDark ? Colors.white : theme.textTheme.titleMedium?.color ?? Colors.black))),
              if (subtitle != null) ...[const SizedBox(height: 6), Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white54 : theme.textTheme.bodySmall?.color?.withOpacity(0.8)))]
            ],
          ),
        );
    }

  Widget chartCard(String title, Color start, Color end) {
      // smaller card with centered, thin rounded bars
  final bars = List.generate(14, (i) => ((i + 1) * 5.0) + ((i % 4) * 6.0));
  // make the chart cards a bit larger
  const double maxHeight = 140; // increased height for larger bars
  const double barWidth = 22; // wider bars
  const double spacing = 10; // slightly reduced spacing between bars

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(
              color: isDark ? start.withOpacity(0.06) : Colors.black.withOpacity(0.06),
              blurRadius: isDark ? 12 : 18,
              spreadRadius: isDark ? 2 : 6,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            // price then bars on the same row (bottom-aligned so the amount sits lower)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // price/value (now first)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${3455.65.toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.titleLarge?.color ?? Colors.black)),
                    const SizedBox(height: 6),
                    Text('Total', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white54 : theme.textTheme.bodySmall?.color?.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),

                const SizedBox(width: 12),

                // bars (take remaining space)
                Expanded(
                  child: SizedBox(
                    height: maxHeight,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: bars.map((h) {
                          final index = bars.indexOf(h);
                          final pct = (h / 80.0).clamp(0.05, 1.0);
                          final height = maxHeight * pct;
                          return Padding(
                            padding: EdgeInsets.only(right: index == bars.length - 1 ? 0 : spacing),
                            child: Container(
                              width: barWidth,
                              height: height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(barWidth),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [start.withOpacity(0.98 - index * 0.02), end.withOpacity(0.98 - index * 0.02)],
                                ),
                                boxShadow: [BoxShadow(color: end.withOpacity(0.16 - index * 0.01), blurRadius: 12, offset: const Offset(0, 6))],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget noticeRow(String text, {IconData? icon}) {
      return Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.18) : Colors.black.withOpacity(0.04), blurRadius: isDark ? 6 : 8, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            if (icon != null)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(color: EventouryColors.tangerine, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 16),
              )
            else
              const SizedBox.shrink(),
            if (icon != null) const SizedBox(width: 12),
            Expanded(child: Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
          ],
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 1000;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Insights Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              if (!isNarrow)
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
                    child: const Text('Yearly'),
                  ),
                ])
              else
                PopupMenuButton<String>(
                  itemBuilder: (_) => ['Daily', 'Weekly', 'Monthly', 'Yearly'].map((v) => PopupMenuItem(value: v, child: Text(v))).toList(),
                  child: OutlinedButton(onPressed: null, child: const Icon(Icons.more_vert)),
                )
            ],
          ),
          const SizedBox(height: 18),

          // Stats row: wrap into column on narrow screens
          if (isNarrow)
            Column(children: [
              statCard('Earnings 💰', '+\$12,345', accent: EventouryColors.tangerine),
              const SizedBox(height: 12),
              statCard('Bookings 📅', '150', accent: EventouryColors.tangerine),
              const SizedBox(height: 12),
              statCard('Ratings ⭐', '★ 4.0', accent: EventouryColors.tangerine),
              const SizedBox(height: 12),
              statCard('Revenue Growth 📈', '+15%', accent: EventouryColors.success),
            ])
          else
            Row(
              children: [
                Expanded(child: statCard('Earnings 💰', '+\$12,345', accent: EventouryColors.tangerine)),
                Expanded(child: statCard('Bookings 📅', '150', accent: EventouryColors.tangerine)),
                Expanded(child: statCard('Ratings ⭐', '★ 4.0', accent: EventouryColors.tangerine)),
                Expanded(child: statCard('Revenue Growth 📈', '+15%', accent: EventouryColors.success)),
              ],
            ),

          const SizedBox(height: 24),

          // Charts - stack on narrow
          if (isNarrow)
            Column(children: [
              chartCard('Earnings', const Color(0xFF6B8BFF), const Color(0xFF3B5BFF)),
              const SizedBox(height: 12),
              chartCard('Monthly Growth', const Color(0xFFFF8FB2), const Color(0xFFFF5E9E)),
            ])
          else
            Row(
              children: [
                Expanded(child: chartCard('Earnings', const Color(0xFF6B8BFF), const Color(0xFF3B5BFF))),
                const SizedBox(width: 48),
                Expanded(child: chartCard('Monthly Growth', const Color(0xFFFF8FB2), const Color(0xFFFF5E9E))),
              ],
            ),

          const SizedBox(height: 18),

  noticeRow('⚠️ High booking surge this week — Monitor your availability closely.'),
  noticeRow('📄 Pending payout requests — Review your earnings.'),
  noticeRow('📉 Customer ratings slightly dropped — Analyze customer feedback.'),

          const SizedBox(height: 18),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                  child: Text('Export Report'),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0), child: Text('View Details', style: theme.textTheme.bodyMedium)),
              ),
            ],
          ),

          const SizedBox(height: 40),
        ],
      );
    });
  }
}

