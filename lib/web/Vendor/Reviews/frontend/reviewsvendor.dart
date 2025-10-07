import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/Admin Mobile App/Admin Home Screens/Dashboard/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';
import 'package:eventoury/utils/constants/colors.dart';

class ReviewsVendorScreen extends StatelessWidget {
  const ReviewsVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VendorLayout(
      padding: const EdgeInsets.all(24.0),
      child: const ReviewsVendorContent(),
    );
  }
}

class ReviewsVendorContent extends StatefulWidget {
  const ReviewsVendorContent({super.key});

  @override
  State<ReviewsVendorContent> createState() => _ReviewsVendorContentState();
}

class _ReviewsVendorContentState extends State<ReviewsVendorContent> {
  // mock review data
  final List<Map<String, dynamic>> _reviews = [
    {'name': 'Mahaz Noor', 'days': 44, 'rating': 5, 'text': 'Great trip to Hunza!'},
    {'name': 'Ahmed', 'days': 7, 'rating': 5, 'text': 'Very well organized!'},
    {'name': 'Saarah', 'days': 14, 'rating': 4, 'text': 'Decent experience overall.'},
  ];

  int? _filterRating; // null = all
  bool _sortNewestFirst = true;

  double get _average {
    if (_reviews.isEmpty) return 0.0;
    final sum = _reviews.fold<int>(0, (s, r) => s + (r['rating'] as int));
    return sum / _reviews.length;
  }

  Map<int, int> get _distribution {
    final Map<int, int> d = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in _reviews) {
      d[r['rating'] as int] = (d[r['rating'] as int] ?? 0) + 1;
    }
    return d;
  }

  List<Map<String, dynamic>> get _visibleReviews {
    var list = _reviews.where((r) => _filterRating == null ? true : r['rating'] == _filterRating).toList();
    list.sort((a, b) => _sortNewestFirst ? (b['days'] as int).compareTo(a['days'] as int) : (a['days'] as int).compareTo(b['days'] as int));
    return list;
  }

  Widget _summaryCard(BuildContext context) {
    final total = _reviews.length;
    final avg = _average;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('${avg.toStringAsFixed(1)}/5', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.displaySmall?.color))),
            const SizedBox(height: 8),
            Center(child: Row(mainAxisSize: MainAxisSize.min, children: List.generate(5, (i) {
              final filled = i < avg.round();
              return Icon(Icons.star, color: filled ? EventouryColors.tangerine : (isDark ? Colors.white24 : Colors.grey.shade300), size: 26);
            }))),
            const SizedBox(height: 12),
            Center(child: Text('$total reviews', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
          ],
        ),
      ),
    );
  }

  Widget _breakdown(BuildContext context) {
    final dist = _distribution;
    final total = _reviews.isEmpty ? 1 : _reviews.length;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      children: List.generate(5, (i) {
        final rating = 5 - i;
        final count = dist[rating] ?? 0;
        final pct = count / total;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              SizedBox(width: 20, child: Text('$rating', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  children: [
                    Container(height: 12, decoration: BoxDecoration(color: isDark ? Colors.white10 : Colors.grey.shade200, borderRadius: BorderRadius.circular(8))),
                    FractionallySizedBox(widthFactor: pct, child: Container(height: 12, decoration: BoxDecoration(color: EventouryColors.tangerine, borderRadius: BorderRadius.circular(8)))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(width: 56, child: Text('$count', textAlign: TextAlign.right, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
            ],
          ),
        );
      }),
    );
  }

  Widget _reviewTile(Map<String, dynamic> r) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final name = r['name'] as String;
    final days = r['days'] as int;
    final rating = r['rating'] as int;
    final text = r['text'] as String;
    return Card(
      color: isDark ? theme.cardColor : Colors.white,
      elevation: isDark ? 0.6 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 18, backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300, child: Text(name[0].toUpperCase(), style: TextStyle(color: isDark ? Colors.white : Colors.black))),
                    const SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.bodyMedium?.color)),
                      const SizedBox(height: 4),
                      Text('$days days ago', style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
                    ])
                  ],
                ),
                // rating on the right
                Row(children: List.generate(5, (i) => Icon(i < rating ? Icons.star : Icons.star_border, color: EventouryColors.tangerine, size: 18))),
              ],
            ),
            const SizedBox(height: 12),
            Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color, fontSize: 15)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () { Get.snackbar('Reply', 'Reply action (mock)'); },
                style: OutlinedButton.styleFrom(backgroundColor: isDark ? theme.cardColor : Colors.white, side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)), foregroundColor: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                child: const Text('Reply'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                try {
                  final ctrl = Get.find<VendorShellController>();
                  ctrl.setIndex(0);
                } catch (e) {
                  // fallback: navigate to vendor shell then set index
                  Get.offAll(() => const AdminDashboard());
                  Future.delayed(const Duration(milliseconds: 150), () {
                    try {
                      final ctrl2 = Get.find<VendorShellController>();
                      ctrl2.setIndex(0);
                    } catch (_) {}
                  });
                }
              },
            ),
            const SizedBox(width: 8),
            Text('Reviews', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: Padding(padding: const EdgeInsets.only(top: 65.0), child: _summaryCard(context))),
            const SizedBox(width: 16),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter & Sort row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<int?>(
                        value: _filterRating,
                        hint: const Text('Filter by rating'),
                        dropdownColor: isDark ? theme.cardColor : Colors.white,
                        style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                        items: [null, 5, 4, 3, 2, 1].map((v) => DropdownMenuItem<int?>(value: v, child: Text(v == null ? 'All' : v.toString()))).toList(),
                        onChanged: (v) => setState(() => _filterRating = v),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _sortNewestFirst ? 'Newest' : 'Oldest',
                        dropdownColor: isDark ? theme.cardColor : Colors.white,
                        style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                        items: const [DropdownMenuItem(value: 'Newest', child: Text('Newest')), DropdownMenuItem(value: 'Oldest', child: Text('Oldest'))],
                        onChanged: (v) => setState(() => _sortNewestFirst = (v == 'Newest')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _breakdown(context),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // Reviews list
        Column(
          children: _visibleReviews.map((r) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _reviewTile(r))).toList(),
        ),
      ],
    );
  }
}
