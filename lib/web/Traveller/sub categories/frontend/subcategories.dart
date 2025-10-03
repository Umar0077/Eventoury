import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/top%20and%20Bottom%20bar/top%20bar%20web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:eventoury/web/Traveller/sub%20categories/backend/subcategories_controller.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class SubcategoriesScreen extends StatelessWidget {
  final String categoryTitle;

  const SubcategoriesScreen({super.key, this.categoryTitle = 'Event'});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubcategoriesController());
    controller.categoryTitle.value = categoryTitle;
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
          TopBarWidget(onMenuToggle: controller.toggleMobileMenu, isMobileMenuOpen: controller.isMobileMenuOpen),

          if (screenWidth <= 768)
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: controller.isMobileMenuOpen.value ? null : 0,
                  child: controller.isMobileMenuOpen.value ? _buildMobileMenu(theme, controller) : const SizedBox.shrink(),
                )),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, theme, screenWidth, controller),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
                  _buildEventsGrid(controller, theme, screenWidth),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsGrid(SubcategoriesController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    int crossAxisCount = isDesktop ? 3 : isTablet ? 2 : 1;
    double spacing = isDesktop ? 24 : isTablet ? 20 : 16;

  return Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: isDesktop ? 1.1 : isTablet ? 1.0 : 1.3,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: controller.events.length,
            itemBuilder: (context, index) {
            final event = controller.events[index];
            return _buildEventCard(event, index, controller, theme, screenWidth);
          },
        ));
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, double screenWidth, SubcategoriesController controller) {
    return Row(
      children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: theme.iconTheme.color)),
        const SizedBox(width: 12),
        Text(controller.categoryTitle.value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildMobileMenu(ThemeData theme, SubcategoriesController controller) {
    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(onPressed: () {}, child: const Text('Home')),
        TextButton(onPressed: () {}, child: const Text('Profile')),
        TextButton(onPressed: () {}, child: const Text('Settings')),
      ]),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, int index, SubcategoriesController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    // Wrapped in a container with layered shadows for a stronger 3D effect
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 12)),
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 6)),
        ],
      ),
      child: Card(
        color: theme.scaffoldBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: isDesktop ? 320 : isTablet ? 300 : 260),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(height: isDesktop ? 180 : isTablet ? 160 : 140, width: double.infinity, child: Image.asset(event['image'], fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isDesktop ? 18 : isTablet ? 16 : 14, vertical: isDesktop ? 16 : isTablet ? 14 : 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      event['title'],
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, fontSize: isDesktop ? 22 : isTablet ? 20 : 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event['subtitle'],
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.9), fontSize: isDesktop ? 15 : isTablet ? 14 : 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      ...List.generate(5, (i) => Icon(i < (event['rating'] as double).floor() ? Icons.star : Icons.star_border, color: Colors.amber, size: isDesktop ? 18 : 16)),
                      const SizedBox(width: 8),
                      Text((event['rating'] as double).toString(), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: isDesktop ? 15 : 14)),
                    ]),
                    SizedBox(height: isDesktop ? 56 : isTablet ? 52 : 48), // space for positioned button
                  ]),
                ),
              ],
            ),

            Positioned(
              bottom: isDesktop ? 12 : isTablet ? 12 : 10,
              right: isDesktop ? 16 : isTablet ? 14 : 12,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: isDesktop ? 140 : isTablet ? 120 : 110,
                  maxWidth: isDesktop ? 200 : isTablet ? 160 : 140,
                  minHeight: isDesktop ? 40 : isTablet ? 36 : 34,
                ),
                child: EventouryElevatedButton(
                  onPressed: () => controller.onEventTap(event['title']),
                  borderRadius: BorderRadius.circular(isDesktop ? 18 : isTablet ? 16 : 14),
                  padding: EdgeInsets.symmetric(horizontal: isDesktop ? 14 : isTablet ? 12 : 10, vertical: isDesktop ? 10 : isTablet ? 9 : 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${event['price']} / Person',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: isDesktop ? 14 : isTablet ? 13 : 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );

  }
}
