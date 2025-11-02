import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/Details/frontend/Details.dart';

// Shared card decoration used in Hot Deals to match the shadow style used elsewhere.
BoxDecoration _sharedCardDecoration(ThemeData theme, {double radius = 16.0}) {
  final isDark = theme.brightness == Brightness.dark;
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.65) : Colors.black.withOpacity(0.12),
        blurRadius: 28,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.18) : Colors.black.withOpacity(0.03),
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

class AllHotDealsScreen extends StatefulWidget {
  const AllHotDealsScreen({super.key});

  @override
  State<AllHotDealsScreen> createState() => _AllHotDealsScreenState();
}

class _AllHotDealsScreenState extends State<AllHotDealsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    WebHomeController controller;
    try {
      controller = Get.find<WebHomeController>();
    } catch (_) {
      controller = Get.put(WebHomeController());
    }

    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
  final isDesktop = screenWidth > 1200;
  final isTablet = screenWidth > 768 && screenWidth <= 1200;

    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopBarWidget(activeItem: 'Hot Deals'),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme, screenWidth),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),

                  // Filters / quick actions
                  _buildFiltersSection(theme, screenWidth),
                  SizedBox(height: isDesktop ? 28 : isTablet ? 20 : 16),

                  // Deals grid
                  Obx(() => _buildDealsGrid(controller, theme, screenWidth)),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),

                  // Extra bottom spacing so content doesn't butt against the footer
                  SizedBox(height: isDesktop ? 60 : isTablet ? 50 : 36),
                ],
              ),
            ),
          ),

          // Footer pinned at the bottom of the viewport to avoid overflow
          const BottomBarWidget(),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final chipPadding = isDesktop ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 0);

  final filters = ['All', 'Beaches', 'Mountains', 'City', 'Popular', 'Budget', 'Luxury'];

    return StatefulBuilder(builder: (context, setStateLocal) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: filters.map((f) {
          final isSelected = _selectedFilter == f;
          return Padding(
            padding: chipPadding,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = f;
                });
                setStateLocal(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? EventouryColors.tangerine : (theme.brightness == Brightness.dark ? theme.cardColor : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? EventouryColors.tangerine : (theme.brightness == Brightness.dark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06))),
                  boxShadow: theme.brightness == Brightness.dark
                      ? [
                          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 4)),
                        ]
                      : [
                          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6)),
                        ],
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  // Popular section removed per request.

  Widget _buildHeader(ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color, size: isDesktop ? 24 : 20),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hot Deals', style: TextStyle(fontSize: isDesktop ? 32 : isTablet ? 28 : 24, fontWeight: FontWeight.bold, color: theme.textTheme.headlineLarge?.color)),
            const SizedBox(height: 8),
            Text('All Hot Deals', style: TextStyle(fontSize: isDesktop ? 18 : isTablet ? 16 : 14, color: theme.textTheme.bodyLarge?.color)),
          ],
        ),
      ],
    );
  }

  Widget _buildDealsGrid(WebHomeController controller, ThemeData theme, double screenWidth) {
  final isDesktop = screenWidth >= 1200;
  final isMobile = screenWidth <= 768;
    // compute filtered list according to the selected filter
    List<Map<String, dynamic>> filtered = controller.hotDeals.where((d) {
      final title = (d['title'] ?? '').toString().toLowerCase();
      final beach = (d['beach'] ?? '').toString().toLowerCase();
      final rating = (d['rating'] is num) ? (d['rating'] as num).toDouble() : double.tryParse(d['rating'].toString()) ?? 0.0;
      switch (_selectedFilter) {
        case 'All':
          return true;
        case 'Beaches':
          return beach.contains('beach') || title.contains('beach');
        case 'Mountains':
          return beach.contains('mountain') || title.contains('mountain');
        case 'City':
          return beach.contains('city') || title.contains('city');
        case 'Popular':
          return rating >= 4.6;
        case 'Budget':
          return rating < 4.5;
        case 'Luxury':
          return rating >= 4.7;
        default:
          return true;
      }
    }).toList();

    if (filtered.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('No deals found for "$_selectedFilter"', style: theme.textTheme.bodyLarge)),
      );
    }

    if (isMobile) {
      return Column(
        children: List.generate(filtered.length, (index) {
          final deal = filtered[index];
          return Container(margin: const EdgeInsets.only(bottom: 20), child: _buildDealCard(deal, index, controller, theme, true));
        }),
      );
    }

    // desktop & tablet: grid
    final crossAxisCount = isDesktop ? 3 : 2;
    final spacing = isDesktop ? 24.0 : 20.0;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        // Slightly taller cards on desktop to avoid small overflow issues
        childAspectRatio: isDesktop ? 1.45 : 1.3,
      ),
      itemBuilder: (context, index) {
        final deal = filtered[index];
        return _buildDealCard(deal, index, controller, theme, false);
      },
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal, int index, WebHomeController controller, ThemeData theme, bool isMobile) {
    // Reuse styling from WebHomeScreen's deal card
    final bool isDark = theme.brightness == Brightness.dark;
    final Color cardBg = isDark ? const Color(0xFF2D2D2D) : Colors.white;
    final Color contentText = isDark ? Colors.white : Colors.black;
    final Color contentSubText = isDark ? Colors.white70 : Colors.black54;

  // Shadows are provided by _sharedCardDecoration now.

    return InkWell(
      onTap: () => Get.to(() => DetailsScreen(title: deal['title'] ?? '', location: deal['location'] ?? '', rating: (deal['rating'] is num) ? (deal['rating'] as num).toDouble() : 0.0)),
      child: Container(
        decoration: _sharedCardDecoration(theme, radius: 20),
        child: Card(
          color: cardBg,
          elevation: 6,
          shadowColor: isDark ? Colors.black : Colors.black.withOpacity(0.08),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: isMobile ? 180 : 200,
              decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), image: DecorationImage(image: AssetImage(deal['image']), fit: BoxFit.cover)),
              child: Stack(children: [
                Container(decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.3)]))),
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () => controller.toggleFavorite(index),
                    child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)]), child: Icon(deal['isFavorite'] ? Icons.favorite : Icons.favorite_border, color: deal['isFavorite'] ? Colors.red : Colors.grey, size: 20)),
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              decoration: BoxDecoration(color: cardBg, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(deal['title'], style: TextStyle(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: contentText)),
                const SizedBox(height: 8),
                Row(children: [
                  Flexible(child: Text('${deal['beach']} • ', style: TextStyle(fontSize: 14, color: contentSubText), overflow: TextOverflow.ellipsis)),
                  if (deal['wifi']) Text('Free WiFi', style: TextStyle(fontSize: 14, color: contentSubText)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  ...List.generate(5, (starIndex) => Icon(starIndex < deal['rating'].floor() ? Icons.star : Icons.star_border, color: Colors.amber, size: 16)),
                  const SizedBox(width: 8),
                  Flexible(child: Text(deal['rating'].toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: contentText), overflow: TextOverflow.ellipsis)),
                ]),
                const SizedBox(height: 12),
                Row(children: [Icon(Icons.location_on, color: contentSubText, size: 16), const SizedBox(width: 4), Flexible(child: Text(deal['location'], style: TextStyle(fontSize: 14, color: contentSubText), overflow: TextOverflow.ellipsis))]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
